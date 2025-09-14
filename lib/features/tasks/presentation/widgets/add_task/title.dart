import 'package:flutter/material.dart';
import 'package:syncly/core/widgets/text_field.dart';
import 'package:syncly/core/widgets/title.dart';

class AddTaskTitle extends StatelessWidget {
  const AddTaskTitle({super.key, required TextEditingController titleController})
    : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Title'),
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
      ],
    );
  }
}
