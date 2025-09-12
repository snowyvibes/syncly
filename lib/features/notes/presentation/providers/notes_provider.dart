import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';

final notesListProvider = NotifierProvider<NotesProvider, List<Note>>(NotesProvider.new);

class NotesProvider extends Notifier<List<Note>> {
  @override
  List<Note> build() => [
    Note(
      id: '0',
      title: 'Meeting Notes',
      description: 'We discussed project timelines and deliverables.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Note(
      id: '1',
      title: 'Best Practices',
      description: 'Always write clean and maintainable code.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      lastUpdated: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Note(
      id: '2',
      title: 'Stuff to get from the store',
      description: 'Milk, Eggs, Bread, Butter, Fruits',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      lastUpdated: DateTime.now(),
    ),
  ];

  void addNote({
    required String title,
    required String content,
    required String folder,
  }) {
    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      color: const Color(0xFFFFFFFF),
      lastUpdated: DateTime.now(),
      description: content,
      createdAt: DateTime.now(),
    );
    state = [...state, newNote];
  }
}
