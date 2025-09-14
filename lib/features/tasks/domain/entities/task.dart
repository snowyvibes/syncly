class Task {
  final String id;
  final String title;
  final DateTime createdAt;
  final bool isCompleted;
  final String? description;
  final DateTime? dueDate;
  final DateTime? dueTime;
  final String? category;

  Task({
    required this.id,
    required this.title,
    required this.createdAt,
    this.isCompleted = false,
    this.description,
    this.dueDate,
    this.dueTime,
    this.category,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    DateTime? dueDate,
    DateTime? dueTime,
    DateTime? createdAt,
    String? category,
    bool? isCompleted,
  }) => Task(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description ?? this.description,
    dueDate: dueDate ?? this.dueDate,
    dueTime: dueTime ?? this.dueTime,
    createdAt: createdAt ?? this.createdAt,
    category: category ?? this.category,
    isCompleted: isCompleted ?? this.isCompleted,
  );

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String?,
    dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
    dueTime: json['dueTime'] != null ? DateTime.parse(json['dueTime']) : null,
    createdAt: DateTime.parse(json['createdAt']),
    category: json['category'] as String?,
    isCompleted: json['isCompleted'] as bool? ?? false,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'dueDate': dueDate?.toIso8601String(),
    'dueTime': dueTime?.toIso8601String(),
    'createdAt': createdAt.toIso8601String(),
    'category': category,
    'isCompleted': isCompleted,
  };
}
