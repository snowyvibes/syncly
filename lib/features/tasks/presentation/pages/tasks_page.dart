import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/presentation/widgets/calendar.dart';
import 'package:syncly/features/tasks/presentation/widgets/task_tile.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Theme.of(context).colorScheme.primary, Theme.of(context).colorScheme.secondary],
        ),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCalendarWidget(events: tasks.map((task) => task.dueDate).toList()),

            Expanded(
              child: Material(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(AppSizes.size24),
                  topRight: Radius.circular(AppSizes.size24),
                ),
                clipBehavior: Clip.antiAlias,
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: CustomScrollView(
                    shrinkWrap: true,
                    slivers: [
                      SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            ExpansionTile(
                              title: Text(
                                'Today\'s Tasks',
                                style: Theme.of(context).textTheme.headlineSmall,
                              ),

                              initiallyExpanded: true,
                              maintainState: true,
                              collapsedBackgroundColor: Theme.of(context).colorScheme.tertiary,

                              children: List.generate(
                                tasks.length,
                                (index) => TaskTile(task: tasks[index]),
                              ),
                            ),
                            ExpansionTile(
                              title: Text(
                                'Overdue Tasks',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),

                              initiallyExpanded: true,
                              maintainState: true,
                              collapsedBackgroundColor: Theme.of(context).colorScheme.tertiary,

                              children: List.generate(
                                tasks.length,
                                (index) => TaskTile(task: tasks[index]),
                              ),
                            ),
                            ExpansionTile(
                              title: Text(
                                'Upcoming Tasks',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),

                              initiallyExpanded: true,
                              maintainState: true,
                              collapsedBackgroundColor: Theme.of(context).colorScheme.tertiary,

                              children: List.generate(
                                tasks.length,
                                (index) => TaskTile(task: tasks[index]),
                              ),
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
      ),
    ),
  );
}

final List<Task> tasks = [
  Task(
    title: 'Get groceries',
    description: 'Buy milk, eggs, and bread',
    dueDate: DateTime.now(),
    createdAt: DateTime.now(),
  ),
  Task(
    title: 'Do laundry',
    description: 'Wash and fold clothes',
    dueDate: DateTime.now().add(const Duration(days: 1)),
    createdAt: DateTime.now(),
  ),
  Task(
    title: 'Get a haircut',
    dueDate: DateTime.now().add(const Duration(days: 1)),
    createdAt: DateTime.now(),
  ),
  Task(
    title: 'Clean the house',
    description: 'Tidy up the living room and bedrooms',
    dueDate: DateTime.now().add(const Duration(days: 3)),
    createdAt: DateTime.now(),
  ),
  Task(
    title: 'Organize workspace',
    description: 'Sort and organize the desk and files',
    dueDate: DateTime.now().add(const Duration(days: 4)),
    createdAt: DateTime.now(),
  ),
  Task(
    title: 'Prepare presentation',
    description: 'Create slides for the project presentation',
    dueDate: DateTime.now().add(const Duration(days: 5)),
    createdAt: DateTime.now(),
  ),
];
