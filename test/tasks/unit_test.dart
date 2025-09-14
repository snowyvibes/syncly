import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:syncly/features/tasks/presentation/providers/tasks_list_provider.dart';

void main() {
  group('Task Model Tests', () {
    test('should create a task with required properties', () {
      final task = Task(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        createdAt: DateTime.now(),
      );

      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.isCompleted, false);
      expect(task.createdAt, isA<DateTime>());
    });

    test('should mark task as completed', () {
      final task = Task(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        createdAt: DateTime.now(),
      );

      final completedTask = task.copyWith(isCompleted: true);

      expect(completedTask.isCompleted, true);
      expect(completedTask.id, task.id);
      expect(completedTask.title, task.title);
    });

    test('should convert task to JSON', () {
      final task = Task(
        id: '1',
        title: 'Test Task',
        description: 'Test Description',
        createdAt: DateTime(2023),
      );

      final json = task.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Test Task');
      expect(json['description'], 'Test Description');
      expect(json['isCompleted'], false);
      expect(json['createdAt'], isA<String>());
    });

    test('should create task from JSON', () {
      final json = {
        'id': '1',
        'title': 'Test Task',
        'description': 'Test Description',
        'isCompleted': false,
        'createdAt': '2023-01-01T00:00:00.000',
      };

      final task = Task.fromJson(json);

      expect(task.id, '1');
      expect(task.title, 'Test Task');
      expect(task.description, 'Test Description');
      expect(task.isCompleted, false);
      expect(task.createdAt, DateTime(2023));
    });
  });

  group('TaskListNotifier Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should have initial tasks', () {
      final tasks = container.read(tasksListProvider);

      expect(tasks.isNotEmpty, true);
      // based on the num of tasks i have during testing, gonna change this later
      expect(tasks.length, 13);
    });

    test('should add a new task', () {
      final notifier = container.read(tasksListProvider.notifier);
      final initialCount = container.read(tasksListProvider).length;

      notifier.addTask(
        title: 'New Test Task',
        description: 'Test Description',
        dueDate: DateTime.now(),
      );

      final tasks = container.read(tasksListProvider);
      expect(tasks.length, initialCount + 1);
      expect(tasks.last.title, 'New Test Task');
      expect(tasks.last.description, 'Test Description');
    });

    test('should toggle task completion', () {
      final notifier = container.read(tasksListProvider.notifier);
      final tasks = container.read(tasksListProvider);
      final firstTask = tasks.first;
      final originalStatus = firstTask.isCompleted;

      notifier.toggleTask(firstTask.id);

      final updatedTasks = container.read(tasksListProvider);
      final updatedTask = updatedTasks.firstWhere((task) => task.id == firstTask.id);

      expect(updatedTask.isCompleted, !originalStatus);
    });

    test('should update existing task', () {
      final notifier = container.read(tasksListProvider.notifier);
      final tasks = container.read(tasksListProvider);
      final firstTask = tasks.first;

      final updatedTask = firstTask.copyWith(
        title: 'Updated Task Title',
        isCompleted: true,
      );

      notifier.updateTask(updatedTask);

      final updatedTasks = container.read(tasksListProvider);
      final result = updatedTasks.firstWhere((task) => task.id == firstTask.id);

      expect(result.title, 'Updated Task Title');
      expect(result.isCompleted, true);
    });

    test('should delete task', () {
      final notifier = container.read(tasksListProvider.notifier);
      final tasks = container.read(tasksListProvider);
      final taskToDelete = tasks.first;
      final initialCount = tasks.length;

      notifier.deleteTask(taskToDelete.id);

      final updatedTasks = container.read(tasksListProvider);
      expect(updatedTasks.length, initialCount - 1);
      expect(
        updatedTasks.any((task) => task.id == taskToDelete.id),
        false,
      );
    });

    test('should move completed task to end when toggled', () {
      final notifier = container.read(tasksListProvider.notifier);
      final tasks = container.read(tasksListProvider);
      final firstTask = tasks.first;

      if (firstTask.isCompleted) {
        notifier.toggleTask(firstTask.id);
      }

      notifier.toggleTask(firstTask.id);

      final updatedTasks = container.read(tasksListProvider);
      expect(updatedTasks.last.id, firstTask.id);
      expect(updatedTasks.last.isCompleted, true);
    });

    test('should move incomplete task to beginning when toggled back', () {
      final notifier = container.read(tasksListProvider.notifier);

      notifier.addTask(
        title: 'Completed Task',
        description: 'Description',
        dueDate: DateTime.now(),
      );

      final tasks = container.read(tasksListProvider);
      final newTask = tasks.last;

      notifier.toggleTask(newTask.id);

      notifier.toggleTask(newTask.id);

      final updatedTasks = container.read(tasksListProvider);
      expect(updatedTasks.first.id, newTask.id);
      expect(updatedTasks.first.isCompleted, false);
    });
  });

  group('Task Provider Filters Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should filter overdue tasks correctly', () {
      final overdueTasks = container.read(overdueTasksProvider);

      expect(overdueTasks.isNotEmpty, true);
      for (final task in overdueTasks) {
        expect(task.isCompleted, false);
        expect(task.dueDate, isNotNull);
        expect(task.dueDate!.isBefore(DateTime.now()), true);
      }
    });

    test('should filter today tasks correctly', () {
      final todaysTasks = container.read(todaysTaskProvider);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      expect(todaysTasks.isNotEmpty, true);
      for (final task in todaysTasks) {
        if (task.dueDate != null) {
          final taskDate = DateTime(
            task.dueDate!.year,
            task.dueDate!.month,
            task.dueDate!.day,
          );
          expect(taskDate, today);
        }
      }
    });

    test('should filter upcoming tasks correctly', () {
      final upcomingTasks = container.read(upcomingTasksProvider);

      expect(upcomingTasks.isNotEmpty, true);
      for (final task in upcomingTasks) {
        expect(task.dueDate, isNotNull);
        expect(task.dueDate!.isAfter(DateTime.now()), true);
      }
    });

    test('should update filters when task is added', () {
      final notifier = container.read(tasksListProvider.notifier);
      final initialOverdueCount = container.read(overdueTasksProvider).length;

      notifier.addTask(
        title: 'Overdue Task',
        description: 'This is overdue',
        dueDate: DateTime.now().subtract(const Duration(days: 1)),
      );

      final updatedOverdueCount = container.read(overdueTasksProvider).length;
      expect(updatedOverdueCount, initialOverdueCount + 1);
    });

    test('should update filters when task is completed', () {
      final notifier = container.read(tasksListProvider.notifier);
      final initialOverdueTasks = container.read(overdueTasksProvider);

      if (initialOverdueTasks.isNotEmpty) {
        final overdueTask = initialOverdueTasks.first;
        final initialCount = initialOverdueTasks.length;

        notifier.toggleTask(overdueTask.id);

        final updatedOverdueCount = container.read(overdueTasksProvider).length;
        expect(updatedOverdueCount, initialCount - 1);
      }
    });
  });

  group('Date Provider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should have initial selected date as today', () {
      final selectedDate = container.read(selectedDateProvider);
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final selected = DateTime(
        selectedDate.year,
        selectedDate.month,
        selectedDate.day,
      );

      expect(selected, today);
    });

    test('should update selected date', () {
      final notifier = container.read(selectedDateProvider.notifier);
      final newDate = DateTime(2025, 12, 25);

      notifier.state = newDate;

      final updatedDate = container.read(selectedDateProvider);
      expect(updatedDate, newDate);
    });

    test('should filter tasks by selected date', () {
      final notifier = container.read(selectedDateProvider.notifier);
      final taskNotifier = container.read(tasksListProvider.notifier);

      final testDate = DateTime(2025, 12, 25);
      notifier.state = testDate;

      taskNotifier.addTask(
        title: 'Christmas Task',
        description: 'Prepare for Christmas',
        dueDate: testDate,
      );

      final filteredTasks = container.read(targetDateTasksProvider);
      final christmasTask = filteredTasks.firstWhere(
        (task) => task.title == 'Christmas Task',
      );

      expect(christmasTask.title, 'Christmas Task');
    });
  });
}
