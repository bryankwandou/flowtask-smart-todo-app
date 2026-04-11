import 'package:flutter_riverpod/flutter_riverpod.dart';

final authStateProvider = StateProvider<bool>((ref) {
  // Simulating authentication state. Set to true to bypass login globally.
  return true; 
});
