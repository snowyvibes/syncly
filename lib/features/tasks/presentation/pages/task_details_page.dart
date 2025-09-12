import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncly/core/utils/date_time_handler.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/custom_outlined_button.dart';
import 'package:syncly/core/widgets/filled_button.dart';
import 'package:syncly/core/widgets/list_tile.dart';
import 'package:syncly/features/tasks/domain/entities/task.dart';

class TaskDetailsPage extends StatefulWidget {
  const TaskDetailsPage(this.task, {super.key});

  final Task task;

  @override
  State<TaskDetailsPage> createState() => _TaskDetailsPageState();
}

class _TaskDetailsPageState extends State<TaskDetailsPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) => Form(
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
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSizes.elevation,

                      child: Padding(
                        padding: const EdgeInsets.all(AppSizes.padding),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.task.title,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),
                            Text(
                              widget.task.description ?? 'No description',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSizes.elevation,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomListTile(
                            title: 'Date',
                            subtitle: widget.task.dueDate != null
                                ? '${widget.task.dueDate!.day}/${widget.task.dueDate!.month}/${widget.task.dueDate!.year}'
                                : 'No Date Set',
                            subtitleColor: Theme.of(context).colorScheme.primary,
                            leading: const Icon(FontAwesomeIcons.calendar),
                            trailing: IconButton(
                              onPressed: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2100),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                          CustomListTile(
                            title: 'Time',
                            subtitle: widget.task.dueDate != null
                                ? DateTimeHandler.formatTime(widget.task.dueDate!)
                                : 'No Time Set',
                            subtitleColor: Theme.of(context).colorScheme.primary,
                            leading: const Icon(FontAwesomeIcons.clock),
                            trailing: IconButton(
                              onPressed: () {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                );
                              },
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Card(
                      elevation: AppSizes.elevation,

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomListTile(
                            title: 'Category',
                            subtitle: widget.task.categories != null
                                ? widget.task.categories!.join(', ')
                                : 'No Category Selected',
                            subtitleColor: Theme.of(context).colorScheme.primary,
                            leading: const Icon(FontAwesomeIcons.tag),
                            trailing: IconButton(
                              onPressed: () {},
                              icon: Icon(
                                Icons.edit,
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSizes.padding),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: AppSizes.rowSpacing,
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    text: 'Delete',
                    color: Colors.red,

                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Task'),
                          content: const Text('Are you sure you want to delete this task?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Delete the task
                                Navigator.pop(context); // Close the dialog
                                Navigator.pop(context); // Go back to previous screen
                              },
                              child: const Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  child: CustomOutlinedButton(
                    text: 'Cancel',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                Expanded(
                  child: CustomFilledButton(
                    text: 'Save',
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
