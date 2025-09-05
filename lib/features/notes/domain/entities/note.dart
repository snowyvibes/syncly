import 'package:flutter/widgets.dart';

class Note {
  final String title;
  final String description;
  final DateTime createdAt;
  final DateTime lastUpdated;
  final Color? color;

  Note({
    required this.title,
    required this.createdAt,
    required this.lastUpdated,
    this.description = '',
    this.color,
  });
}
