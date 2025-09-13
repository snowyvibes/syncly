import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'drift.g.dart';

class Notes extends Table {
  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get description => text().withDefault(const Constant(''))();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastUpdated => dateTime()();
  TextColumn get folder => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

@DriftDatabase(tables: [Notes])
class NotesDatabase extends _$NotesDatabase {
  NotesDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Future<List<Note>> getAllNotes() => select(notes).get();

  Future<List<Note>> getNotesByFolder(String folderName) =>
      (select(notes)..where((note) => note.folder.equals(folderName))).get();

  Future<List<Note>> getNotesWithoutFolder() =>
      (select(notes)..where((note) => note.folder.isNull())).get();

  Future<Note?> getNoteById(String id) =>
      (select(notes)..where((note) => note.id.equals(id))).getSingleOrNull();

  Future<int> insertNote(NotesCompanion note) => into(notes).insert(note);

  Future<bool> updateNote(Note note) => update(notes).replace(note);

  Future<int> deleteNote(String id) => (delete(notes)..where((note) => note.id.equals(id))).go();

  Future<int> deleteNotesByFolder(String folderName) =>
      (delete(notes)..where((note) => note.folder.equals(folderName))).go();

  Future<List<String>> getAllFolders() async {
    final query = selectOnly(notes, distinct: true)
      ..addColumns([notes.folder])
      ..where(notes.folder.isNotNull());

    final results = await query.get();
    return results.map((row) => row.read(notes.folder)!).toList();
  }

  Future<List<Note>> searchNotes(String searchTerm) {
    final lowerSearchTerm = searchTerm.toLowerCase();
    return (select(notes)
          ..where(
            (note) =>
                note.title.lower().contains(lowerSearchTerm) |
                note.description.lower().contains(lowerSearchTerm),
          )
          ..orderBy([(note) => OrderingTerm.desc(note.lastUpdated)]))
        .get();
  }

  Future<List<Note>> getNotesOrderedByLastUpdated() =>
      (select(notes)..orderBy([(note) => OrderingTerm.desc(note.lastUpdated)])).get();

  Future<List<Note>> getNotesOrderedByCreated() =>
      (select(notes)..orderBy([(note) => OrderingTerm.desc(note.createdAt)])).get();

  Future<int> countNotesInFolder(String folderName) async {
    final query = selectOnly(notes)
      ..addColumns([notes.id.count()])
      ..where(notes.folder.equals(folderName));

    final result = await query.getSingle();
    return result.read(notes.id.count()) ?? 0;
  }

  Future<List<Note>> getRecentNotes() {
    final weekAgo = DateTime.now().subtract(const Duration(days: 7));
    return (select(notes)
          ..where((note) => note.lastUpdated.isBiggerThanValue(weekAgo))
          ..orderBy([(note) => OrderingTerm.desc(note.lastUpdated)]))
        .get();
  }
}

LazyDatabase _openConnection() {
  return LazyDatabase(() async {
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'notes.db'));
    return NativeDatabase.createInBackground(file);
  });
}
