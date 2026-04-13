import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';
import '../../../core/theme/colors.dart';
import '../../../services/auth_service.dart';

class _OnboardingPage {
  final String tag;
  final String title;
  final String subtitle;
  final String lottieUrl;
  final Color accentColor;
  final List<Color> gradientColors;

  const _OnboardingPage({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.lottieUrl,
    required this.accentColor,
    required this.gradientColors,
  });
}

const _pages = [
  _OnboardingPage(
    tag: 'TASK INTELLIGENCE',
    title: 'Tame the Chaos',
    subtitle: 'Organize every task in a minimalist space engineered for clarity. No clutter, just progress.',
    lottieUrl: 'https://assets5.lottiefiles.com/private_files/lf30_8np772as.json', // Chaos/Loading
    accentColor: AppColors.primary,
    gradientColors: [Color(0xFF6366F1), Color(0xFF4338CA)],
  ),
  _OnboardingPage(
    tag: 'DEEP FOCUS ENGINE',
    title: 'Find Your Flow',
    subtitle: 'Launch precision Pomodoro sessions tied to any task. Eliminate distractions. Enter the zone.',
    lottieUrl: 'https://assets10.lottiefiles.com/packages/lf20_96b9lbay.json', // Rocket/Focus
    accentColor: Color(0xFF8B5CF6),
    gradientColors: [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
  ),
  _OnboardingPage(
    tag: 'PRODUCTIVITY IQ',
    title: 'Unlock Your Insights',
    subtitle: 'Discover your peak performance hours, track streaks, and decode how you work best—automatically.',
    lottieUrl: 'https://assets10.lottiefiles.com/packages/lf20_qpwb6as6.json', // Charts/Growth
    accentColor: AppColors.secondary,
    gradientColors: [Color(0xFF10B981), Color(0xFF059669)],
  ),
];

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLast = _currentIndex == _pages.length - 1;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // Animated background orb
          Positioned.fill(
              child: IgnorePointer(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 600),
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                      center: const Alignment(0, -0.3),
                      radius: 0.8,
                      colors: [
                        _pages[_currentIndex].accentColor.withOpacity(0.12),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),

          SafeArea(
            child: Column(
              children: [
                // Skip button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 16, top: 8),
                    child: TextButtonTheme(
                      data: TextButtonThemeData(style: TextButton.styleFrom(foregroundColor: AppColors.textSecondary)),
                      child: TextButton(
                        onPressed: () => _finishOnboarding(context),
                        child: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),

                // Page content
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: _pages.length,
                    onPageChanged: (index) =>
                        setState(() => _currentIndex = index),
                    itemBuilder: (context, index) =>
                        _OnboardingPageWidget(page: _pages[index]),
                  ),
                ),

                // Bottom navigation
                Padding(
                  padding: const EdgeInsets.fromLTRB(32, 0, 32, 40),
                  child: Column(
                    children: [
                      // Page indicator
                      SmoothPageIndicator(
                        controller: _controller,
                        count: _pages.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: _pages[_currentIndex].accentColor,
                          dotColor: AppColors.surface,
                          dotHeight: 8,
                          dotWidth: 8,
                          expansionFactor: 3,
                        ),
                      ),
                      const SizedBox(height: 32),

                      // CTA Button
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        width: double.infinity,
                        height: 60,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: _pages[_currentIndex].gradientColors,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: _pages[_currentIndex].accentColor
                                  .withOpacity(0.4),
                              blurRadius: 20,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: () {
                              if (isLast) {
                                HapticFeedback.mediumImpact();
                                _finishOnboarding(context);
                              } else {
                                HapticFeedback.lightImpact();
                                _controller.nextPage(
                                  duration:
                                      const Duration(milliseconds: 500),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            borderRadius: BorderRadius.circular(20),
                            child: Center(
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    isLast
                                        ? 'Get Started Free'
                                        : 'Continue',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.3,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Icon(
                                    isLast
                                        ? Icons.rocket_launch_rounded
                                        : Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _finishOnboarding(BuildContext context) async {
    await AuthService.markOnboardingDone();
    if (mounted) {
      context.go('/permission-priming');
    }
  }

}

class _OnboardingPageWidget extends StatelessWidget {
  final _OnboardingPage page;
  const _OnboardingPageWidget({required this.page});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Lottie Hero
          SizedBox(
            height: 280,
            child: Lottie.network(
              page.lottieUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: page.accentColor.withOpacity(0.1),
                ),
                child: Icon(Icons.auto_awesome_rounded, size: 80, color: page.accentColor),
              ),
            ),
          ).animate().scale(duration: 600.ms, curve: Curves.easeOutCubic).fadeIn(),

          const SizedBox(height: 48),

          // Tag
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: page.accentColor.withOpacity(0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: page.accentColor.withOpacity(0.3),
              ),
            ),
            child: Text(
              page.tag,
              style: TextStyle(
                color: page.accentColor,
                fontSize: 10,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ).animate().fadeIn(delay: 200.ms),

          const SizedBox(height: 16),

          Text(
            page.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.w900,
              color: AppColors.textPrimary,
              letterSpacing: -1.5,
              height: 1.1,
            ),
          ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2, end: 0),

          const SizedBox(height: 20),

          Text(
            page.subtitle,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.65,
            ),
          ).animate().fadeIn(delay: 450.ms),
        ],
      ),
    );
  }
}

