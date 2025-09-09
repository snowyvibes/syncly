import 'package:flutter/material.dart';
import 'package:syncly/core/utils/constants.dart';
import 'package:syncly/core/utils/sizes.dart';

class CalendarDayWidget extends StatelessWidget {
  const CalendarDayWidget({
    super.key,
    required this.day,
    required this.date,
    required this.taskCount,
    this.isSelected = false,
  });

  final String day;
  final String date;
  final bool isSelected;
  final int taskCount;

  @override
  Widget build(BuildContext context) => Container(
    width: 60,
    padding: const EdgeInsets.all(AppSizes.padding),
    margin: const EdgeInsets.symmetric(horizontal: AppSizes.padding / 2),
    decoration: BoxDecoration(
      // color: Theme.of(context).colorScheme.primaryContainer,
      borderRadius: BorderRadius.circular(AppSizes.borderRadius),
    ),
    child: Column(
      children: [
        Text(
          day,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primaryContainer),
        ),
        kSizedBox,
        Container(
          padding: const EdgeInsets.all(AppSizes.padding),
          decoration: BoxDecoration(
            color: isSelected ? Theme.of(context).colorScheme.primaryContainer : null,
            // color: Theme.of(context).colorScheme.primaryContainer,
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          ),
          child: Column(
            children: [
              Text(
                date,
                style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  fontWeight: FontWeight.bold,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimaryContainer
                      : Theme.of(context).colorScheme.primaryContainer,
                ),
              ),
              kSizedBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  taskCount < 3 ? taskCount : 3,
                  (index) => Icon(
                    Icons.circle,
                    size: 3,
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
