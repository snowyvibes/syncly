import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/custom_outlined_button.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';

class NoteDetailsPage extends StatefulWidget {
  const NoteDetailsPage(this.note, {super.key});

  final Note note;

  @override
  State<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends State<NoteDetailsPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _descriptionController = TextEditingController(text: widget.note.description);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(widget.note.title),
    ),
    body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.padding),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                hintText: 'Title',
                border: InputBorder.none,
                fillColor: Colors.transparent,
                contentPadding: EdgeInsets.zero,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
              ),

              style: Theme.of(context).textTheme.titleSmall,
              maxLines: null,
            ),
            const SizedBox(height: AppSizes.size16),
            Expanded(
              child: TextField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                  hintText: 'Start writing...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                  fillColor: Colors.transparent,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                ),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: CustomOutlinedButton(
                    text: 'Delete',
                    color: Colors.red,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete Note'),
                          content: const Text(
                            'Are you sure you want to delete this note? This action cannot be undone.',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () {
                                // Handle note deletion logic here
                                Navigator.of(context).pop(); // Close the dialog
                                Navigator.of(context).pop(); // Go back to the previous screen
                              },
                              child: const Text('Delete', style: TextStyle(color: Colors.red)),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomOutlinedButton(text: 'Save', onPressed: () {}),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
