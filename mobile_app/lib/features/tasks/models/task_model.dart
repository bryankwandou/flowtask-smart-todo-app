class Task {
  final String id;
  final String title;
  final String description;
  final int priority; // 1: Low, 2: Medium, 3: High
  final String status; // pending, completed
  final DateTime deadline;
  final DateTime createdAt;
  final DateTime? completedAt;
  final String category;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.deadline,
    required this.createdAt,
    this.completedAt,
    this.category = 'General',
  });

  factory Task.fromMap(Map<String, dynamic> data) {
    return Task(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      priority: data['priority'] ?? 1,
      status: data['status'] ?? 'pending',
      deadline: DateTime.parse(data['deadline']),
      createdAt: DateTime.parse(data['created_at']),
      completedAt: data['completed_at'] != null ? DateTime.parse(data['completed_at']) : null,
      category: data['category'] ?? 'General',
    );
  }

  Task copyWith({
    String? id,
    String? title,
    String? description,
    int? priority,
    String? status,
    DateTime? deadline,
    DateTime? createdAt,
    DateTime? completedAt,
    String? category,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      deadline: deadline ?? this.deadline,
      createdAt: createdAt ?? this.createdAt,
      completedAt: completedAt ?? this.completedAt,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'deadline': deadline.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
      'completed_at': completedAt?.toIso8601String(),
      'category': category,
    };
  }
}
