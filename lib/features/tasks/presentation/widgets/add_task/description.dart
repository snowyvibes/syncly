import 'package:flutter/material.dart';
import 'package:syncly/core/widgets/text_field.dart';
import 'package:syncly/core/widgets/title.dart';

class AddTaskDescription extends StatelessWidget {
  const AddTaskDescription({super.key, required TextEditingController descriptionController})
    : _descriptionController = descriptionController;

  final TextEditingController _descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Description'),
        CustomTextField(
          controller: _descriptionController,
          hintText: 'Task description (optional)',
          maxLines: 3,
        ),
      ],
    );
  }
}
