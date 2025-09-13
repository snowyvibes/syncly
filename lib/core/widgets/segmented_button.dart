import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';

class CustomSegmentedButton extends StatefulWidget {
  const CustomSegmentedButton({
    super.key,
    required this.segments,
    required this.selected,
    required this.onValueChanged,
    this.label,
  });

  final List<String> segments;
  final int selected;
  final String? label;
  final void Function(int?) onValueChanged;

  @override
  State<CustomSegmentedButton> createState() => _CustomSegmentedButtonState();
}

class _CustomSegmentedButtonState extends State<CustomSegmentedButton> {
  @override
  Widget build(BuildContext context) => CupertinoSlidingSegmentedControl<int>(
    groupValue: widget.selected,
    thumbColor: Theme.of(context).colorScheme.primary, // Selected segment color
    backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest, // Unselected background
    padding: EdgeInsets.zero,
    proportionalWidth: true,

    children: widget.segments.asMap().map(
      (index, text) => MapEntry(index, buildSegment(text, index == widget.selected)),
    ),
    onValueChanged: widget.onValueChanged,
  );

  Widget buildSegment(String text, bool isSelected) => Padding(
    padding: const EdgeInsets.all(AppSizes.padding / 1.5),
    child: Text(
      text,
      maxLines: 1,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: isSelected
            ? Theme.of(context).colorScheme.onPrimary
            : Theme.of(context).colorScheme.onSurface,
      ),
      textAlign: TextAlign.center,
      overflow: TextOverflow.ellipsis,
    ),
  );
}
