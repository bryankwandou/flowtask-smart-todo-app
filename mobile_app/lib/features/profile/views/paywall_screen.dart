import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/colors.dart';

class PaywallScreen extends StatelessWidget {
  const PaywallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Background Glows
          Positioned(
            top: -100,
            right: -100,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.primary.withOpacity(0.15),
              ),
            ).animate().fadeIn(duration: 1000.ms).scale(begin: const Offset(0.5, 0.5)),
          ),
          
          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    icon: const Icon(Icons.close_rounded, color: Colors.white38),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
                
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 32),
                    child: Column(
                      children: [
                        const SizedBox(height: 20),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: AppColors.primaryGradient,
                            boxShadow: [
                              BoxShadow(color: AppColors.primary.withOpacity(0.5), blurRadius: 30, spreadRadius: 5)
                            ],
                          ),
                          child: const Icon(Icons.bolt_rounded, size: 60, color: Colors.white),
                        ).animate().shimmer(delay: 500.ms, duration: 2.seconds),
                        
                        const SizedBox(height: 32),
                        const Text(
                          'Unleash Your\nProductivity IQ',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white, height: 1.1),
                        ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),
                        
                        const SizedBox(height: 48),
                        
                        _buildFeatureRow(Icons.analytics_outlined, 'Advanced Analytics', 'Deep dive into your behavioral completion patterns.'),
                        _buildFeatureRow(Icons.psychology_outlined, 'AI Smart Reminders', 'Intelligent alerts optimized for your peak focus hours.'),
                        _buildFeatureRow(Icons.all_inclusive_rounded, 'Unlimited Flow', 'Create infinite tasks and focus sessions without limits.'),
                        
                        const SizedBox(height: 60),
                        
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(color: AppColors.primary.withOpacity(0.5), width: 2),
                          ),
                          child: Column(
                            children: [
                              const Text('MONTHLY PASS', style: TextStyle(color: AppColors.primaryLight, fontWeight: FontWeight.bold, fontSize: 12, letterSpacing: 2)),
                              const SizedBox(height: 8),
                              const Text('\$4.99 / month', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white)),
                              const SizedBox(height: 4),
                              const Text('7-day free trial included', style: TextStyle(color: AppColors.textMuted, fontSize: 12)),
                            ],
                          ),
                        ).animate().fadeIn(delay: 600.ms).scale(begin: const Offset(0.9, 0.9)),
                        
                        const SizedBox(height: 32),
                        
                        ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            foregroundColor: Colors.white,
                            minimumSize: const Size(double.infinity, 64),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                            elevation: 0,
                          ),
                          child: const Text('START FREE TRIAL', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1)),
                        ).animate().fadeIn(delay: 800.ms).slideY(begin: 0.5, end: 0),
                        
                        const SizedBox(height: 24),
                        const Text('Restore Purchases', style: TextStyle(color: AppColors.textMuted, fontSize: 13, decoration: TextDecoration.underline)),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureRow(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
            child: Icon(icon, color: AppColors.primaryLight, size: 24),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
                const SizedBox(height: 4),
                Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: 400.ms).slideX(begin: 0.1, end: 0);
  }
}
