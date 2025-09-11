import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/chip.dart';

class ChipList extends StatefulWidget {
  const ChipList({
    super.key,
    required this.chips,
    this.onTap,
    this.selectedIndex = 0,
  }) : assert(
         selectedIndex >= 0 && selectedIndex < chips.length,
         'chips list must have at least one chip and selectedIndex must be valid',
       );

  final List<String> chips;
  final int selectedIndex;
  final void Function()? onTap;

  @override
  State<ChipList> createState() => _ChipListState();
}

class _ChipListState extends State<ChipList> {
  @override
  Widget build(BuildContext context) => Wrap(
    spacing: AppSizes.rowSpacing,
    runSpacing: AppSizes.columnSpacing,
    children: widget.chips
        .map(
          (index) => CustomChip(
            onTap: widget.onTap,
            tag: index,
            isSelected: widget.chips.indexOf(index) == widget.selectedIndex,
          ),
        )
        .toList(),
  );
}
