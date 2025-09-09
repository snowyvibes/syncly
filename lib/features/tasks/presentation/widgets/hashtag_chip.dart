import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';

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
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      color: chipColor?.withValues(alpha: 0.3),
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
    ),
    child: Text(
      tag,
      style: TextStyle(
        color: textColor ?? Colors.grey[600],
      ),
    ),
  );
}
