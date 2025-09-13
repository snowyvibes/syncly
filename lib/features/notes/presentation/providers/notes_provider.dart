import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncly/features/notes/data/repositories_impl/notes_repository_impl.dart';
import 'package:syncly/features/notes/data/sources/local/drift.dart' hide Note;
import 'package:syncly/features/notes/domain/entities/note.dart';
import 'package:syncly/features/notes/domain/entities/note_folder.dart';
import 'package:syncly/features/notes/domain/repositories/notes_repository.dart';

final notesDatabaseProvider = Provider<NotesDatabase>((ref) {
  return NotesDatabase();
});

final notesRepositoryProvider = Provider<NotesRepository>((ref) {
  final database = ref.watch(notesDatabaseProvider);
  return NotesRepositoryImpl(database);
});

final notesListProvider = NotifierProvider<NotesProvider, List<Note>>(NotesProvider.new);

final notesFoldersProvider = Provider<List<AppNoteFolder>>((ref) {
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
        (entry) => AppNoteFolder(
          id: entry.key,
          name: entry.key,
          numberOfNotes: entry.value.length,
          notes: entry.value,
        ),
      )
      .toList();
});

class NotesProvider extends Notifier<List<Note>> {
  late NotesRepository _repository;

  @override
  List<Note> build() {
    _repository = ref.read(notesRepositoryProvider);
    _loadNotes();
    return [];
  }

  Future<void> _loadNotes() async {
    final notes = await _repository.getAllNotes();

    if (notes.isEmpty) {
      final updatedNotes = await _repository.getAllNotes();
      state = updatedNotes;
    } else {
      state = notes;
    }
  }

  Future<void> addNote({
    required String title,
    required String content,
    required String folder,
  }) async {
    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: content,
      folder: folder,
      createdAt: DateTime.now(),
      lastUpdated: DateTime.now(),
    );

    await _repository.addNote(newNote);
    await _loadNotes();
  }

  Future<void> updateNote(Note updatedNote) async {
    final noteWithUpdatedTime = updatedNote.copyWith(
      lastUpdated: DateTime.now(),
    );

    await _repository.updateNote(noteWithUpdatedTime);
    await _loadNotes();
  }

  Future<void> deleteNote(String id) async {
    await _repository.deleteNote(id);
    await _loadNotes();
  }

  Future<List<Note>> searchNotes(String searchTerm) async {
    return await _repository.searchNotes(searchTerm);
  }
}
