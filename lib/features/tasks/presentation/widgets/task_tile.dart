import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/card.dart';
import 'package:syncly/core/widgets/chip.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/presentation/pages/task_details_page.dart';

class TaskTile extends StatefulWidget {
  const TaskTile({super.key, required this.task});

  final Task task;

  @override
  State<TaskTile> createState() => _TaskTileState();
}

class _TaskTileState extends State<TaskTile> {
  bool isCompleted = false;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: () {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        showDragHandle: true,
        useSafeArea: true,
        builder: (context) => TaskDetailsPage(widget.task),
      );
    },
    child: CustomCard(
      margin: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding,
        vertical: AppSizes.padding / 3,
      ),
      child: Slidable(
        key: ValueKey(widget.task.id),
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {},
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              foregroundColor: Colors.white,
              backgroundColor: Theme.of(context).colorScheme.primary,
            ),
            SlidableAction(
              padding: const EdgeInsets.all(AppSizes.padding),
              onPressed: (context) {},
              icon: Icons.edit,
              label: 'Delete',
              borderRadius: BorderRadius.circular((AppSizes.borderRadius)),
              foregroundColor: Colors.white,
              backgroundColor: Colors.red.shade400,
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.padding,
            vertical: AppSizes.padding,
          ),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
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
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(widget.task.title, style: Theme.of(context).textTheme.titleSmall),
                        const Row(
                          spacing: AppSizes.rowSpacing,
                          children: [
                            // HashtagChip(
                            //   tag: 'Work',
                            //   // textColor: Colors.white,
                            //   chipColor: Colors.yellow,
                            // ),
                            CustomChip(
                              tag: 'Personal',
                              chipColor: Colors.greenAccent,
                            ),
                          ],
                        ),
                      ],
                    ),
                    Text(
                      widget.task.description ?? '-',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium!.copyWith(color: Colors.grey.shade700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (widget.task.dueDate != null)
                      Text(
                        DateTimeHandler.formatDateInWord(widget.task.dueDate!),
                        style:
                            Theme.of(
                              context,
                            ).textTheme.bodyMedium!.copyWith(
                              color: DateTimeHandler.isBeforeToday(widget.task.dueDate!)
                                  ? Colors.red
                                  : Theme.of(context).colorScheme.primary,
                            ),
                      ),
                  ],
                ),
              ), // TODO: Animate and play sound and vibration
            ],
          ),
        ),
      ),
    ),
  );
}
