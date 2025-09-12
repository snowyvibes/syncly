import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/card.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/presentation/pages/task_details_page.dart';
import 'package:syncly/features/tasks/presentation/providers/tasks_provider.dart';

class TaskTile extends ConsumerWidget {
  const TaskTile({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(tasksListProvider.notifier);

    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          useSafeArea: true,
          builder: (context) => TaskDetailsPage(task),
        );
      },
      child: CustomCard(
        margin: const EdgeInsets.symmetric(
          horizontal: AppSizes.padding,
          vertical: AppSizes.padding / 6,
        ),
        child: Slidable(
          key: ValueKey(task.id),
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
                    key: ValueKey(task.isCompleted),
                    onPressed: () => notifier.toggleTask(task.id),
                    icon: Icon(task.isCompleted ? Icons.check_circle : Icons.circle_outlined),
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
                          Text(
                            task.title,
                            style:
                                Theme.of(
                                  context,
                                ).textTheme.titleSmall!.copyWith(
                                  decoration: task.isCompleted
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                ),
                          ),
                        ],
                      ),
                      Text(
                        task.description ?? '-',
                        style: Theme.of(
                          context,
                        ).textTheme.bodyMedium!.copyWith(color: Colors.grey.shade700),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      if (task.dueDate != null)
                        Text(
                          DateTimeHandler.formatDateInWord(task.dueDate!),
                          style:
                              Theme.of(
                                context,
                              ).textTheme.bodyMedium!.copyWith(
                                color: DateTimeHandler.isBeforeToday(task.dueDate!)
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
}
