import 'package:drift/drift.dart';
import 'package:syncly/database/local/drift_database.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';

extension NoteToDomain on NoteTableData {
  Note toDomain() {
    return Note(
      id: id,
      title: title,
      content: content,
      createdAt: createdAt,
      lastUpdated: lastUpdated,
      folder: folder,
    );
  }
}

extension DomainNoteToCompanion on Note {
  NoteTableCompanion toCompanion() {
    return NoteTableCompanion(
      id: Value(id),
      title: Value(title),
      content: Value(content),
      createdAt: Value(createdAt),
      lastUpdated: Value(lastUpdated),
      folder: Value(folder),
    );
  }
}
