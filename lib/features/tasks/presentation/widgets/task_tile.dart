import 'package:flutter/material.dart';
import 'package:syncly/core/utils/constants.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';

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
      padding: const EdgeInsets.all(16),
      height: 120,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.task.title, style: Theme.of(context).textTheme.titleLarge),
              kSizedBox,
              Text(widget.task.description),
              const Spacer(),
              Text(
                widget.task.dueDate.toLocal().toString().split(' ')[0],
                style: const TextStyle(fontWeight: FontWeight.w200),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              setState(() {
                isCompleted = !isCompleted;
              });
            },
            radius: 300,
            child: Icon(isCompleted ? Icons.check_circle : Icons.circle_outlined),
          ),
        ],
      ),
    ),
  );
}
