import 'package:syncly/features/tasks/domain/entities/task.dart';

abstract class TasksRepository {
  Future<List<Task>> getAllTasks();
  Future<List<Task>> getCompletedTasks();
  // Future<List<Task>> getPendingTasks();
  Future<List<Task>> getOverdueTasks();
  Future<List<Task>> getTodaysTasks();
  Future<List<Task>> getUpcomingTasks();
  // Future<List<Task>> getTasksByDate(DateTime date);
  // Future<Task?> getTaskById(String id);
  Future<void> addTask(Task task);
  Future<void> updateTask(Task task);
  Future<void> deleteTask(String id);
  // Future<List<String>> getAllCategories();
  // Future<List<Task>> getTasksByCategory(String category);
  // Future<List<Task>> searchTasks(String searchTerm);
  // Future<int> countTasksByCategory(String category);
  // Future<int> countCompletedTasks();
  // Future<int> countPendingTasks();
}
