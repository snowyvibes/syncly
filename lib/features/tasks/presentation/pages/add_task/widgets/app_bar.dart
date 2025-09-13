import 'package:flutter/material.dart';

class AddTaskAppBar extends StatelessWidget {
  const AddTaskAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Add Task',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        IconButton(
          onPressed: () {
            // Pop the modal sheet
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
