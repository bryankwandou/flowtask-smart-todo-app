import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';
import 'package:uuid/uuid.dart';
import '../../reminders/services/reminder_service.dart';
import '../../../services/database_service.dart';

final databaseServiceProvider = Provider((ref) => DatabaseService());

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final db = ref.watch(databaseServiceProvider);
  return TaskNotifier(ref, db);
});

class TaskNotifier extends StateNotifier<List<Task>> {
  final Ref _ref;
  final DatabaseService _db;

  TaskNotifier(this._ref, this._db) : super([]) {
    _listenToTasks();
  }

  void _listenToTasks() {
    _db.getTasksStream().listen((tasks) {
      state = tasks;
    });
  }

  Future<void> addTask(String title, String description, int priority, DateTime deadline) async {
    try {
      final newTask = Task(
        id: '', // Will be updated by DB
        title: title,
        description: description,
        priority: priority,
        status: 'pending',
        deadline: deadline,
        createdAt: DateTime.now(),
      );
      
      final taskId = await _db.createTask(newTask);
      
      await _ref.read(reminderServiceProvider).scheduleTaskReminder(
        taskId: taskId,
        title: title,
        deadline: deadline,
      );
    } catch (e) {
      // Logic for error reporting would go here (e.g. state = ErrorState)
      rethrow;
    }
  }

  Future<void> toggleTaskStatus(String id) async {
    try {
      final task = state.firstWhere((t) => t.id == id);
      final isCompleted = task.status == 'completed';
      final newStatus = isCompleted ? 'pending' : 'completed';
      final completedAt = isCompleted ? null : DateTime.now();
      
      await _db.updateTaskStatus(id, newStatus, completedAt);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteTask(String id) async {
    try {
      await _ref.read(reminderServiceProvider).cancelReminder(id);
      await _db.deleteTask(id);
    } catch (e) {
      rethrow;
    }
  }
}
