import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:table_calendar/table_calendar.dart';

final tasksListProvider = NotifierProvider<TaskListNotifier, List<Task>>(TaskListNotifier.new);

final overdueTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksListProvider);
  return tasks
      .where(
        (task) =>
            !task.isCompleted &&
            task.dueDate != null &&
            DateTimeHandler.isBeforeToday(task.dueDate!),
      )
      .toList();
});

final todaysTaskProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksListProvider);
  return tasks
      .where((task) => task.dueDate == null || DateTimeHandler.isToday(task.dueDate!))
      .toList();
});

final upcomingTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksListProvider);

  return tasks
      .where((task) => task.dueDate != null && DateTimeHandler.isAfterToday(task.dueDate!))
      .toList();
});

final targetDateTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksListProvider);

  return tasks
      .where(
        (task) =>
            task.dueDate == null ||
            DateTimeHandler.isSameDate(task.dueDate!, ref.watch(selectedDateProvider)),
      )
      .toList();
});

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final focusedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

final calendarFormatProvider = StateProvider<CalendarFormat>((ref) => CalendarFormat.week);

class TaskListNotifier extends Notifier<List<Task>> {
  @override
  List<Task> build() => [
    Task(
      id: '0',
      title: 'Push code to GitHub',
      description: 'Push the recent changes to the remote repository',
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      createdAt: DateTime.now(),
    ),
    Task(
      id: '1',
      title: 'Get groceries',
      description: 'Buy milk, eggs, and bread',
      dueDate: DateTime.now(),
      createdAt: DateTime.now(),
    ),
    // Overdue tasks
    Task(
      id: '2',
      title: 'Complete project proposal',
      description: 'Finish the quarterly project proposal document',
      dueDate: DateTime.now().subtract(const Duration(days: 3)),
      createdAt: DateTime.now(),
    ),
    Task(
      id: '3',
      title: 'Call dentist',
      description: 'Schedule annual cleaning appointment',
      dueDate: DateTime.now().subtract(const Duration(days: 2)),
      createdAt: DateTime.now(),
    ),
    Task(
      id: '4',
      title: 'Pay electricity bill',
      description: 'Monthly utility payment due',
      dueDate: DateTime.now().subtract(const Duration(days: 5)),
      createdAt: DateTime.now(),
    ),
    Task(
      id: '5',
      title: 'Review code changes',
      description: 'Review pull requests from team members',
      dueDate: DateTime.now().subtract(const Duration(days: 1)),
      createdAt: DateTime.now(),
    ),
    // Today's tasks
    Task(
      id: '6',
      title: 'Team meeting',
      description: 'Weekly standup with development team',
      dueDate: DateTime.now(),
      createdAt: DateTime.now(),
    ),
    Task(
      id: '7',
      title: 'Update documentation',
      description: 'Update API documentation with recent changes',
      dueDate: DateTime.now(),
      createdAt: DateTime.now(),
    ),
    Task(
      id: '8',
      title: 'Fix login bug',
      description: 'Resolve authentication issue reported by users',
      dueDate: DateTime.now(),
      createdAt: DateTime.now(),
    ),
    // Upcoming tasks
    Task(
      id: '9',
      title: 'Prepare presentation',
      description: 'Create slides for client meeting',
      dueDate: DateTime.now().add(const Duration(days: 2)),
      createdAt: DateTime.now(),
    ),
    Task(
      id: '10',
      title: 'Database backup',
      description: 'Perform weekly database backup',
      dueDate: DateTime.now().add(const Duration(days: 3)),
      createdAt: DateTime.now(),
    ),
    Task(
      id: '11',
      title: 'Plan vacation',
      description: 'Book flights and accommodation for summer trip',
      dueDate: DateTime.now().add(const Duration(days: 7)),
      createdAt: DateTime.now(),
    ),
    Task(
      id: '12',
      title: 'Something',
      description: 'Something',
      dueDate: DateTime.now().add(const Duration(days: 1)),
      createdAt: DateTime.now(),
    ),
  ];

  void addTask({
    required String title,
    String? description,
    DateTime? dueDate,

    DateTime? dueTime,
    String? category,
  }) {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description ?? '',
      dueDate: dueDate,
      dueTime: dueTime,
      createdAt: DateTime.now(),
      category: category,
    );
    state = [...state, newTask];
  }

  void toggleTask(String id) {
    final Task task = state.firstWhere((task) => task.id == id);
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);

    List<Task> updatedList = [];

    final List<Task> rest = [
      for (Task task in state)
        if (task.id != id) task,
    ];

    if (!task.isCompleted) {
      updatedList = [
        ...rest,
        updatedTask,
      ];
    } else {
      updatedList = [
        updatedTask,
        ...rest,
      ];
    }

    state = updatedList;
  }

  void updateTask(Task updatedTask) {
    state = [
      for (final task in state)
        if (task.id == updatedTask.id) updatedTask else task,
    ];
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}
