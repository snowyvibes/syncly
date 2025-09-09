import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/filled_button.dart';
import 'package:syncly/core/widgets/text_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({super.key});

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _addTask() {
    if (_formKey.currentState?.validate() ?? false) {
      // Handle task creation logic here
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) => Form(
    key: _formKey,
    child: Padding(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSizes.columnSpacing,
        children: [
          Text(
            'Add Task',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          CustomTextField(
            controller: _titleController,
            hintText: 'Task title',
            validator: (value) {
              if (value?.isEmpty ?? true) {
                return 'Please enter a task title';
              }
              return null;
            },
          ),
          CustomTextField(
            controller: _descriptionController,
            hintText: 'Task description (optional)',
            maxLines: 3,
          ),
          Row(
            spacing: AppSizes.rowSpacing,
            children: [
              Expanded(
                child: CustomFilledButton(
                  onPressed: () => Navigator.pop(context),
                  text: 'Cancel',
                ),
              ),
              Expanded(
                child: CustomFilledButton(
                  onPressed: _addTask,
                  text: 'Add Task',
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}
