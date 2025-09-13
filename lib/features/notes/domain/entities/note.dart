import 'package:flutter/widgets.dart';

class Note {
  final String id;
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime lastUpdated;

  final String? folder;

  Note({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.lastUpdated,
    this.folder,
    this.description = '',
  });

  Note copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? createdAt,
    DateTime? lastUpdated,
    Color? color,
    String? folder,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
      lastUpdated: lastUpdated ?? this.lastUpdated,

      folder: folder ?? this.folder,
    );
  }

  factory Note.fromJson(Map<String, dynamic> map) {
    return Note(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String? ?? '',
      createdAt: DateTime.parse(map['createdAt'] as String),
      lastUpdated: DateTime.parse(map['lastUpdated'] as String),
      folder: map['folder'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'createdAt': createdAt.toIso8601String(),
      'lastUpdated': lastUpdated.toIso8601String(),
      'folder': folder,
    };
  }
}
