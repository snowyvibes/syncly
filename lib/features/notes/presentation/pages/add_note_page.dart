import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/custom_outlined_button.dart';
import 'package:syncly/core/widgets/filled_button.dart';
import 'package:syncly/core/widgets/text_field.dart';
import 'package:syncly/features/notes/presentation/providers/notes_provider.dart';

class AddNotePage extends ConsumerWidget {
  AddNotePage({super.key});

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _selectedFolder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesProviderNotifier = ref.read(notesListProvider.notifier);

    return Form(
      key: _formKey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSizes.columnSpacing,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Note',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: AppSizes.columnSpacing,
                    children: [
                      Text('Title', style: Theme.of(context).textTheme.titleSmall),
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
                      Text('Content', style: Theme.of(context).textTheme.titleSmall),
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
                      Text('Folder', style: Theme.of(context).textTheme.titleSmall),
                      NoteFolderPicker(
                        selectedFolder: _selectedFolder,
                        onFolderSelected: (folder) {
                          _selectedFolder = folder;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Row(
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
                            folder: _selectedFolder ?? 'Others',
                          );
                        }
                      },
                      text: 'Add Note',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class NoteFolderPicker extends StatelessWidget {
  final String? selectedFolder;
  final ValueChanged<String> onFolderSelected;

  const NoteFolderPicker({
    super.key,
    required this.selectedFolder,
    required this.onFolderSelected,
  });

  final List<String> folders = const ['Personal', 'Work', 'Ideas', 'Study', 'Travel', 'Others'];

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    decoration: BoxDecoration(
      border: Border.all(color: Theme.of(context).colorScheme.outline),
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
    ),
    child: DropdownButton<String>(
      value: selectedFolder,
      isDense: true,
      hint: const Text('Select a folder'),
      isExpanded: true,
      iconSize: AppSizes.iconSize,
      style: Theme.of(context).textTheme.bodyMedium,
      underline: const SizedBox(),
      icon: const Icon(Icons.folder_outlined),
      items: folders
          .map(
            (folder) => DropdownMenuItem<String>(
              value: folder,
              child: Row(
                children: [
                  Icon(
                    Icons.folder,
                    size: AppSizes.iconSize,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(width: 12),
                  Text(folder),
                ],
              ),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) {
          onFolderSelected(value);
        }
      },
    ),
  );
}
