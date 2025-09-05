import 'package:flutter/material.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/presentation/widgets/hashtag_chip.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({super.key, required this.task});

  final Task task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) => Card(
    color: Colors.white,
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.size16, vertical: AppSizes.size12),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.task.title, style: Theme.of(context).textTheme.titleMedium),
                Text(
                  widget.task.description ?? '-',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(color: Colors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                if (widget.task.dueDate != null)
                  Text(
                    DateTimeHandler.formatDateInWord(widget.task.dueDate!),
                    style: const TextStyle(fontWeight: FontWeight.w200, fontSize: 19),
                  ),
                const Row(
                  spacing: AppSizes.rowSpacing,
                  children: [
                    HashtagChip(tag: 'Work'),
                    HashtagChip(tag: 'Personal'),
                  ],
                ),
              ],
            ),
          ),

          // TODO: Animate and play sound and vibration
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 300),
            child: IconButton(
              key: ValueKey(isCompleted),
              onPressed: () {
                setState(() {
                  isCompleted = !isCompleted;
                });
              },
              icon: Icon(isCompleted ? Icons.check_circle : Icons.circle_outlined),
            ),
          ),
        ],
      ),
    ),
  );
}
