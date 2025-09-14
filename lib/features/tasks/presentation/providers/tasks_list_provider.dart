import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/features/tasks/data/repositories_impl/tasks_repo_impl.dart';
import 'package:syncly/database/local/drift_database.dart';
import 'package:syncly/features/tasks/data/sources/local/task_dao.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/domain/repositories/tasks_repository.dart';

// Database provider
final tasksDatabaseProvider = Provider<TaskDao>((ref) {
  return TaskDao(AppDatabase());
});

// Repository provider
final tasksRepositoryProvider = Provider<TasksRepository>((ref) {
  final database = ref.watch(tasksDatabaseProvider);
  return TasksRepositoryImpl(database);
});

// Main tasks provider
final tasksListProvider = NotifierProvider<TasksNotifier, List<Task>>(TasksNotifier.new);

// Filtered providers
final overdueTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksListProvider);
  final now = DateTime.now();
  return tasks
      .where((task) => !task.isCompleted && task.dueDate != null && task.dueDate!.isBefore(now))
      .toList();
});

final todaysTaskProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksListProvider);
  final now = DateTime.now();
  return tasks
      .where((task) => task.dueDate != null && DateTimeHandler.isSameDate(task.dueDate!, now))
      .toList();
});

final upcomingTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksListProvider);
  final now = DateTime.now();
  return tasks
      .where(
        (task) =>
            task.dueDate != null &&
            task.dueDate!.isAfter(now) &&
            !DateTimeHandler.isSameDate(task.dueDate!, now),
      )
      .toList();
});

final completedTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksListProvider);
  return tasks.where((task) => task.isCompleted).toList();
});

final pendingTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksListProvider);
  return tasks.where((task) => !task.isCompleted).toList();
});

class TasksNotifier extends Notifier<List<Task>> {
  late TasksRepository _repository;

  @override
  List<Task> build() {
    _repository = ref.read(tasksRepositoryProvider);
    _loadTasks();
    return [];
  }

  Future<void> _loadTasks() async {
    final tasks = await _repository.getAllTasks();

    if (tasks.isEmpty) {
      final updatedTasks = await _repository.getAllTasks();
      state = updatedTasks;
    } else {
      state = tasks;
    }
  }

  Future<void> addTask({
    required String title,
    required String description,
    DateTime? dueDate,
    DateTime? dueTime,
    String? category,
  }) async {
    final newTask = Task(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      dueDate: dueDate,
      dueTime: dueTime,
      category: category,
      createdAt: DateTime.now(),
    );

    await _repository.addTask(newTask);
    await _loadTasks(); // Refresh the state
  }

  Future<void> updateTask(Task updatedTask) async {
    await _repository.updateTask(updatedTask);
    await _loadTasks(); // Refresh the state
  }

  Future<void> toggleTask(String id) async {
    final task = state.firstWhere((task) => task.id == id);
    final updatedTask = task.copyWith(isCompleted: !task.isCompleted);

    await _repository.updateTask(updatedTask);
    await _loadTasks(); // Refresh the state
  }

  Future<void> deleteTask(String id) async {
    await _repository.deleteTask(id);
    await _loadTasks(); // Refresh the state
  }

  // Future<List<Task>> searchTasks(String searchTerm) async {
  //   return await _repository.searchTasks(searchTerm);
  // }

  // Future<List<String>> getAllCategories() async {
  //   return await _repository.getAllCategories();
  // }
}
