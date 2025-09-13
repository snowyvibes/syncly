import 'package:syncly/features/notes/domain/entities/note.dart';

abstract class NotesRepository {
  Future<List<Note>> getAllNotes();
  Future<List<Note>> getNotesByFolder(String folder);
  Future<Note?> getNoteById(String id);
  Future<void> addNote(Note note);
  Future<void> updateNote(Note note);
  Future<void> deleteNote(String id);
  Future<List<String>> getAllFolders();
  Future<List<Note>> searchNotes(String searchTerm);
  Future<int> countNotesInFolder(String folder);
}
