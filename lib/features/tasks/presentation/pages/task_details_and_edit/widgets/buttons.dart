import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/custom_outlined_button.dart';
import 'package:syncly/core/widgets/filled_button.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/presentation/providers/task_details_provider.dart';
import 'package:syncly/features/tasks/presentation/providers/tasks_provider.dart';

class EditTaskButtons extends ConsumerWidget {
  const EditTaskButtons({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editTaskDate = ref.watch(editTaskDateProvider);
    final editTaskDateNotifier = ref.read(editTaskDateProvider.notifier);
    final editTaskTime = ref.watch(editTaskTimeProvider);
    final editTaskTimeNotifier = ref.read(editTaskTimeProvider.notifier);
    final editTaskCategory = ref.watch(editTaskCategoryProvider);
    final editTaskCategoryNotifier = ref.read(editTaskCategoryProvider.notifier);

    return Padding(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: AppSizes.rowSpacing,
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: 'Delete',
              color: Colors.red,
              onPressed: () {
                _showDeleteDialog(context, ref);
              },
            ),
          ),
          Expanded(
            child: CustomOutlinedButton(
              text: 'Cancel',
              onPressed: () {
                // Reset providers and go back
                editTaskDateNotifier.state = null;
                editTaskTimeNotifier.state = null;
                editTaskCategoryNotifier.state = null;
                Navigator.pop(context);
              },
            ),
          ),
          Expanded(
            child: CustomFilledButton(
              text: 'Save',
              onPressed: () {
                _saveTask(context, ref, editTaskDate, editTaskTime, editTaskCategory);
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: const Text('Are you sure you want to delete this task?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(tasksListProvider.notifier).deleteTask(task.id);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _saveTask(
    BuildContext context,
    WidgetRef ref,
    DateTime? date,
    DateTime? time,
    String? category,
  ) {
    // Update the task in your provider
    ref
        .read(tasksListProvider.notifier)
        .updateTask(
          task.copyWith(
            dueDate: date,
            dueTime: time,
            category: category,
          ),
        );

    // Reset providers
    ref.read(editTaskDateProvider.notifier).state = null;
    ref.read(editTaskTimeProvider.notifier).state = null;
    ref.read(editTaskCategoryProvider.notifier).state = null;

    Navigator.pop(context);
  }
}
