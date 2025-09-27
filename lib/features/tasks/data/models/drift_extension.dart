import 'package:drift/drift.dart';
import 'package:syncly/database/local/drift_database.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';

extension TasksDataMapper on TaskTableData {
  Task toDomain() {
    return Task(
      id: id,
      title: title,
      description: description,
      dueDate: dueDate,
      dueTime: dueTime,
      createdAt: createdAt,
      category: category,
      isCompleted: isCompleted,
    );
  }
}

extension TaskMapper on Task {
  TaskTableCompanion toCompanion({bool nullToAbsent = true}) {
    return TaskTableCompanion(
      id: Value(id),
      title: Value(title),
      description: nullToAbsent && description == null
          ? const Value.absent()
          : Value(description ?? ''),
      dueDate: nullToAbsent && dueDate == null ? const Value.absent() : Value(dueDate),
      dueTime: nullToAbsent && dueTime == null ? const Value.absent() : Value(dueTime),
      createdAt: Value(createdAt),
      category: nullToAbsent && category == null ? const Value.absent() : Value(category ?? ''),
      isCompleted: Value(isCompleted),
    );
  }

  TaskTableData toDriftModel() {
    return TaskTableData(
      id: id,
      title: title,
      description: description ?? '',
      dueDate: dueDate,
      dueTime: dueTime,
      createdAt: createdAt,
      category: category ?? '',
      isCompleted: isCompleted,
    );
  }
}
