import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/widgets/list_tile.dart';
import 'package:syncly/features/tasks/presentation/providers/task_details_provider.dart';

class EditTaskTime extends ConsumerWidget {
  const EditTaskTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editTaskDate = ref.watch(editTaskDateProvider);
    final editTaskDateNotifier = ref.read(editTaskDateProvider.notifier);
    final editTaskTime = ref.watch(editTaskTimeProvider);
    final editTaskTimeNotifier = ref.read(editTaskTimeProvider.notifier);

    return CustomListTile(
      title: 'Time',
      subtitle: editTaskTime != null ? DateTimeHandler.formatTime(editTaskTime) : 'No Time Set',
      subtitleColor: Theme.of(context).colorScheme.primary,
      leading: const Icon(FontAwesomeIcons.clock),
      trailing: IconButton(
        onPressed: () async {
          final selectedTime = await showTimePicker(
            context: context,
            initialTime: editTaskTime != null
                ? TimeOfDay.fromDateTime(editTaskTime)
                : TimeOfDay.now(),
          );
          if (selectedTime != null) {
            final currentDate = editTaskDate ?? DateTime.now();
            final newDateTime = DateTime(
              currentDate.year,
              currentDate.month,
              currentDate.day,
              selectedTime.hour,
              selectedTime.minute,
            );
            editTaskTimeNotifier.state = newDateTime;
            // Also update the date if it wasn't set
            if (editTaskDate == null) {
              editTaskDateNotifier.state = newDateTime;
            }
          }
        },
        icon: Icon(
          Icons.edit,
          color: Theme.of(context).colorScheme.secondary,
        ),
      ),
    );
  }
}
