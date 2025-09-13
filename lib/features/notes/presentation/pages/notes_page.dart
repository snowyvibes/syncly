import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/notes/presentation/providers/notes_provider.dart';
import 'package:syncly/features/notes/presentation/widgets/notes_folder.dart';

class NotesPage extends ConsumerWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notes = ref.watch(notesListProvider);
    final folders = ref.watch(notesFoldersProvider);

    return SafeArea(
      child: Column(
        spacing: AppSizes.columnSpacing,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Text(
              'Notes',
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface),
            ),
          ),
          Expanded(
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSizes.borderRadius),
                topRight: Radius.circular(AppSizes.borderRadius),
              ),
              clipBehavior: Clip.antiAlias,
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.only(top: AppSizes.padding),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: folders.length,
                        itemBuilder: (context, index) {
                          final folder = folders[index];
                          return NotesFolderTile(
                            folderName: folder.name,
                            notes: folder.notes,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
