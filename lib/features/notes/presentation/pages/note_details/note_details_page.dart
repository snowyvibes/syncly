import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';
import 'package:syncly/features/notes/presentation/providers/notes_provider.dart';

class NoteDetailsPage extends ConsumerStatefulWidget {
  const NoteDetailsPage(this.note, {super.key});

  final Note note;

  @override
  ConsumerState<NoteDetailsPage> createState() => _NoteDetailsPageState();
}

class _NoteDetailsPageState extends ConsumerState<NoteDetailsPage> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _descriptionController = TextEditingController(text: widget.note.content);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final notesNotifier = ref.read(notesListProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.note.title),
        leading: IconButton(
          icon: const Icon(Icons.chevron_left, size: AppSizes.iconSize),
          color: Theme.of(context).colorScheme.onSurface,
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          onPressed: () {
            final updatedNote = widget.note.copyWith(
              title: _titleController.text,
              content: _descriptionController.text,
              lastUpdated: DateTime.now(),
            );
            notesNotifier.updateNote(updatedNote);
            context.pop();
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, size: AppSizes.iconSize),
            color: Theme.of(context).colorScheme.primary,
            style: IconButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.surface,
            ),
            onPressed: () {
              final updatedNote = widget.note.copyWith(
                title: _titleController.text,
                content: _descriptionController.text,
                lastUpdated: DateTime.now(),
              );
              notesNotifier.updateNote(updatedNote);
              FocusScope.of(context).unfocus();
            },
          ),
        ],
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
                textInputAction: TextInputAction.next,
                maxLengthEnforcement: MaxLengthEnforcement.truncateAfterCompositionEnds,
              ),
              const SizedBox(height: AppSizes.size16),
              Expanded(
                child: TextField(
                  controller: _descriptionController,
                  textInputAction: TextInputAction.newline,
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
                  keyboardType: TextInputType.multiline,

                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface.withOpacity(0.7),
                  ),
                  maxLines: null,
                  expands: true,

                  textAlignVertical: TextAlignVertical.top,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
