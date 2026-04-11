import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../core/theme/colors.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => isLastPage = index == 2);
            },
            children: [
              _buildPage(
                title: 'Tame the Chaos',
                subtitle: 'Organize your daily tasks in a minimalist environment designed for deep work.',
                icon: Icons.auto_awesome_rounded,
                color: AppColors.primary,
              ),
              _buildPage(
                title: 'Find Your Flow',
                subtitle: 'Built-in Pomodoro timers help you maintain focus and eliminate distractions.',
                icon: Icons.timer_rounded,
                color: AppColors.secondary,
              ),
              _buildPage(
                title: 'Unlock Insights',
                subtitle: 'Analyze your working patterns to discover your most productive hours.',
                icon: Icons.insights_rounded,
                color: AppColors.primaryLight,
              ),
            ],
          ),
          
          // Navigation
          Container(
            alignment: const Alignment(0, 0.85),
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Skip
                TextButton(
                  onPressed: () => _finishOnboarding(context),
                  child: const Text('SKIP', style: TextStyle(color: AppColors.textSecondary, fontWeight: FontWeight.bold)),
                ),
                
                // Indicators
                SmoothPageIndicator(
                  controller: _controller,
                  count: 3,
                  effect: ExpandingDotsEffect(
                    activeDotColor: AppColors.primary,
                    dotColor: AppColors.surface,
                    dotHeight: 8,
                    dotWidth: 8,
                  ),
                ),
                
                // Next / Start
                isLastPage 
                  ? ElevatedButton(
                      onPressed: () => _finishOnboarding(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        minimumSize: const Size(100, 48),
                      ),
                      child: const Text('START', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
                    )
                  : IconButton(
                      onPressed: () => _controller.nextPage(
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.easeInOut,
                      ),
                      icon: const Icon(Icons.arrow_forward_rounded, color: AppColors.primary),
                    ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage({required String title, required String subtitle, required IconData icon, required Color color}) {
    return Padding(
      padding: const EdgeInsets.all(40.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 120, color: color)
            .animate()
            .fade(duration: 800.ms)
            .slideY(begin: 0.2, end: 0, curve: Curves.easeOutQuart)
            .scale(begin: const Offset(0.8, 0.8)),
          const SizedBox(height: 64),
          Text(
            title,
            style: const TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.extrabold,
              color: AppColors.textPrimary,
              letterSpacing: -1,
            ),
          ).animate().fadeIn(delay: 300.ms),
          const SizedBox(height: 24),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.6,
            ),
          ).animate().fadeIn(delay: 500.ms),
        ],
      ),
    );
  }

  void _finishOnboarding(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('onboarding_done', true);
    if (context.mounted) {
      context.go('/');
    }
  }
}
