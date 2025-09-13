import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncly/features/notes/domain/entities/note.dart';
import 'package:syncly/features/notes/domain/entities/note_folder.dart';
import 'package:syncly/features/notes/presentation/providers/notes_provider.dart';

void main() {
  group('Note Model Tests', () {
    test('should create a note with required properties', () {
      final note = Note(
        id: '1',
        title: 'Test Note',
        description: 'Test Description',
        folder: 'Work',
        createdAt: DateTime.now(),
        lastUpdated: DateTime.now(),
      );

      expect(note.id, '1');
      expect(note.title, 'Test Note');
      expect(note.description, 'Test Description');
      expect(note.folder, 'Work');
      expect(note.createdAt, isA<DateTime>());
      expect(note.lastUpdated, isA<DateTime>());
    });

    test('should update note properties with copyWith', () {
      final note = Note(
        id: '1',
        title: 'Original Title',
        description: 'Original Description',
        folder: 'Work',
        createdAt: DateTime.now(),
        lastUpdated: DateTime.now(),
      );

      final updatedNote = note.copyWith(
        title: 'Updated Title',
        description: 'Updated Description',
        folder: 'Personal',
      );

      expect(updatedNote.title, 'Updated Title');
      expect(updatedNote.description, 'Updated Description');
      expect(updatedNote.folder, 'Personal');
      expect(updatedNote.id, note.id);
      expect(updatedNote.createdAt, note.createdAt);
    });

    test('should convert note to JSON', () {
      final note = Note(
        id: '1',
        title: 'Test Note',
        description: 'Test Description',
        folder: 'Work',
        createdAt: DateTime(2023),
        lastUpdated: DateTime(2023),
      );

      final json = note.toJson();

      expect(json['id'], '1');
      expect(json['title'], 'Test Note');
      expect(json['description'], 'Test Description');
      expect(json['folder'], 'Work');
      expect(json['createdAt'], isA<String>());
      expect(json['lastUpdated'], isA<String>());
    });

    test('should create note from JSON', () {
      final json = {
        'id': '1',
        'title': 'Test Note',
        'description': 'Test Description',
        'folder': 'Work',
        'color': 0xFFFFFFFF,
        'createdAt': '2023-01-01T00:00:00.000',
        'lastUpdated': '2023-01-01T00:00:00.000',
      };

      final note = Note.fromJson(json);

      expect(note.id, '1');
      expect(note.title, 'Test Note');
      expect(note.description, 'Test Description');
      expect(note.folder, 'Work');
      expect(note.createdAt, DateTime(2023));
      expect(note.lastUpdated, DateTime(2023));
    });
  });

  group('NoteFolder Model Tests', () {
    test('should create a note folder with required properties', () {
      final notes = [
        Note(
          id: '1',
          title: 'Note 1',
          description: 'Description 1',
          folder: 'Work',
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now(),
        ),
        Note(
          id: '2',
          title: 'Note 2',
          description: 'Description 2',
          folder: 'Work',
          createdAt: DateTime.now(),
          lastUpdated: DateTime.now(),
        ),
      ];

      final folder = AppNoteFolder(
        id: 'work-folder',
        name: 'Work',
        numberOfNotes: 2,
        notes: notes,
      );

      expect(folder.id, 'work-folder');
      expect(folder.name, 'Work');
      expect(folder.numberOfNotes, 2);
      expect(folder.notes.length, 2);
    });
  });

  group('NotesProvider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should have initial notes', () {
      final notes = container.read(notesListProvider);

      expect(notes.isNotEmpty, true);
      expect(notes.length, 4);
    });

    test('should contain expected initial notes', () {
      final notes = container.read(notesListProvider);

      expect(notes.any((note) => note.title == 'Meeting Notes'), true);
      expect(notes.any((note) => note.title == 'Best Practices'), true);
      expect(notes.any((note) => note.title == 'Stuff to get from the store'), true);
      expect(notes.any((note) => note.title == 'Study Plan'), true);
    });

    test('should add a new note', () {
      final notifier = container.read(notesListProvider.notifier);
      final initialCount = container.read(notesListProvider).length;

      notifier.addNote(
        title: 'New Test Note',
        content: 'Test Content',
        folder: 'Test',
      );

      final notes = container.read(notesListProvider);
      expect(notes.length, initialCount + 1);
      expect(notes.last.title, 'New Test Note');
      expect(notes.last.description, 'Test Content');
      expect(notes.last.folder, 'Test');
    });

    test('should update existing note', () {
      final notifier = container.read(notesListProvider.notifier);
      final notes = container.read(notesListProvider);
      final firstNote = notes.first;

      final updatedNote = firstNote.copyWith(
        title: 'Updated Note Title',
        description: 'Updated Description',
        folder: 'Updated Folder',
      );

      notifier.updateNote(updatedNote);

      final updatedNotes = container.read(notesListProvider);
      final result = updatedNotes.firstWhere((note) => note.id == firstNote.id);

      expect(result.title, 'Updated Note Title');
      expect(result.description, 'Updated Description');
      expect(result.folder, 'Updated Folder');
      expect(result.id, firstNote.id);
    });

    test('should preserve other notes when updating one note', () {
      final notifier = container.read(notesListProvider.notifier);
      final notes = container.read(notesListProvider);
      final firstNote = notes.first;
      final initialCount = notes.length;

      final updatedNote = firstNote.copyWith(title: 'Updated Title');
      notifier.updateNote(updatedNote);

      final updatedNotes = container.read(notesListProvider);
      expect(updatedNotes.length, initialCount);

      final otherNotes = updatedNotes.where((note) => note.id != firstNote.id);
      expect(otherNotes.length, initialCount - 1);
    });

    test('should delete note', () {
      final notifier = container.read(notesListProvider.notifier);
      final notes = container.read(notesListProvider);
      final noteToDelete = notes.first;
      final initialCount = notes.length;

      notifier.deleteNote(noteToDelete.id);

      final updatedNotes = container.read(notesListProvider);
      expect(updatedNotes.length, initialCount - 1);
      expect(
        updatedNotes.any((note) => note.id == noteToDelete.id),
        false,
      );
    });

    test('should not affect other notes when deleting one', () {
      final notifier = container.read(notesListProvider.notifier);
      final notes = container.read(notesListProvider);
      final noteToDelete = notes.first;
      final secondNote = notes[1];

      notifier.deleteNote(noteToDelete.id);

      final updatedNotes = container.read(notesListProvider);
      expect(
        updatedNotes.any((note) => note.id == secondNote.id),
        true,
      );
    });
  });

  group('Notes Folders Provider Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should create folders from existing notes', () {
      final folders = container.read(notesFoldersProvider);

      expect(folders.isNotEmpty, true);
      expect(folders.length, 3);
    });

    test('should have correct folder names', () {
      final folders = container.read(notesFoldersProvider);
      final folderNames = folders.map((folder) => folder.name).toList();

      expect(folderNames.contains('Work'), true);
      expect(folderNames.contains('Personal'), true);
      expect(folderNames.contains('Study'), true);
    });

    test('should count notes correctly in each folder', () {
      final folders = container.read(notesFoldersProvider);
      final workFolder = folders.firstWhere((folder) => folder.name == 'Work');
      final personalFolder = folders.firstWhere((folder) => folder.name == 'Personal');
      final studyFolder = folders.firstWhere((folder) => folder.name == 'Study');

      expect(workFolder.numberOfNotes, 2);
      expect(personalFolder.numberOfNotes, 1);
      expect(studyFolder.numberOfNotes, 1);
    });

    test('should include correct notes in each folder', () {
      final folders = container.read(notesFoldersProvider);
      final workFolder = folders.firstWhere((folder) => folder.name == 'Work');

      expect(workFolder.notes.length, 2);
      expect(
        workFolder.notes.any((note) => note.title == 'Meeting Notes'),
        true,
      );
      expect(
        workFolder.notes.any((note) => note.title == 'Best Practices'),
        true,
      );
    });

    test('should update folders when note is added', () {
      final notifier = container.read(notesListProvider.notifier);
      final initialFolders = container.read(notesFoldersProvider);
      final initialFolderCount = initialFolders.length;

      notifier.addNote(
        title: 'Health Note',
        content: 'Exercise daily',
        folder: 'Health',
      );

      final updatedFolders = container.read(notesFoldersProvider);
      expect(updatedFolders.length, initialFolderCount + 1);

      final healthFolder = updatedFolders.firstWhere(
        (folder) => folder.name == 'Health',
      );
      expect(healthFolder.numberOfNotes, 1);
      expect(healthFolder.notes.first.title, 'Health Note');
    });

    test('should update folder count when note is added to existing folder', () {
      final notifier = container.read(notesListProvider.notifier);
      final initialFolders = container.read(notesFoldersProvider);
      final workFolder = initialFolders.firstWhere((folder) => folder.name == 'Work');
      final initialWorkNotesCount = workFolder.numberOfNotes;

      notifier.addNote(
        title: 'Another Work Note',
        content: 'More work stuff',
        folder: 'Work',
      );

      final updatedFolders = container.read(notesFoldersProvider);
      final updatedWorkFolder = updatedFolders.firstWhere(
        (folder) => folder.name == 'Work',
      );

      expect(updatedWorkFolder.numberOfNotes, initialWorkNotesCount + 1);
    });

    test('should remove folder when all notes are deleted', () {
      final notifier = container.read(notesListProvider.notifier);
      final notes = container.read(notesListProvider);
      final studyNotes = notes.where((note) => note.folder == 'Study').toList();

      for (final note in studyNotes) {
        notifier.deleteNote(note.id);
      }

      final updatedFolders = container.read(notesFoldersProvider);
      expect(
        updatedFolders.any((folder) => folder.name == 'Study'),
        false,
      );
    });
  });

  group('Integration Tests', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('should maintain consistency between notes and folders', () {
      final notifier = container.read(notesListProvider.notifier);

      notifier.addNote(title: 'Note 1', content: 'Content 1', folder: 'Test1');
      notifier.addNote(title: 'Note 2', content: 'Content 2', folder: 'Test1');
      notifier.addNote(title: 'Note 3', content: 'Content 3', folder: 'Test2');

      final notes = container.read(notesListProvider);
      final folders = container.read(notesFoldersProvider);

      final totalNotesInFolders = folders
          .map((folder) => folder.numberOfNotes)
          .reduce((a, b) => a + b);

      expect(totalNotesInFolders, notes.length);
    });

    test('should update lastUpdated when note is modified', () {
      final notifier = container.read(notesListProvider.notifier);
      final notes = container.read(notesListProvider);
      final firstNote = notes.first;
      final originalLastUpdated = firstNote.lastUpdated;

      Future.delayed(const Duration(milliseconds: 10));

      final updatedNote = firstNote.copyWith(
        title: 'Updated Title',
        lastUpdated: DateTime.now(),
      );

      notifier.updateNote(updatedNote);

      final updatedNotes = container.read(notesListProvider);
      final result = updatedNotes.firstWhere((note) => note.id == firstNote.id);

      expect(result.lastUpdated.isAfter(originalLastUpdated), true);
    });
  });
}
