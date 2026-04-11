import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider), ref.watch(firestoreProvider));
});

class AuthRepository {
  final FirebaseAuth _auth;
  final FirebaseFirestore _db;

  AuthRepository(this._auth, this._db);

  Stream<User?> get authStateChanges => _auth.authStateChanges();

  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// CRITICAL FOR PLAY STORE COMPLIANCE: 
  /// Deletes all user data from Firestore and then deletes the Auth account.
  Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user == null) return;

    final uid = user.uid;

    // 1. Delete user tasks
    final tasksQuery = await _db.collection('tasks').where('user_id', '==', uid).get();
    final batch = _db.batch();
    for (var doc in tasksQuery.docs) {
      batch.delete(doc.reference);
    }
    
    // 2. Delete productivity stats
    batch.delete(_db.collection('productivity_stats').doc(uid));
    
    // 3. Delete user profile
    batch.delete(_db.collection('users').doc(uid));

    // Commit Firestore deletions
    await batch.commit();

    // 4. Finally, delete the Firebase Auth account
    await user.delete();
  }
}
