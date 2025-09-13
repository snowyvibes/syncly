import 'package:syncly/features/notes/domain/entities/note.dart';

class AppNoteFolder {
  final String id;
  final String name;
  final int numberOfNotes;
  final List<Note> notes;

  const AppNoteFolder({
    required this.id,
    required this.name,
    required this.numberOfNotes,
    required this.notes,
  });

  AppNoteFolder copyWith({
    String? name,
    int? numberOfNotes,
    List<Note>? notes,
  }) {
    return AppNoteFolder(
      id: id,
      name: name ?? this.name,
      notes: notes ?? this.notes,
      numberOfNotes: numberOfNotes ?? this.numberOfNotes,
    );
  }
}
