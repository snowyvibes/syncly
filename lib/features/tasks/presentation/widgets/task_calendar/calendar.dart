import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/tasks/presentation/providers/tasks_provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CustomCalendarWidget extends ConsumerWidget {
  const CustomCalendarWidget({super.key, required this.events});

  final List<DateTime?> events;

  List<DateTime?> _getEventsForDay(DateTime day) {
    // if (events.isNotEmpty) {
    //   print(day);

    //   print(events);
    //   final selectedDayEvents = events.where((event) {
    //     if (event != null) {
    //       return DateTimeHandler.isSameDate(event, day);
    //     } else {
    //       return false;
    //     }
    //   }).toList();
    //   print(selectedDayEvents);
    //   return selectedDayEvents;
    // }
    // return [];

    return events
        .where((event) {
          return event != null && DateTimeHandler.isSameDate(event, day);
        })
        .cast<DateTime>() // Convert from DateTime? to DateTime
        .toList();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedDay = ref.watch(selectedDateProvider);
    final selectedDayNotifier = ref.read(selectedDateProvider.notifier);
    final focusedDay = ref.watch(focusedDateProvider);
    final focusedDayNotifier = ref.read(focusedDateProvider.notifier);
    final calendarFormat = ref.watch(calendarFormatProvider);
    final calendarFormatNotifier = ref.read(calendarFormatProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(AppSizes.padding),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSizes.borderRadius)),
      child: TableCalendar(
        // loads the events from the provided list to show markers on the calendar
        eventLoader: (day) {
          return _getEventsForDay(day);
        },
        selectedDayPredicate: (day) => DateTimeHandler.isSameDate(selectedDay, day),
        firstDay: DateTime.utc(2010, 10, 16),
        lastDay: DateTime.utc(2030, 3, 14),
        formatAnimationCurve: Curves.easeInOutCubic,
        formatAnimationDuration: const Duration(milliseconds: 300),
        rowHeight: 50,
        currentDay: DateTime.now(),
        calendarFormat: calendarFormat,

        availableCalendarFormats: const {
          CalendarFormat.month: 'Month',
          CalendarFormat.week: 'Week',
        },
        daysOfWeekHeight: 25,
        focusedDay: focusedDay,
        daysOfWeekStyle: DaysOfWeekStyle(
          weekdayStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
          weekendStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
        ),
        calendarBuilders: CalendarBuilders(
          markerBuilder: (context, date, events) {
            if (events.isNotEmpty) {
              return Positioned(
                bottom: 10,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(
                    events.length > 3 ? 3 : events.length,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 1),
                      width: 5,
                      height: 5,
                      decoration: BoxDecoration(
                        color:
                            //  DateTimeHandler.isToday(date)
                            //     ? Theme.of(context).colorScheme.primary
                            // :
                            Theme.of(context).colorScheme.surface,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),

        headerStyle: HeaderStyle(
          formatButtonTextStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
          formatButtonDecoration: BoxDecoration(
            border: Border.all(color: Theme.of(context).colorScheme.surface),
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
          ),
          leftChevronVisible: false,
          rightChevronVisible: false,
          titleTextStyle: Theme.of(
            context,
          ).textTheme.displayLarge!.copyWith(color: Theme.of(context).colorScheme.surface),
        ),
        onDaySelected: (DateTime selectedDay, DateTime focusedDay) {
          if (!DateTimeHandler.isSameDate(ref.read(selectedDateProvider), selectedDay)) {
            selectedDayNotifier.state = selectedDay;
            focusedDayNotifier.state = focusedDay;
          }
        },

        onFormatChanged: (CalendarFormat format) {
          calendarFormatNotifier.state = format;
        },

        calendarStyle: CalendarStyle(
          weekendTextStyle: TextStyle(color: Theme.of(context).colorScheme.surface),
          todayTextStyle: Theme.of(context).textTheme.bodyLarge!.copyWith(
            color: Theme.of(context).colorScheme.surface,
            fontWeight: FontWeight.bold,
          ),
          todayDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            shape: BoxShape.circle,
          ),
          markersMaxCount: 3,
          markerDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.primary,
            shape: BoxShape.circle,
          ),
          markerMargin: const EdgeInsets.symmetric(horizontal: 0.5),

          selectedDecoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
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
}
