import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/tasks/presentation/pages/add_task/widgets/index.dart';

class AddTaskPage extends ConsumerWidget {
  AddTaskPage({super.key});

  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
              const AddTaskAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: AppSizes.columnSpacing,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddTaskTitle(titleController: _titleController),
                      const AddTaskDate(),
                      const AddTaskTime(),
                      AddTaskDescription(descriptionController: _descriptionController),
                      TaskCategoryChips(),
                    ],
                  ),
                ),
              ),
              AddTaskButtons(
                titleController: _titleController,
                descriptionController: _descriptionController,
                formKey: _formKey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
