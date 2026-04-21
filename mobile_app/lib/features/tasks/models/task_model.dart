import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final int priority; // 1: Low, 2: Medium, 3: High
  final String status; // pending, completed
  final DateTime deadline;
  final DateTime createdAt;
  final DateTime? completedAt;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.priority,
    required this.status,
    required this.deadline,
    required this.createdAt,
    this.completedAt,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    int? priority,
    String? status,
    DateTime? deadline,
    DateTime? createdAt,
    DateTime? completedAt,
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
    );
  }

  factory Task.fromFirestore(Map<String, dynamic> data, String id) {
    return Task(
      id: id,
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      priority: data['priority'] ?? 1,
      status: data['status'] ?? 'pending',
      deadline: (data['deadline'] as Timestamp).toDate(),
      createdAt: (data['created_at'] as Timestamp).toDate(),
      completedAt: (data['completed_at'] as Timestamp?)?.toDate(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'priority': priority,
      'status': status,
      'deadline': Timestamp.fromDate(deadline),
      'created_at': Timestamp.fromDate(createdAt),
      'completed_at': completedAt != null ? Timestamp.fromDate(completedAt!) : null,
    };
  }
}

