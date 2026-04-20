import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flowtask/core/theme/colors.dart';

class PermissionPrimingScreen extends StatelessWidget {
  const PermissionPrimingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              // Icon Header
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.notifications_active_rounded,
                  size: 80,
                  color: AppColors.primary,
                ),
              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
              
              const SizedBox(height: 48),
              
              const Text(
                'Stay in the Flow',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ).animate().fadeIn(delay: 200.ms),
              
              const SizedBox(height: 16),
              
              const Text(
                'FlowTask needs to send you smart reminders to help you maintain focus and hit your daily streaks. We use high-precision alarms to ensure your scheduled focus sessions start exactly when you need them.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: AppColors.textSecondary,
                  height: 1.5,
                ),
              ).animate().fadeIn(delay: 400.ms),
              
              const Spacer(),
              
              // CTA Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => _requestPermission(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    elevation: 10,
                    shadowColor: AppColors.primary.withOpacity(0.3),
                  ),
                  child: const Text(
                    'ENABLE REMINDERS',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ).animate().slideY(begin: 0.2, end: 0, delay: 600.ms).fadeIn(),
              
              const SizedBox(height: 16),
              
              TextButton(
                onPressed: () => context.go('/login'),
                child: const Text(
                  'Maybe Later',
                  style: TextStyle(color: AppColors.textMuted),
                ),
              ).animate().fadeIn(delay: 800.ms),
              
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _requestPermission(BuildContext context) async {
    final bool isAllowed = await AwesomeNotifications().requestPermissionToSendNotifications();
    if (context.mounted) {
      context.go('/login');
    }
  }
}
