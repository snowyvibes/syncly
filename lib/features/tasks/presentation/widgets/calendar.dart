import 'package:flutter/material.dart';
import 'package:syncly/core/utils/constants.dart';
import 'package:syncly/features/tasks/presentation/widgets/calendar_day.dart';

class CustomCalendarWidget extends StatelessWidget {
  const CustomCalendarWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Text(
            'August',
            style: Theme.of(
              context,
            ).textTheme.headlineLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
          ),
        ),
        kSizedBox,
        kSizedBox,
        SizedBox(
          height: 90,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              CalendarDayWidget(day: 'Mon', date: '6', taskCount: 0),
              CalendarDayWidget(day: 'Tue', date: '7', taskCount: 1),
              CalendarDayWidget(day: 'Wed', date: '8', taskCount: 2, isSelected: true),
              CalendarDayWidget(day: 'Thu', date: '9', taskCount: 3),
              CalendarDayWidget(day: 'Fri', date: '10', taskCount: 4),
              CalendarDayWidget(day: 'Sat', date: '11', taskCount: 5),
              CalendarDayWidget(day: 'Sun', date: '12', taskCount: 0),
              CalendarDayWidget(day: 'Mon', date: '13', taskCount: 0),
              CalendarDayWidget(day: 'Tue', date: '14', taskCount: 0),
              CalendarDayWidget(day: 'Wed', date: '15', taskCount: 0),
              CalendarDayWidget(day: 'Thu', date: '16', taskCount: 0),
              CalendarDayWidget(day: 'Fri', date: '17', taskCount: 0),
              CalendarDayWidget(day: 'Sat', date: '18', taskCount: 0),
              CalendarDayWidget(day: 'Sun', date: '19', taskCount: 0),
            ],
          ),
        ),
      ],
    ),
  );
}
