import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import 'package:uuid/uuid.dart';

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    _loadMockData(); // Initial offline state before Firebase connection
  }

  void _loadMockData() {
    state = [
      Task(
        id: const Uuid().v4(),
        title: 'Complete System Architecture',
        description: 'Document the data flow between Flutter and Firebase.',
        priority: 3,
        status: 'pending',
        deadline: DateTime.now().add(const Duration(hours: 24)),
        createdAt: DateTime.now(),
      ),
      Task(
        id: const Uuid().v4(),
        title: 'Review Play Store Legal Docs',
        description: 'Check privacy policy compliance.',
        priority: 2,
        status: 'completed',
        deadline: DateTime.now().subtract(const Duration(hours: 2)),
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        completedAt: DateTime.now().subtract(const Duration(hours: 5)),
      ),
    ];
  }

  void addTask(String title, String description, int priority, DateTime deadline) {
    final newTask = Task(
      id: const Uuid().v4(),
      title: title,
      description: description,
      priority: priority,
      status: 'pending',
      deadline: deadline,
      createdAt: DateTime.now(),
    );
    state = [...state, newTask];
  }

  void toggleTaskStatus(String id) {
    state = state.map((task) {
      if (task.id == id) {
        final isCompleted = task.status == 'completed';
        return task.copyWith(
          status: isCompleted ? 'pending' : 'completed',
          completedAt: isCompleted ? null : DateTime.now(),
        );
      }
      return task;
    }).toList();
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}
