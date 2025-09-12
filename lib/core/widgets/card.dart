import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({
    super.key,
    this.child,
    this.elevation,
    this.color,
    this.margin,
    this.padding,
  });

  final Widget? child;
  final double? elevation;
  final Color? color;
  final EdgeInsets? margin;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) => Container(
    padding: padding,
    margin: margin,
    decoration: BoxDecoration(
      color: color ?? Theme.of(context).colorScheme.surface,
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
      boxShadow: [
        BoxShadow(
          color: Theme.of(context).colorScheme.surface.withOpacity(0.7),
          blurRadius: 12,
          offset: const Offset(-4, -4),
        ),
        BoxShadow(
          color: Theme.of(context).colorScheme.inverseSurface.withOpacity(0.15),
          offset: const Offset(4, 4),
          blurRadius: 12,
        ),
      ],
    ),
    child: child,
  );
}
