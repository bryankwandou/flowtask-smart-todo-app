import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static const String _onboardingKey = 'onboarding_done';

  static Future<bool> isLoggedIn() async {
    return _auth.currentUser != null;
  }

  static Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> register(String email, String password) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );

    // Initialize user profile in Firestore
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'user_id': userCredential.user!.uid,
      'email': email,
      'created_at': FieldValue.serverTimestamp(),
      'subscription_type': 'free',
    });
  }

  static Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email: email, password: password);
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static Future<void> markOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  /// Hardened Account Deletion for Google Play Compliance
  /// This will purge both the Firebase Auth user AND the Firestore content
  static Future<void> deleteAccount() async {
    final user = _auth.currentUser;
    if (user != null) {
      final uid = user.uid;

      // 1. Purge Productivity Stats
      await _firestore.collection('productivity_stats').doc(uid).delete();

      // 2. Purge Tasks
      final tasksQuery = await _firestore.collection('tasks').where('user_id', isEqualTo: uid).get();
      for (var doc in tasksQuery.docs) {
        await doc.reference.delete();
      }

      // 3. Purge User Record
      await _firestore.collection('users').doc(uid).delete();

      // 4. Delete Auth User
      await user.delete();

      // 5. Clear Local Cache
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }
  }
}

