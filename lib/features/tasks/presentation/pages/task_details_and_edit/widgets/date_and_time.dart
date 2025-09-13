import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/widgets/list_tile.dart';
import 'package:syncly/features/tasks/presentation/providers/task_details_provider.dart';

class EditTaskDateAndTime extends StatelessWidget {
  const EditTaskDateAndTime({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
      elevation: 1,
      child: Column(
        children: [
          EditTaskDate(),
          Divider(
            thickness: 1,
            height: 1,
          ),
          EditTaskTime(),
        ],
      ),
    );
  }
}

class EditTaskDate extends ConsumerWidget {
  const EditTaskDate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editTaskDate = ref.watch(editTaskDateProvider);
    final editTaskDateNotifier = ref.read(editTaskDateProvider.notifier);

    return CustomListTile(
      title: 'Date',
      subtitle:
          editTaskDate !=
              null // Use provider state
          ? '${editTaskDate.day}/${editTaskDate.month}/${editTaskDate.year}'
          : 'No Date Set',
      subtitleColor: Theme.of(context).colorScheme.primary,
      leading: const Icon(FontAwesomeIcons.calendar),
      trailing: IconButton(
        onPressed: () async {
          final selectedDate = await showDatePicker(
            context: context,
            initialDate: editTaskDate ?? DateTime.now(),
            firstDate: DateTime(2000),
            lastDate: DateTime(2100),
          );
          if (selectedDate != null) {
            editTaskDateNotifier.state = selectedDate;
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

class EditTaskTime extends ConsumerWidget {
  const EditTaskTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editTaskTime = ref.watch(editTaskTimeProvider);
    final editTaskTimeNotifier = ref.read(editTaskTimeProvider.notifier);

    print(editTaskTime);

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
            final newDateTime = DateTime(
              0,
              0,
              0,
              selectedTime.hour,
              selectedTime.minute,
            );
            editTaskTimeNotifier.state = newDateTime;
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
