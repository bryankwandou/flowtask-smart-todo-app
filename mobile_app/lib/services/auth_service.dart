import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../features/reminders/services/reminder_service.dart';

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
    try {
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
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected registration error occurred.';
    }
  }

  static Future<void> login(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw _handleAuthException(e);
    } catch (e) {
      throw 'An unexpected login error occurred.';
    }
  }

  static Future<void> logout() async {
    await _auth.signOut();
  }

  static Future<void> markOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  /// Hardened Account Deletion for Google Play Compliance
  static Future<void> deleteAccount(String password) async {
    final user = _auth.currentUser;
    if (user != null && user.email != null) {
      try {
        final uid = user.uid;
        final email = user.email!;

        // 1. Re-authenticate and Clear Hardware Assets
        AuthCredential credential = EmailAuthProvider.credential(email: email, password: password);
        await user.reauthenticateWithCredential(credential);

        // Clear all scheduled local notifications/reminders
        await ReminderService().cancelAllReminders();

        // 2. Clear Firestore Collections
        await _firestore.collection('productivity_stats').doc(uid).delete();
        
        final tasksQuery = await _firestore.collection('tasks').where('user_id', isEqualTo: uid).get();
        final batch = _firestore.batch();
        for (var doc in tasksQuery.docs) {
          batch.delete(doc.reference);
        }
        await batch.commit();
        await _firestore.collection('users').doc(uid).delete();

        // 3. Delete Auth User
        await user.delete();

        // 4. Clear Local Cache
        final prefs = await SharedPreferences.getInstance();
        await prefs.clear();
      } on FirebaseAuthException catch (e) {
        throw _handleAuthException(e);
      } catch (e) {
        throw 'Failed to delete account. Please try again later.';
      }
    }
  }
  static String _handleAuthException(FirebaseAuthException e) {
    switch (e.code) {
      case 'user-not-found': return 'No user found for that email.';
      case 'wrong-password': return 'Wrong password provided.';
      case 'email-already-in-use': return 'The email address is already in use.';
      case 'invalid-email': return 'The email address is invalid.';
      case 'weak-password': return 'The password is too weak.';
      case 'requires-recent-login': return 'Session expired. Please log in again before deleting your account.';
      default: return e.message ?? 'Authentication failed.';
    }
  }
}


