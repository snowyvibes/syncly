import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';
import 'package:syncly/features/tasks/presentation/widgets/task_details_and_edit/buttons.dart';
import 'package:syncly/features/tasks/presentation/widgets/task_details_and_edit/category_picker.dart';
import 'package:syncly/features/tasks/presentation/widgets/task_details_and_edit/date_and_time.dart';
import 'package:syncly/features/tasks/presentation/widgets/task_details_and_edit/title_and_description.dart';
import 'package:syncly/features/tasks/presentation/providers/task_details_provider.dart';

class TaskDetailsPage extends ConsumerStatefulWidget {
  const TaskDetailsPage(this.task, {super.key});

  final Task task;

  ConsumerState<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends ConsumerState<TaskDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  // Initialize providers with task data if they're null
  void preAssignProviders() {
    if (widget.task.dueDate != null) {
      ref.read(editTaskDateProvider.notifier).state = widget.task.dueDate;
    }
    if (widget.task.dueTime != null) {
      ref.read(editTaskTimeProvider.notifier).state = widget.task.dueTime;
    }
    if (widget.task.category != null) {
      ref.read(editTaskCategoryProvider.notifier).state = widget.task.category;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => preAssignProviders());
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  spacing: AppSizes.columnSpacing,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TaskTitleAndDescription(task: widget.task),
                    const EditTaskDateAndTime(),
                    const EditTaskCategoryPicker(),
                  ],
                ),
              ),
            ),
            EditTaskButtons(task: widget.task),
          ],
        ),
      ),
    );
  }
}
