import 'package:syncly/features/tasks/data/repositories_impl/drift_extensions.dart';
import 'package:syncly/features/tasks/data/sources/local/drift.dart' hide Task;
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TasksDatabase _database;

  TasksRepositoryImpl(this._database);

  @override
  Future<List<Task>> getAllTasks() async {
    final driftTasks = await _database.getAllTasks();
    return driftTasks.map((task) => task.toDomain()).toList();
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    final driftTasks = await _database.getCompletedTasks();
    return driftTasks.map((task) => task.toDomain()).toList();
  }

  @override
  Future<List<Task>> getPendingTasks() async {
    final driftTasks = await _database.getPendingTasks();
    return driftTasks.map((task) => task.toDomain()).toList();
  }

  @override
  Future<List<Task>> getOverdueTasks() async {
    final driftTasks = await _database.getOverdueTasks();
    return driftTasks.map((task) => task.toDomain()).toList();
  }

  @override
  Future<List<Task>> getTodaysTasks() async {
    final driftTasks = await _database.getTodaysTasks();
    return driftTasks.map((task) => task.toDomain()).toList();
  }

  @override
  Future<List<Task>> getUpcomingTasks() async {
    final driftTasks = await _database.getUpcomingTasks();
    return driftTasks.map((task) => task.toDomain()).toList();
  }

  @override
  Future<List<Task>> getTasksByDate(DateTime date) async {
    final driftTasks = await _database.getTasksByDate(date);
    return driftTasks.map((task) => task.toDomain()).toList();
  }

  @override
  Future<Task?> getTaskById(String id) async {
    final driftTask = await _database.getTaskById(id);
    return driftTask?.toDomain();
  }

  @override
  Future<void> addTask(Task task) async {
    await _database.insertTask(task.toCompanion());
  }

  @override
  Future<void> updateTask(Task task) async {
    await _database.updateTask(task.toTask());
  }

  @override
  Future<void> deleteTask(String id) async {
    await _database.deleteTask(id);
  }

  @override
  Future<List<String>> getAllCategories() async {
    return await _database.getAllCategories();
  }

  @override
  Future<List<Task>> getTasksByCategory(String category) async {
    final driftTasks = await _database.getTasksByCategory(category);
    return driftTasks.map((task) => task.toDomain()).toList();
  }

  @override
  Future<List<Task>> searchTasks(String searchTerm) async {
    final driftTasks = await _database.searchTasks(searchTerm);
    return driftTasks.map((task) => task.toDomain()).toList();
  }

  @override
  Future<int> countTasksByCategory(String category) async {
    return await _database.countTasksByCategory(category);
  }

  @override
  Future<int> countCompletedTasks() async {
    return await _database.countCompletedTasks();
  }

  @override
  Future<int> countPendingTasks() async {
    return await _database.countPendingTasks();
  }
}
