import 'package:flutter/material.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/expansible.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/presentation/widgets/calendar.dart';
import 'package:syncly/features/tasks/presentation/widgets/task_tile.dart';

final List<Task> _tasks = [
  Task(
    id: '0',
    title: 'Push code to GitHub',
    description: 'Push the recent changes to the remote repository',
    dueDate: DateTime.now().subtract(const Duration(days: 1)),
    createdAt: DateTime.now(),
  ),
  Task(
    id: '1',
    title: 'Get groceries',
    description: 'Buy milk, eggs, and bread',
    dueDate: DateTime.now(),
    createdAt: DateTime.now(),
  ),
  Task(
    id: '11',
    title: 'Sell old laptop',
    description: 'Put ad on eBay',
    dueDate: DateTime.now(),
    createdAt: DateTime.now(),
  ),
  Task(
    id: '10',
    title: 'Repair bike',
    description: '-',
    dueDate: DateTime.now(),
    createdAt: DateTime.now(),
  ),
  Task(
    id: '2',
    title: 'Do laundry',
    description: 'Wash and fold clothes',
    dueDate: DateTime.now().add(const Duration(days: 1)),
    createdAt: DateTime.now(),
  ),
  Task(
    id: '3',
    title: 'Get a haircut',
    dueDate: DateTime.now().add(const Duration(days: 1)),
    createdAt: DateTime.now(),
  ),
  Task(
    id: '4',
    title: 'Clean the house',
    description: 'Tidy up the living room and bedrooms',
    dueDate: DateTime.now(),
    createdAt: DateTime.now(),
  ),
  Task(
    id: '5',
    title: 'Organize workspace',
    description: 'Sort and organize the desk and files',
    dueDate: DateTime.now().add(const Duration(days: 4)),
    createdAt: DateTime.now(),
  ),
  Task(
    id: '6',
    title: 'Prepare presentation',
    description: 'Create slides for the project presentation',
    dueDate: DateTime.now().add(const Duration(days: 5)),
    createdAt: DateTime.now(),
  ),
];

final List<Task> overdueTasks = _tasks
    .where((task) => DateTimeHandler.isBeforeToday(task.dueDate!))
    .toList();

final List<Task> todaysTasks = _tasks
    .where((task) => DateTimeHandler.isSameDate(task.dueDate!, DateTime.now()))
    .toList();

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomCalendarWidget(events: _tasks.map((task) => task.dueDate).toList()),

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
                            items: overdueTasks.map((index) => TaskTile(task: index)).toList(),
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
                              color: Theme.of(context).colorScheme.surface,
                            ),
                            child: CustomExpansibleWidget(
                              initiallyExpanded: true,
                              header: Text(
                                'Today\'s Tasks',
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
