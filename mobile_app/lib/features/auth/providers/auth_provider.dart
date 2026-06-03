import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../services/auth_service.dart';

// Simple model for local user
class LocalUser {
  final String email;
  LocalUser({required this.email});
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

final userProvider = StateProvider<LocalUser?>((ref) {
  return null; // Initial state
});

class AuthRepository {
  Future<bool> isLoggedIn() => AuthService.isLoggedIn();

  Future<void> login(String email, String password) async {
    await AuthService.login(email, password);
  }

  Future<void> register(String email, String password) async {
    await AuthService.register(email, password);
  }

  Future<void> signOut() async {
    await AuthService.logout();
  }

  Future<void> deleteAccount(String password) async {
    await AuthService.deleteAccount(password);
  }
}
