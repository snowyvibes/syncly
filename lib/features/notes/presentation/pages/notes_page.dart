import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';
import 'package:syncly/features/notes/presentation/widgets/notes_folder.dart';

class NotesPage extends StatelessWidget {
  const NotesPage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Column(
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
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: SingleChildScrollView(
                child: Column(children: folders),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

final List<NotesFolder> folders = [
  NotesFolder(
    folderName: 'Work',
    notes: notes,
    folderIcon: Icons.work,
  ),
  NotesFolder(
    folderName: 'Personal',
    notes: notes,
    folderIcon: Icons.person,
  ),
  NotesFolder(
    folderName: 'Ideas',
    notes: notes,
    folderIcon: Icons.lightbulb,
  ),
];

final List<Note> notes = [
  Note(
    title: 'Meeting Notes - Q4 Planning',
    description: 'Discussed budget allocation and team goals for next quarter',
    lastUpdated: DateTime.now(),
    createdAt: DateTime.now(),
  ),
  Note(
    title: 'Flutter Development Tips',
    description: 'State management patterns and widget optimization techniques',
    lastUpdated: DateTime.now().add(const Duration(days: 1)),
    createdAt: DateTime.now(),
  ),
  Note(
    title: 'Book Ideas',
    description: 'Concepts for science fiction novel about AI consciousness',
    lastUpdated: DateTime.now().add(const Duration(days: 1)),
    createdAt: DateTime.now(),
  ),
  Note(
    title: 'Travel Plans',
    description: 'Research destinations and accommodations for summer vacation',
    lastUpdated: DateTime.now().add(const Duration(days: 3)),
    createdAt: DateTime.now(),
  ),
  Note(
    title: 'Recipe Collection',
    description: 'Favorite pasta dishes and cooking techniques to remember',
    lastUpdated: DateTime.now().add(const Duration(days: 4)),
    createdAt: DateTime.now(),
  ),
  Note(
    title: 'Learning Goals',
    description: 'Skills to develop: machine learning, design patterns, leadership',
    lastUpdated: DateTime.now().add(const Duration(days: 5)),
    createdAt: DateTime.now(),
  ),
];
