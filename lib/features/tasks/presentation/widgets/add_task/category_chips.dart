import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/title.dart';
import 'package:syncly/features/tasks/presentation/providers/add_task_provider.dart';

class TaskCategoryChips extends ConsumerWidget {
  TaskCategoryChips({super.key});
  final List<String> categories = ['Personal', 'Work', 'Shopping', 'Health', 'Finance', 'Others'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskCategory = ref.watch(addTaskCategoryProvider);
    final taskCategoryNotifier = ref.read(addTaskCategoryProvider.notifier);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionTitle('Category'),
        Wrap(
          spacing: AppSizes.rowSpacing,
          // runSpacing: AppSizes.rowSpacing / 2,
          children: List.generate(
            categories.length,
            (index) {
              final category = categories[index];
              final isSelected = taskCategory == category;

              return ChoiceChip(
                checkmarkColor: Theme.of(context).colorScheme.onPrimary,
                onSelected: (selected) {
                  if (selected) taskCategoryNotifier.state = category;
                  print(taskCategoryNotifier.state);
                },

                selected: isSelected,
                backgroundColor: isSelected ? Theme.of(context).colorScheme.primary : null,
                label: Text(
                  categories[index],
                  style: TextStyle(
                    color: isSelected
                        ? Theme.of(context).colorScheme.onPrimary
                        : Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
