import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/notes/presentation/pages/add_note/widgets/index.dart';

class AddNotePage extends ConsumerWidget {
  AddNotePage({super.key});

  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
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
              const AddNoteAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AddNoteTitle(titleController: _titleController),
                      AddNoteContent(contentController: _contentController),
                      const AddNoteFolder(),
                    ],
                  ),
                ),
              ),
              AddNoteButtons(
                formKey: _formKey,
                titleController: _titleController,
                contentController: _contentController,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
