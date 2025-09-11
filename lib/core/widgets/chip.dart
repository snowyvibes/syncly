import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';

class CustomChip extends StatelessWidget {
  const CustomChip({
    super.key,
    required this.tag,
    this.chipColor,
    this.textColor,
    this.onTap,
    this.isSelected = false,
  });

  final String tag;
  final Color? chipColor;
  final Color? textColor;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.padding,
        vertical: AppSizes.padding / 2,
      ),
      decoration: BoxDecoration(
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : chipColor?.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      ),
      child: Text(
        tag,
        style: TextStyle(
          color: isSelected
              ? Theme.of(context).colorScheme.surface
              : (textColor ?? Colors.grey[600]),
        ),
      ),
    ),
  );
}
