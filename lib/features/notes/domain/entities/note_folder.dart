import 'package:syncly/features/notes/domain/entities/note.dart';

class NoteFolder {
  final String id;
  final String name;
  final int numberOfNotes;
  final List<Note> notes;

  const NoteFolder({
    required this.id,
    required this.name,
    required this.numberOfNotes,
    required this.notes,
  });

  NoteFolder copyWith({
    String? name,
    int? numberOfNotes,
    List<Note>? notes,
  }) {
    return NoteFolder(
      id: id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      numberOfNotes: numberOfNotes ?? this.numberOfNotes,
    );
  }
}
