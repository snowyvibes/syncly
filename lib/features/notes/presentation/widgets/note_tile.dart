import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';

class NoteTile extends StatelessWidget {
  const NoteTile({super.key, required this.note});

  final Note note;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      context.push('/note/${note.id}', extra: note);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding,
        vertical: AppSizes.padding / 1.3,
      ),
      decoration: BoxDecoration(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withOpacity(0.3),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 4,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              note.title,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
          Icon(
            Icons.chevron_right,
            size: 16,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    ),
  );
}
