import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/expandable_tile.dart';
import 'package:syncly/features/tasks/presentation/providers/tasks_list_provider.dart';
import 'package:syncly/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:syncly/features/tasks/presentation/widgets/task_calendar/index.dart';

class TasksPage extends ConsumerWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(tasksListProvider);
    final overDueTasks = ref.watch(overdueTasksProvider);
    final selectedDay = ref.watch(selectedDateProvider);
    final todaysTasks = ref.watch(targetDateTasksProvider);
    final upcomingTasks = ref.watch(upcomingTasksProvider);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomCalendarWidget(events: tasks.map((task) => task.dueDate).toList()),

          Expanded(
            child: Material(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSizes.borderRadius),
                topRight: Radius.circular(AppSizes.borderRadius),
              ),
              clipBehavior: Clip.antiAlias,
              child: SizedBox(
                width: double.infinity,
                child: CustomScrollView(
                  shrinkWrap: true,
                  slivers: [
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          ExpandableTile(
                            title: 'Overdue Tasks',
                            backgroundColor: Theme.of(context).colorScheme.secondary,
                            items: overDueTasks.map((index) => TaskTile(task: index)).toList(),
                          ),
                          ExpandableTile(
                            title: 'Upcoming Tasks',
                            backgroundColor: Theme.of(context).colorScheme.tertiary,
                            topWidgetColor: Theme.of(context).colorScheme.secondary,
                            items: upcomingTasks.map((index) => TaskTile(task: index)).toList(),
                          ),
                          ExpandableTile(
                            initiallyExpanded: todaysTasks.isNotEmpty,
                            title: DateTimeHandler.isSameDate(selectedDay, DateTime.now())
                                ? 'Today\'s Tasks'
                                : DateTimeHandler.formatDate(selectedDay),
                            backgroundColor: Theme.of(context).colorScheme.surface,
                            topWidgetColor: Theme.of(context).colorScheme.tertiary,
                            titleColor: Theme.of(context).colorScheme.onSurface,
                            items: todaysTasks.map((index) => TaskTile(task: index)).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
