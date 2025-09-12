import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';

final addTaskCategoryProvider = StateProvider<String?>((ref) => null);

class AddTaskProvider extends Notifier<Task> {
  @override
  Task build() {
    return Task(
      id: '',
      title: '',
      description: '',
      createdAt: DateTime.now(),
    );
  }
}
