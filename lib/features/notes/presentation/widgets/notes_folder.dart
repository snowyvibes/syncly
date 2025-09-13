import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/card.dart';
import 'package:syncly/core/widgets/expansible.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';
import 'package:syncly/features/notes/presentation/widgets/note_tile.dart';

class NotesFolderTile extends StatelessWidget {
  const NotesFolderTile({
    super.key,
    required this.folderName,
    required this.notes,
    this.folderIcon = Icons.folder,
  });

  final String folderName;
  final List<Note> notes;
  final IconData? folderIcon;

  @override
  Widget build(BuildContext context) => CustomCard(
    margin: const EdgeInsets.symmetric(
      horizontal: AppSizes.padding,
      vertical: AppSizes.padding / 2,
    ),
    child: CustomExpansibleWidget(
      items: notes.map((note) => NoteTile(note: note)).toList(),
      header: Row(
        children: [
          if (folderIcon != null) ...[
            Container(
              padding: const EdgeInsets.all(AppSizes.padding),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              ),
              child: Icon(
                folderIcon,
                size: AppSizes.iconSize,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(width: 12),
          ],
          Expanded(
            child: Text(
              folderName,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.padding,
              vertical: AppSizes.padding / 2,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            ),
            child: Text(
              '${notes.length}',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
