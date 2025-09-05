import 'package:flutter/material.dart';

class HashtagChip extends StatelessWidget {
  const HashtagChip({
    super.key,
    required this.tag,
    this.chipColor,
    this.textColor,
  });

  final String tag;
  final Color? chipColor;
  final Color? textColor;

  @override
  Widget build(BuildContext context) => Chip(
    labelPadding: EdgeInsets.zero,
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    label: Text(
      '#$tag',
      style: TextStyle(
        color: textColor ?? Colors.grey[600],
      ),
    ),
    color: WidgetStateProperty.all(chipColor),
  );
}
