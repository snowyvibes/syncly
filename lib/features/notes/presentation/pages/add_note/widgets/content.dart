import 'package:flutter/material.dart';
import 'package:syncly/core/widgets/text_field.dart';
import 'package:syncly/core/widgets/title.dart';

class AddNoteContent extends StatelessWidget {
  const AddNoteContent({
    super.key,
    required TextEditingController contentController,
  }) : _contentController = contentController;

  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const SectionTitle('Content'),
        CustomTextField(
          controller: _contentController,
          hintText: 'Write your note here...',
          maxLines: 10,
          validator: (value) {
            if (value?.isEmpty ?? true) {
              return 'Please enter note content';
            }
            return null;
          },
        ),
      ],
    );
  }
}
