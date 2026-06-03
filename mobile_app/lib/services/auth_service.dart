import 'package:shared_preferences/shared_preferences.dart';
import '../features/reminders/services/reminder_service.dart';
import 'database_service.dart';

class AuthService {
  static const String _onboardingKey = 'onboarding_done';
  static const String _userKey = 'local_user_email';

  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userKey) != null;
  }

  static Future<bool> isOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingKey) ?? false;
  }

  static Future<void> register(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, email);
    // Offline mode: We just save the email locally as the "user account"
  }

  static Future<void> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, email);
    // Offline mode: We allow any login locally for now, just saving the session.
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_userKey);
  }

  static Future<void> markOnboardingDone() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingKey, true);
  }

  static Future<void> deleteAccount(String password) async {
    // 1. Clear all scheduled local notifications/reminders
    await ReminderService().cancelAllReminders();

    // 2. Clear Database
    await DatabaseService().clearAllData();

    // 3. Clear Local Cache and Data
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
  }
}
