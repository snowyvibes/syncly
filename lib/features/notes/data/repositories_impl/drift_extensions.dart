import 'package:drift/drift.dart';
import 'package:syncly/features/notes/data/sources/local/drift.dart';
import 'package:syncly/features/notes/domain/entities/note.dart' as domain;

extension NoteToDomain on Note {
  domain.Note toDomain() {
    return domain.Note(
      id: id,
      title: title,
      description: description,
      createdAt: createdAt,
      lastUpdated: lastUpdated,
      folder: folder,
    );
  }
}

extension DomainNoteToCompanion on domain.Note {
  NotesCompanion toCompanion() {
    return NotesCompanion(
      id: Value(id),
      title: Value(title),
      description: Value(description),
      createdAt: Value(createdAt),
      lastUpdated: Value(lastUpdated),
      folder: Value(folder),
    );
  }
}

extension DomainNoteToNote on domain.Note {
  Note toNote() {
    return Note(
      id: id,
      title: title,
      description: description,
      createdAt: createdAt,
      lastUpdated: lastUpdated,
      folder: folder,
    );
  }
}
