import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/widgets/segmented_button.dart';
import 'package:syncly/core/widgets/title.dart';
import 'package:syncly/features/tasks/presentation/providers/add_task_provider.dart';

class AddTaskDate extends ConsumerWidget {
  const AddTaskDate({super.key});

  void onValueChanged(int? newIndex, WidgetRef ref, BuildContext context) {
    final segmentIndexNotifier = ref.read(addTaskSegmentIndexProvider.notifier);
    final taskDate = ref.watch(addTaskDateProvider);
    final taskDateNotifier = ref.read(addTaskDateProvider.notifier);

    if (newIndex == 0) {
      segmentIndexNotifier.state = 0;
      taskDateNotifier.state = null;
    } else if (newIndex == 1) {
      segmentIndexNotifier.state = 1;
      taskDateNotifier.state = DateTime.now();
    } else if (newIndex == 2) {
      segmentIndexNotifier.state = 2;
      taskDateNotifier.state = DateTime.now().add(const Duration(days: 1));
    } else {
      segmentIndexNotifier.state = 3;
      showDatePicker(
        context: context,
        initialDate: taskDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)),
      ).then((selectedDate) {
        if (selectedDate != null) {
          taskDateNotifier.state = selectedDate;
        }
      });
    }
  }

  String getDateLabel(DateTime? date) {
    if (date != null &&
        !DateTimeHandler.isToday(date) &&
        !DateTimeHandler.isTomorrow(date) &&
        !DateTimeHandler.isYesterday(date)) {
      return DateTimeHandler.formatDate(date);
    } else {
      return 'Pick a Date';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final segmentIndex = ref.watch(addTaskSegmentIndexProvider);
    final taskDate = ref.watch(addTaskDateProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        const SectionTitle('Due Date'),
        CustomSegmentedButton(
          onValueChanged: (newIndex) => onValueChanged(newIndex, ref, context),
          segments: [
            'None',
            'Today',
            'Tomorrow',
            getDateLabel(taskDate),
          ],
          selected: segmentIndex,
          label: 'Due Date',
        ),
      ],
    );
  }
}
