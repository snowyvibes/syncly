import 'package:drift/drift.dart';
import 'package:syncly/features/tasks/data/models/task_table.dart';

import '../../../../../database/local/drift_database.dart';

part 'task_dao.g.dart';

@DriftAccessor(tables: [TaskTable])
class TaskDao extends DatabaseAccessor<AppDatabase> with _$TaskDaoMixin {
  TaskDao(super.db);

  Future<List<TaskTableData>> getAllTasks() => select(taskTable).get();

  Stream<List<TaskTableData>> watchAllTasks() => select(taskTable).watch();

  Future<void> insertTask(Insertable<TaskTableData> task) => into(taskTable).insert(task);

  Future<void> updateTask(Insertable<TaskTableData> task) => update(taskTable).replace(task);

  Future<void> deleteTask(String id) => (delete(taskTable)..where((t) => t.id.equals(id))).go();

  Future<List<TaskTableData>> getCompletedTasks() {
    return (select(taskTable)..where((t) => t.isCompleted.equals(true))).get();
  }

  Future<List<TaskTableData>> getOverdueTasks() {
    final now = DateTime.now();
    return (select(taskTable)..where(
          (t) =>
              t.isCompleted.equals(false) &
              t.dueDate.isNotNull() &
              t.dueDate.isSmallerThanValue(now),
        ))
        .get();
  }

  Future<List<TaskTableData>> getTodaysTasks() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return (select(taskTable)..where(
          (t) =>
              t.dueDate.isNotNull() &
              t.dueDate.isBiggerOrEqualValue(startOfDay) &
              t.dueDate.isSmallerOrEqualValue(endOfDay),
        ))
        .get();
  }

  Future<List<TaskTableData>> getUpcomingTasks() {
    final now = DateTime.now();
    return (select(taskTable)..where(
          (t) =>
              t.dueDate.isNotNull() &
              t.dueDate.isBiggerThanValue(now) &
              t.isCompleted.equals(false),
        ))
        .get();
  }

  Future<List<TaskTableData>> getTasksByCategory(String category) {
    return (select(taskTable)..where((t) => t.category.equals(category))).get();
  }

  Future<List<String>> getAllCategories() async {
    final query = selectOnly(taskTable)..addColumns([taskTable.category]);
    final results = await query.get();
    final categories = results.map((row) => row.read(taskTable.category)).toSet().toList();
    return categories.whereType<String>().toList();
  }
}
