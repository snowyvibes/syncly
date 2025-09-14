import 'package:syncly/features/tasks/data/repositories_impl/drift_extension.dart';
import 'package:syncly/features/tasks/data/sources/local/task_dao.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/domain/repositories/tasks_repository.dart';

class TasksRepositoryImpl implements TasksRepository {
  final TaskDao _database;

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
  Future<void> addTask(Task task) async {
    await _database.insertTask(task.toCompanion());
  }

  @override
  Future<void> updateTask(Task task) async {
    await _database.updateTask(task.toCompanion());
  }

  @override
  Future<void> deleteTask(String id) async {
    await _database.deleteTask(id);
  }
}
