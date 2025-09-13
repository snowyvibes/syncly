import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/title.dart';
import 'package:syncly/features/tasks/presentation/providers/add_task_provider.dart';

class AddTaskTime extends ConsumerWidget {
  const AddTaskTime({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskTime = ref.watch(addTaskTimeProvider);

    print(taskTime);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Pick Time'),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.borderRadius),
            border: Border.all(
              color: Theme.of(context).colorScheme.outline.withOpacity(0.5),
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppSizes.borderRadius),
              onTap: () => selectTime(context, ref),
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.padding / 2),
                child: Row(
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      color: Theme.of(context).colorScheme.primary,
                      size: 20,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      taskTime != null ? DateTimeHandler.formatTime(taskTime) : 'Pick a Time',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurface,
                      ),
                    ),
                    const Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Theme.of(context).colorScheme.outline,
                      size: AppSizes.iconSize,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> selectTime(BuildContext context, WidgetRef ref) async {
    final taskTimeNotifier = ref.read(addTaskTimeProvider.notifier);

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return child!;
      },
    );
    print(selectedTime);

    if (selectedTime != null) {
      final newTime = DateTime(
        selectedTime.hour,
        selectedTime.minute,
      );
      taskTimeNotifier.state = newTime;
    }
  }
}
