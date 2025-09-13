import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/title.dart';
import 'package:syncly/features/notes/presentation/providers/add_note_provider.dart';

class AddNoteFolder extends ConsumerWidget {
  const AddNoteFolder({super.key});

  final List<String> folders = const ['Personal', 'Work', 'Ideas', 'Study', 'Travel', 'Others'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedFolder = ref.watch(addNoteFolderProvider);
    final addNoteFolderNotifier = ref.read(addNoteFolderProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Folder'),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
            ),
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          ),
          child: DropdownButton<String>(
            value: selectedFolder,
            isDense: true,
            hint: const Text('Select a folder'),
            isExpanded: true,

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
                addNoteFolderNotifier.state = value;
              }
            },
          ),
        ),
      ],
    );
  }
}
