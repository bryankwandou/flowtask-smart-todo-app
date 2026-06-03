import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/database_service.dart';
import '../../reminders/services/reminder_service.dart';
import '../../auth/providers/auth_provider.dart';
import '../models/task_model.dart';

final databaseServiceProvider = Provider((ref) => DatabaseService());

final taskProvider = StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  final db = ref.watch(databaseServiceProvider);
  final user = ref.watch(userProvider);
  
  return TaskNotifier(ref, db, user?.email);
});

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier(this._ref, this._db, this._userId) : super([]) {
    _listenToTasks();
  }
  final Ref _ref;
  final DatabaseService _db;
  final String? _userId;

  void _listenToTasks() {
    // In the offline version, getTasksStream doesn't strictly need a UID, 
    // but we pass email for consistency if needed.
    _db.getTasksStream(_userId ?? 'local_user').listen((tasks) {
      state = tasks;
    });
  }

  Future<void> addTask(String title, String description, int priority, DateTime deadline) async {
    try {
      final newTask = Task(
        id: '', 
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
