import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/custom_outlined_button.dart';
import 'package:syncly/core/widgets/filled_button.dart';
import 'package:syncly/features/tasks/presentation/providers/add_task_provider.dart';
import 'package:syncly/features/tasks/presentation/providers/tasks_list_provider.dart';

class AddTaskButtons extends ConsumerWidget {
  const AddTaskButtons({
    super.key,
    required TextEditingController titleController,
    required TextEditingController descriptionController,
    required GlobalKey<FormState> formKey,
  }) : _titleController = titleController,
       _descriptionController = descriptionController,
       _formKey = formKey;

  final TextEditingController _titleController;
  final TextEditingController _descriptionController;
  final GlobalKey<FormState> _formKey;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksProviderNotifier = ref.read(tasksListProvider.notifier);
    final taskCategory = ref.watch(addTaskCategoryProvider);
    final taskDate = ref.watch(addTaskDateProvider);
    final taskTime = ref.watch(addTaskTimeProvider);

    return Row(
      spacing: AppSizes.rowSpacing,
      children: [
        Expanded(
          child: CustomOutlinedButton(
            onPressed: () {
              _titleController.clear();
              _titleController.dispose();
              _descriptionController.clear();
              _descriptionController.dispose();
              Navigator.pop(context);
            },
            text: 'Cancel',
          ),
        ),
        Expanded(
          child: CustomFilledButton(
            onPressed: () {
              if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                tasksProviderNotifier.addTask(
                  title: _titleController.text,
                  description: _descriptionController.text,
                  category: taskCategory,
                  dueDate: taskDate,
                  dueTime: taskTime,
                );
                Navigator.pop(context);
              }
            },
            text: 'Add Task',
          ),
        ),
      ],
    );
  }
}
