class Task {
  final String title;
  final String? description;
  final DateTime? dueDate;
  final DateTime createdAt;
  final List<String>? tags;

  Task({
    required this.title,
    this.description,
    required this.createdAt,
    this.dueDate,
    this.tags,
  });
}
