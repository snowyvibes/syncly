import 'package:flutter/material.dart';
import 'package:syncly/core/widgets/text_field.dart';
import 'package:syncly/core/widgets/title.dart';

class AddNoteTitle extends StatelessWidget {
  const AddNoteTitle({
    super.key,
    required TextEditingController titleController,
  }) : _titleController = titleController;

  final TextEditingController _titleController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const SectionTitle('Title'),
        CustomTextField(
          controller: _titleController,
          hintText: 'Note title',
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter a note title';
            }
            return null;
          },
        ),
      ],
    );
  }
}
