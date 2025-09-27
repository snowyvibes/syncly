import 'package:drift/drift.dart';

class NoteTable extends Table {
  @override
  String get tableName => 'note_table';

  TextColumn get id => text()();
  TextColumn get title => text()();
  TextColumn get content => text().nullable()();
  TextColumn get folder => text().nullable()();
  DateTimeColumn get createdAt => dateTime()();
  DateTimeColumn get lastUpdated => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}
