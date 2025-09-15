import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/presentation/providers/tasks_list_provider.dart';
import 'package:table_calendar/table_calendar.dart';

final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final focusedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());
final calendarFormatProvider = StateProvider<CalendarFormat>((ref) => CalendarFormat.week);

final targetDateTasksProvider = Provider<List<Task>>((ref) {
  final tasks = ref.watch(tasksListProvider);
  final selectedDate = ref.watch(selectedDateProvider);
  return tasks
      .where(
        (task) => task.dueDate != null && DateTimeHandler.isSameDate(task.dueDate!, selectedDate),
      )
      .toList();
});
