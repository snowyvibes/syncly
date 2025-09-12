import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/custom_outlined_button.dart';
import 'package:syncly/core/widgets/filled_button.dart';
import 'package:syncly/core/widgets/segmented_button.dart';
import 'package:syncly/core/widgets/text_field.dart';
import 'package:syncly/features/tasks/presentation/providers/add_task_provider.dart';
import 'package:syncly/features/tasks/presentation/providers/tasks_provider.dart';

class AddTaskPage extends ConsumerWidget {
  AddTaskPage({super.key});

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksProviderNotifier = ref.read(tasksListProvider.notifier);

    return Form(
      key: _formKey,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSizes.columnSpacing,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add Task',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const TaskDateTimePicker(),
                      Text('Title', style: Theme.of(context).textTheme.titleSmall),
                      CustomTextField(
                        controller: _titleController,
                        hintText: 'Task title',
                        validator: (value) {
                          if (value?.isEmpty ?? true) {
                            return 'Please enter a task title';
                          }
                          return null;
                        },
                      ),
                      Text('Description', style: Theme.of(context).textTheme.titleSmall),
                      CustomTextField(
                        controller: _descriptionController,
                        hintText: 'Task description (optional)',
                        maxLines: 3,
                      ),
                      Text('Category', style: Theme.of(context).textTheme.titleSmall),
                      TaskCategoryChips(),
                    ],
                  ),
                ),
              ),

              Row(
                spacing: AppSizes.rowSpacing,
                children: [
                  Expanded(
                    child: CustomOutlinedButton(
                      onPressed: () {
                        _titleController.clear();
                        _titleController.dispose();
                        _descriptionController.clear();
                        _descriptionController.dispose();
                        Navigator.pop(context);
                      },
                      text: 'Cancel',
                    ),
                  ),
                  Expanded(
                    child: CustomFilledButton(
                      onPressed: () {
                        if (_formKey.currentState != null && _formKey.currentState!.validate()) {
                          tasksProviderNotifier.addTask(
                            title: _titleController.text,
                            description: _descriptionController.text,
                            categories: [],
                            dueDate: DateTime.now(),
                          );
                        }
                      },
                      text: 'Add Task',
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TaskDateTimePicker extends StatefulWidget {
  const TaskDateTimePicker({super.key});

  @override
  State<TaskDateTimePicker> createState() => _TaskDateTimePickerState();
}

class _TaskDateTimePickerState extends State<TaskDateTimePicker> {
  int _selectedIndex = 0;

  DateTime selectedDate = DateTime.now().add(const Duration(hours: 23, minutes: 59));
  TimeOfDay selectedTime = TimeOfDay.now();

  String pickedDateTime = 'Pick a Date';

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('Due Time', style: Theme.of(context).textTheme.titleSmall),
      CustomSegmentedButton(
        onValueChanged: (newIndex) {
          setState(() {
            _selectedIndex = newIndex ?? 0;
          });
          print(_selectedIndex);
        },
        segments: [
          'Today',
          'Tomorrow',
          pickedDateTime,
        ],
        selected: _selectedIndex,
        label: 'Category',
      ),
    ],
  );
}

class TaskCategoryChips extends ConsumerWidget {
  TaskCategoryChips({super.key});

  int _selectedIndex = 0;

  List<String> categories = ['Personal', 'Work', 'Shopping', 'Health', 'Finance', 'Others'];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCategories = ref.watch(addTaskCategoryProvider);

    return Wrap(
      spacing: AppSizes.rowSpacing / 2,
      children: List.generate(
        categories.length,
        (index) {
          final category = categories[index];
          final isSelected = selectedCategories == category;

          return ChoiceChip(
            checkmarkColor: Theme.of(context).colorScheme.onPrimary,
            onSelected: (selected) {
              if (selected) ref.read(addTaskCategoryProvider.notifier).state = category;
              print(selectedCategories);
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
    );
  }
}
