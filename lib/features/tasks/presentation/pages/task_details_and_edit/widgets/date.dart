import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncly/core/widgets/list_tile.dart';
import 'package:syncly/features/tasks/presentation/pages/task_details_and_edit/task_details_page.dart';
import 'package:syncly/features/tasks/presentation/pages/task_details_and_edit/widgets/time.dart';
import 'package:syncly/features/tasks/presentation/providers/task_details_provider.dart';

class EditTaskDate extends ConsumerWidget {
  const EditTaskDate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editTaskDate = ref.watch(editTaskDateProvider);
    final editTaskDateNotifier = ref.read(editTaskDateProvider.notifier);

    return Card(
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomListTile(
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
          ),
          const Divider(
            thickness: 1,
            height: 1,
          ),
          const EditTaskTime(),
        ],
      ),
    );
  }
}
