import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendarWidget extends StatefulWidget {
  const CustomCalendarWidget({super.key, required this.events});

  final List<DateTime?> events;

  @override
  State<CustomCalendarWidget> createState() => _CustomCalendarWidgetState();
}

class _CustomCalendarWidgetState extends State<CustomCalendarWidget> {
  CalendarFormat _calendarFormat = CalendarFormat.week;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();

  List<DateTime?> _getEventsForDay(DateTime day) {
    if (widget.events.isNotEmpty) {
      return widget.events.where((event) => isSameDay(event, day)).toList();
    }
    return [];
  }

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(AppSizes.padding),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
    child: TableCalendar(
      eventLoader: (day) => _getEventsForDay(day),
      selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
      firstDay: DateTime.utc(2010, 10, 16),
      lastDay: DateTime.utc(2030, 3, 14),
      formatAnimationCurve: Curves.easeInOutCubic,
      formatAnimationDuration: const Duration(milliseconds: 300),
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          if (events.isNotEmpty) {
            final eventCount = events.length;

            String eventCountInDots = '';

            for (var i = 0; i < eventCount && i < 3; i++) {
              eventCountInDots += '•';
            }

            return Positioned(
              top: 23,
              // right: 1,
              child: Text(
                eventCountInDots,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onTertiary),
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
      focusedDay: _focusedDay,
      daysOfWeekHeight: 25,
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
        weekendStyle: TextStyle(color: Theme.of(context).colorScheme.onSurface),
      ),
      rowHeight: 42,
      currentDay: DateTime.now(),

      headerStyle: HeaderStyle(
        leftChevronVisible: false,
        rightChevronVisible: false,
        titleTextStyle: Theme.of(
          context,
        ).textTheme.displayLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
      ),

      onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
        setState(() {
          _selectedDay = selectedDay;
          _focusedDay = focusedDay;
        });
      },
      calendarFormat: _calendarFormat,
      onFormatChanged: (CalendarFormat format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      availableCalendarFormats: const {CalendarFormat.month: 'Month', CalendarFormat.week: 'Week'},
      calendarStyle: CalendarStyle(
        todayDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          shape: BoxShape.circle,
        ),
        markersMaxCount: 3,
        markerSize: 100,
        markerDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.tertiary,
          shape: BoxShape.circle,
        ),
        markerMargin: const EdgeInsets.symmetric(horizontal: 0.5),
        selectedDecoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          shape: BoxShape.circle,
        ),
        selectedTextStyle: TextStyle(
          color: Theme.of(context).colorScheme.surface,
          fontWeight: FontWeight.bold,
        ),
        weekNumberTextStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
        defaultTextStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
      ),
    ),
  );
}
