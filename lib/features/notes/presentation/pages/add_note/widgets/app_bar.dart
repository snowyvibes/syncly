import 'package:flutter/material.dart';

class AddNoteAppBar extends StatelessWidget {
  const AddNoteAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Add Note',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.close),
        ),
      ],
    );
  }
}
