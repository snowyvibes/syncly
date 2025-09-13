import 'package:drift/drift.dart';
import 'package:syncly/features/tasks/data/sources/local/drift.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart' as domain;

extension TaskToDomain on Task {
  domain.Task toDomain() {
    return domain.Task(
      id: id,
      title: title,
      description: description,
      isCompleted: isCompleted,
      createdAt: createdAt,
      dueDate: dueDate,
      category: category,
    );
  }
}

extension DomainTaskToCompanion on domain.Task {
  TasksCompanion toCompanion() {
    return TasksCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description ?? ''),
      isCompleted: Value(isCompleted),
      createdAt: Value(createdAt),
      dueDate: Value(dueDate),
      category: Value(category),
    );
  }
}

extension DomainTaskToTask on domain.Task {
  Task toTask() {
    return Task(
      id: id,
      title: title,
      description: description ?? '',
      isCompleted: isCompleted,
      createdAt: createdAt,
      dueDate: dueDate,
      category: category,
    );
  }
}
