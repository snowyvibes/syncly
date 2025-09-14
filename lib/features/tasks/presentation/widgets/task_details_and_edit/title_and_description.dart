import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';

class TaskTitleAndDescription extends StatelessWidget {
  const TaskTitleAndDescription({super.key, required this.task});

  final Task task;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 1,
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                task.title,
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              Text(
                task.description ?? 'No description',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
