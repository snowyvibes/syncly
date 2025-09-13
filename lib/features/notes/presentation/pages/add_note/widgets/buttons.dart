import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/custom_outlined_button.dart';
import 'package:syncly/core/widgets/filled_button.dart';
import 'package:syncly/features/notes/presentation/providers/add_note_provider.dart';
import 'package:syncly/features/notes/presentation/providers/notes_provider.dart';

class AddNoteButtons extends ConsumerWidget {
  const AddNoteButtons({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController titleController,
    required TextEditingController contentController,
  }) : _formKey = formKey,
       _titleController = titleController,
       _contentController = contentController;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _titleController;
  final TextEditingController _contentController;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesProviderNotifier = ref.read(notesListProvider.notifier);
    final addNoteFolder = ref.watch(addNoteFolderProvider);

    return Row(
      spacing: AppSizes.rowSpacing,
      children: [
        Expanded(
          child: CustomOutlinedButton(
            onPressed: () => Navigator.pop(context),
            text: 'Cancel',
          ),
        ),
        Expanded(
          child: CustomFilledButton(
            onPressed: () {
              if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                notesProviderNotifier.addNote(
                  title: _titleController.text,
                  content: _contentController.text,
                  folder: addNoteFolder ?? 'Others',
                );
                Navigator.pop(context);
              }
            },
            text: 'Add Note',
          ),
        ),
      ],
    );
  }
}
