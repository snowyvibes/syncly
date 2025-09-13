import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/expansible.dart';

class ExpandableTile extends StatelessWidget {
  const ExpandableTile({
    super.key,
    required this.title,
    required this.items,
    this.titleColor,
    this.backgroundColor,
    this.topWidgetColor,
    this.initiallyExpanded = false,
  });

  final String title;
  final List<Widget> items;
  final Color? titleColor;
  final Color? backgroundColor;
  final Color? topWidgetColor;
  final bool initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: topWidgetColor ?? Theme.of(context).colorScheme.surface),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(AppSizes.borderRadius),
            topRight: Radius.circular(AppSizes.borderRadius),
          ),
          color: backgroundColor ?? Theme.of(context).colorScheme.secondary,
          // color: Colors.transparent,
        ),
        child: CustomExpansibleWidget(
          initiallyExpanded: initiallyExpanded,
          header: Text(
            title,
            style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: titleColor ?? Theme.of(context).colorScheme.surface,
            ),
          ),
          iconColor: titleColor ?? Theme.of(context).colorScheme.surface,
          items: items,
        ),
      ),
    );
  }
}
