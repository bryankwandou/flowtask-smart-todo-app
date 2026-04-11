import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../core/theme/colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    final prefs = await SharedPreferences.getInstance();
    final onboardingDone = prefs.getBool('onboarding_done') ?? false;

    if (context.mounted) {
      if (onboardingDone) {
        context.go('/');
      } else {
        context.go('/onboarding');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: AppColors.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.check_rounded, size: 60, color: Colors.white),
            )
            .animate()
            .scale(duration: 600.ms, curve: Curves.elasticOut)
            .shimmer(delay: 800.ms, duration: 1500.ms),
            
            const SizedBox(height: 24),
            
            const Text(
              'FlowTask',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.extrabold,
                color: Colors.white,
                letterSpacing: -1,
              ),
            )
            .animate()
            .fadeIn(delay: 400.ms)
            .slideY(begin: 0.2, end: 0),
            
            const SizedBox(height: 8),
            
            const Text(
              'Focused Progress',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                letterSpacing: 4,
              ),
            )
            .animate()
            .fadeIn(delay: 600.ms),
          ],
        ),
      ),
    );
  }
}
