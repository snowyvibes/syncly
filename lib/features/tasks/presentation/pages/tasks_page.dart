import 'package:flutter/material.dart';
import 'package:syncly/core/utils/constants.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/presentation/widgets/calendar.dart';
import 'package:syncly/features/tasks/presentation/widgets/task_tile.dart';

class TasksPage extends StatelessWidget {
  const TasksPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Theme.of(context).primaryColor,

    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: AppSizes.extraLarge),
        const SizedBox(height: AppSizes.large),
        const CustomCalendarWidget(),
        kBigSizedBox,
        Expanded(
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: AppSizes.large,
              left: AppSizes.large,
              right: AppSizes.large,
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(AppSizes.large),
                topRight: Radius.circular(AppSizes.large),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Active Tasks', style: Theme.of(context).textTheme.headlineMedium),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => TaskTile(task: tasks[index]),
                    itemCount: tasks.length,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

final List<Task> tasks = [
  Task(
    title: 'Task 1',
    description: 'Description for task 1',
    dueDate: DateTime.now(),
    createdAt: DateTime.now(),
  ),
  Task(
    title: 'Task 2',
    description: 'Description for task 2',
    dueDate: DateTime.now().add(const Duration(days: 1)),
    createdAt: DateTime.now(),
  ),
  Task(
    title: 'Task 3',
    description: 'Description for task 3',
    dueDate: DateTime.now().add(const Duration(days: 2)),
    createdAt: DateTime.now(),
  ),
  Task(
    title: 'Task 4',
    description: 'Description for task 4',
    dueDate: DateTime.now().add(const Duration(days: 3)),
    createdAt: DateTime.now(),
  ),
  Task(
    title: 'Task 5',
    description: 'Description for task 5',
    dueDate: DateTime.now().add(const Duration(days: 4)),
    createdAt: DateTime.now(),
  ),
  Task(
    title: 'Task 6',
    description: 'Description for task 6',
    dueDate: DateTime.now().add(const Duration(days: 5)),
    createdAt: DateTime.now(),
  ),
];
