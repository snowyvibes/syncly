import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncly/core/widgets/list_tile.dart';
import 'package:syncly/features/tasks/presentation/providers/task_details_provider.dart';

class EditTaskCategoryPicker extends ConsumerWidget {
  const EditTaskCategoryPicker({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final editTaskCategory = ref.watch(editTaskCategoryProvider);
    final editTaskCategoryNotifier = ref.read(editTaskCategoryProvider.notifier);

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 1,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomListTile(
              title: 'Category',
              subtitle: editTaskCategory ?? 'No Category Selected', // Use provider state
              subtitleColor: Theme.of(context).colorScheme.primary,
              leading: const Icon(FontAwesomeIcons.tag),
              trailing: IconButton(
                onPressed: () {
                  // Show category picker dialog
                  _showCategoryPicker(context, editTaskCategoryNotifier);
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
    );
  }

  void _showCategoryPicker(BuildContext context, StateController<String?> categoryNotifier) {
    const categories = ['Personal', 'Work', 'Shopping', 'Health', 'Finance', 'Others'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Category'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: categories
              .map(
                (category) => ListTile(
                  title: Text(category),
                  onTap: () {
                    categoryNotifier.state = category;
                    Navigator.pop(context);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
