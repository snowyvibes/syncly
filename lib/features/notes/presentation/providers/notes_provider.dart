import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';
import 'package:syncly/features/notes/domain/entities/note_folder.dart';

final notesListProvider = NotifierProvider<NotesProvider, List<Note>>(NotesProvider.new);

final notesFoldersProvider = Provider<List<NoteFolder>>((ref) {
  final notes = ref.watch(notesListProvider);
  final Map<String, List<Note>> folderMap = {};

  for (var note in notes) {
    if (folderMap.containsKey(note.folder)) {
      folderMap[note.folder]!.add(note);
    } else {
      if (note.folder != null) {
        folderMap[note.folder!] = [note];
      }
    }
  }

  return folderMap.entries
      .map(
        (entry) => NoteFolder(
          id: entry.key,
          name: entry.key,
          numberOfNotes: entry.value.length,
          notes: entry.value,
        ),
      )
      .toList();
});

class NotesProvider extends Notifier<List<Note>> {
  @override
  List<Note> build() => [
    Note(
      id: '0',
      title: 'Meeting Notes',
      folder: 'Work',
      description: 'We discussed project timelines and deliverables.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      lastUpdated: DateTime.now().subtract(const Duration(days: 1)),
    ),
    Note(
      id: '1',
      title: 'Best Practices',
      folder: 'Work',
      description: 'Always write clean and maintainable code.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      lastUpdated: DateTime.now().subtract(const Duration(days: 3)),
    ),
    Note(
      id: '2',
      title: 'Stuff to get from the store',
      folder: 'Personal',
      description: 'Milk, Eggs, Bread, Butter, Fruits',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      lastUpdated: DateTime.now(),
    ),
    Note(
      id: '3',
      title: 'Study Plan',
      folder: 'Study',
      description: 'Focus on Flutter and Dart for the next two weeks.',
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

      lastUpdated: DateTime.now(),
      description: content,
      folder: folder,
      createdAt: DateTime.now(),
    );
    state = [...state, newNote];
  }

  void updateNote(Note updatedNote) {
    state = [
      for (final note in state)
        if (note.id == updatedNote.id) updatedNote else note,
    ];
  }

  void deleteNote(String id) {
    state = state.where((note) => note.id != id).toList();
  }
}
