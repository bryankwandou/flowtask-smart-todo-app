import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../features/tasks/models/task_model.dart';

class DatabaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser?.uid ?? '';

  Stream<List<Task>> getTasksStream() {
    if (_uid.isEmpty) return Stream.value([]);
    
    return _db
        .collection('tasks')
        .where('user_id', isEqualTo: _uid)
        .orderBy('created_at', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => Task.fromFirestore(doc.data(), doc.id))
            .toList());
  }

  Future<String> createTask(Task task) async {
    final docRef = _db.collection('tasks').doc();
    final taskId = docRef.id;
    
    await docRef.set({
      ...task.toJson(),
      'id': taskId,
      'user_id': _uid,
    });
    
    // Update simple stats for analytics
    await _updateStats(completedIncrement: 0);
    
    return taskId;
  }

  Future<void> updateTaskStatus(String id, String status, DateTime? completedAt) async {
    await _db.collection('tasks').doc(id).update({
      'status': status,
      'completed_at': completedAt != null ? Timestamp.fromDate(completedAt) : null,
    });

    if (status == 'completed') {
      await _updateStats(completedIncrement: 1);
    }
  }

  Future<void> deleteTask(String id) async {
    await _db.collection('tasks').doc(id).delete();
  }

  Future<void> _updateStats({required int completedIncrement}) async {
    final statsRef = _db.collection('productivity_stats').doc(_uid);
    
    await _db.runTransaction((transaction) async {
      final snapshot = await transaction.get(statsRef);
      if (!snapshot.exists) {
        transaction.set(statsRef, {
          'user_id': _uid,
          'tasks_completed': completedIncrement,
          'daily_streak': completedIncrement > 0 ? 1 : 0,
          'last_completed_at': FieldValue.serverTimestamp(),
        });
      } else {
        final currentCompleted = (snapshot.data()?['tasks_completed'] ?? 0) as int;
        transaction.update(statsRef, {
          'tasks_completed': currentCompleted + completedIncrement,
        });
      }
    });
  }
}
