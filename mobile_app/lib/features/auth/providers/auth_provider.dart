import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../services/auth_service.dart';

final firebaseAuthProvider = Provider<FirebaseAuth>((ref) => FirebaseAuth.instance);
final firestoreProvider = Provider<FirebaseFirestore>((ref) => FirebaseFirestore.instance);

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(firebaseAuthProvider), ref.watch(firestoreProvider));
});

final userProvider = StreamProvider<User?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges;
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
  /// Deletes all user data (Firestore, Reminders, and Auth).
  /// Note: Prefers using AuthService for re-authentication security.
  Future<void> deleteAccount({String? password}) async {
    if (password != null) {
      await AuthService.deleteAccount(password);
    } else {
      // Fallback for flows without direct password input (e.g. recent login)
      // BUT we should really always use the password flow for security.
      throw Exception('Re-authentication required. Please use the Security settings to delete your account.');
    }
  }
}

