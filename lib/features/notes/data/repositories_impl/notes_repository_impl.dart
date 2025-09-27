import 'package:syncly/features/notes/data/models/drift_extensions.dart';
import 'package:syncly/features/notes/data/sources/local/note_dao.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';
import 'package:syncly/features/notes/domain/repositories/notes_repository.dart';

class NotesRepositoryImpl implements NotesRepository {
  final NotesDao _database;

  NotesRepositoryImpl(this._database);

  @override
  Future<List<Note>> getAllNotes() async {
    final driftNotes = await _database.getAllNotes();
    return driftNotes.map((note) => note.toDomain()).toList();
  }

  @override
  Future<List<Note>> getNotesByFolder(String folder) async {
    final driftNotes = await _database.getNotesByFolder(folder);
    return driftNotes.map((note) => note.toDomain()).toList();
  }

  @override
  Future<Note?> getNoteById(String id) async {
    final driftNote = await _database.getNoteById(id);
    return driftNote?.toDomain();
  }

  @override
  Future<void> addNote(Note note) async {
    await _database.insertNote(note.toCompanion());
  }

  @override
  Future<void> updateNote(Note note) async {
    await _database.updateNote(note.toCompanion());
  }

  @override
  Future<void> deleteNote(String id) async {
    await _database.deleteNote(id);
  }

  @override
  Future<List<String>> getAllFolders() async {
    return await _database.getAllFolders();
  }

  @override
  Future<List<Note>> searchNotes(String searchTerm) async {
    final driftNotes = await _database.searchNotes(searchTerm);
    return driftNotes.map((note) => note.toDomain()).toList();
  }

  @override
  Future<int> countNotesInFolder(String folder) async {
    return await _database.countNotesInFolder(folder);
  }
}
