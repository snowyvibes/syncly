import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/expansible.dart';
import 'package:syncly/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:syncly/features/tasks/presentation/widgets/calendar.dart';
import 'package:syncly/features/tasks/presentation/widgets/task_tile.dart';

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
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(AppSizes.borderRadius),
                                topRight: Radius.circular(AppSizes.borderRadius),
                              ),
                              color: Theme.of(context).colorScheme.secondary,
                              // color: Colors.transparent,
                            ),
                            child: CustomExpansibleWidget(
                              header: Text(
                                'Overdue Tasks',
                                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: Theme.of(context).colorScheme.surface,
                                ),
                              ),
                              iconColor: Theme.of(context).colorScheme.surface,
                              items: overDueTasks.map((index) => TaskTile(task: index)).toList(),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.secondary,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppSizes.borderRadius),
                                  topRight: Radius.circular(AppSizes.borderRadius),
                                ),
                                color: Theme.of(context).colorScheme.tertiary,
                              ),
                              child: CustomExpansibleWidget(
                                iconColor: Theme.of(context).colorScheme.surface,
                                header: Text(
                                  'Upcoming Tasks',
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                    color: Theme.of(context).colorScheme.surface,
                                  ),
                                ),
                                items: upcomingTasks.map((index) => TaskTile(task: index)).toList(),
                              ),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).colorScheme.tertiary,
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(AppSizes.borderRadius),
                                  topRight: Radius.circular(AppSizes.borderRadius),
                                ),
                                color: Theme.of(context).colorScheme.surface,
                              ),
                              child: CustomExpansibleWidget(
                                initiallyExpanded: true,
                                header: Text(
                                  DateTimeHandler.isSameDate(selectedDay, DateTime.now())
                                      ? 'Today\'s Tasks'
                                      : DateTimeHandler.formatDate(selectedDay),
                                  style: Theme.of(context).textTheme.titleLarge,
                                ),
                                items: todaysTasks.map((index) => TaskTile(task: index)).toList(),
                              ),
                            ),
                          ),

                          // Container(
                          //   decoration: BoxDecoration(
                          //     borderRadius: const BorderRadius.only(
                          //       topLeft: Radius.circular(AppSizes.borderRadius),
                          //       topRight: Radius.circular(AppSizes.borderRadius),
                          //     ),
                          //     color: Theme.of(context).colorScheme.surface,
                          //   ),
                          // ),
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
