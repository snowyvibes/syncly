class Task {
  final String id;
  final String title;
  final String? description;
  final DateTime? dueDate;
  final DateTime createdAt;
  final List<String>? categories;
  final bool isCompleted;

  Task({
    required this.id,
    required this.title,
    this.description,
    required this.createdAt,
    this.dueDate,
    this.categories,
    this.isCompleted = false,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    DateTime? createdAt,
    List<String>? tags,
    bool? isCompleted,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    dueDate: dueDate ?? this.dueDate,
    createdAt: createdAt ?? this.createdAt,
    categories: tags ?? this.categories,
    isCompleted: isCompleted ?? this.isCompleted,
  );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String?,
    dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    createdAt: DateTime.parse(json['createdAt']),
    categories: json['tags'] != null ? List<String>.from(json['tags']) : null,
    isCompleted: json['isCompleted'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate?.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'tags': categories,
    'isCompleted': isCompleted,
  };
}
