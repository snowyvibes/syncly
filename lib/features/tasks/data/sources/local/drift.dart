import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'drift.g.dart';

class Tasks extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  BoolColumn get isCompleted => boolean().withDefault(const Constant(false))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get dueDate => dateTime().nullable()();
  TextColumn get category => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Tasks])
class TasksDatabase extends _$TasksDatabase {
  TasksDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Task>> getAllTasks() =>
      (select(tasks)..orderBy([(task) => OrderingTerm.asc(task.isCompleted)])).get();

  Future<List<Task>> getCompletedTasks() =>
      (select(tasks)..where((task) => task.isCompleted.equals(true))).get();

  Future<List<Task>> getPendingTasks() =>
      (select(tasks)..where((task) => task.isCompleted.equals(false))).get();

  Future<List<Task>> getOverdueTasks() {
    final now = DateTime.now();
    return (select(tasks)..where(
          (task) =>
              task.isCompleted.equals(false) &
              task.dueDate.isNotNull() &
              task.dueDate.isSmallerThanValue(now),
        ))
        .get();
  }

  Future<List<Task>> getTodaysTasks() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(tasks)..where(
          (task) =>
              task.dueDate.isNotNull() &
              task.dueDate.isBiggerOrEqualValue(startOfDay) &
              task.dueDate.isSmallerThanValue(endOfDay),
        ))
        .get();
  }

  Future<List<Task>> getUpcomingTasks() {
    final now = DateTime.now();
    return (select(tasks)
          ..where((task) => task.dueDate.isNotNull() & task.dueDate.isBiggerThanValue(now))
          ..orderBy([(task) => OrderingTerm.asc(task.dueDate)]))
        .get();
  }

  Future<List<Task>> getTasksByDate(DateTime date) {
    final startOfDay = DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    return (select(tasks)..where(
          (task) =>
              task.dueDate.isNotNull() &
              task.dueDate.isBiggerOrEqualValue(startOfDay) &
              task.dueDate.isSmallerThanValue(endOfDay),
        ))
        .get();
  }

  Future<Task?> getTaskById(String id) =>
      (select(tasks)..where((task) => task.id.equals(id))).getSingleOrNull();

  Future<int> insertTask(TasksCompanion task) => into(tasks).insert(task);

  Future<bool> updateTask(Task task) => update(tasks).replace(task);

  Future<int> deleteTask(String id) => (delete(tasks)..where((task) => task.id.equals(id))).go();

  Future<List<Task>> getTasksByCategory(String categoryName) =>
      (select(tasks)..where((task) => task.category.equals(categoryName))).get();

  Future<List<String>> getAllCategories() async {
    final query = selectOnly(tasks, distinct: true)
      ..addColumns([tasks.category])
      ..where(tasks.category.isNotNull());

    final results = await query.get();
    return results.map((row) => row.read(tasks.category)!).toList();
  }

  Future<List<Task>> searchTasks(String searchTerm) {
    final lowerSearchTerm = searchTerm.toLowerCase();
    return (select(tasks)
          ..where(
            (task) =>
                task.title.lower().contains(lowerSearchTerm) |
                task.description.lower().contains(lowerSearchTerm),
          )
          ..orderBy([(task) => OrderingTerm.desc(task.createdAt)]))
        .get();
  }

  Future<int> countTasksByCategory(String categoryName) async {
    final query = selectOnly(tasks)
      ..addColumns([tasks.id.count()])
      ..where(tasks.category.equals(categoryName));

    final result = await query.getSingle();
    return result.read(tasks.id.count()) ?? 0;
  }

  Future<int> countCompletedTasks() async {
    final query = selectOnly(tasks)
      ..addColumns([tasks.id.count()])
      ..where(tasks.isCompleted.equals(true));

    final result = await query.getSingle();
    return result.read(tasks.id.count()) ?? 0;
  }

  Future<int> countPendingTasks() async {
    final query = selectOnly(tasks)
      ..addColumns([tasks.id.count()])
      ..where(tasks.isCompleted.equals(false));

    final result = await query.getSingle();
    return result.read(tasks.id.count()) ?? 0;
  }

  Future<List<Task>> getTasksOrderedByDueDate() =>
      (select(tasks)..orderBy([
            (task) => OrderingTerm(
              expression: task.dueDate,
              mode: OrderingMode.asc,
              nulls: NullsOrder.last,
            ),
            (task) => OrderingTerm.asc(task.createdAt),
          ]))
          .get();

  Future<List<Task>> getRecentTasks() {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return (select(tasks)
          ..where((task) => task.createdAt.isBiggerThanValue(weekAgo))
          ..orderBy([(task) => OrderingTerm.desc(task.createdAt)]))
        .get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'tasks.db'));
    return NativeDatabase.createInBackground(file);
  });
}
