import 'package:flowtask/core/theme/colors.dart';
import 'package:flowtask/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../services/auth_service.dart';

class _OnboardingPageData {

  const _OnboardingPageData({
    required this.tag,
    required this.title,
    required this.subtitle,
    required this.accentColor,
    required this.gradientColors,
  });
  final String tag;
  final String title;
  final String subtitle;
  final Color accentColor;
  final List<Color> gradientColors;
}

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

  List<_OnboardingPageData> _getPages(AppLocalizations l10n) {
    return [
      _OnboardingPageData(
        tag: l10n.onboarding1Tag,
        title: l10n.onboarding1Title,
        subtitle: l10n.onboarding1Sub,
        accentColor: AppColors.primary,
        gradientColors: const [Color(0xFF6366F1), Color(0xFF4338CA)],
      ),
      _OnboardingPageData(
        tag: l10n.onboarding2Tag,
        title: l10n.onboarding2Title,
        subtitle: l10n.onboarding2Sub,
        accentColor: const Color(0xFF8B5CF6),
        gradientColors: const [Color(0xFF8B5CF6), Color(0xFF6D28D9)],
      ),
      _OnboardingPageData(
        tag: l10n.onboarding3Tag,
        title: l10n.onboarding3Title,
        subtitle: l10n.onboarding3Sub,
        accentColor: AppColors.secondary,
        gradientColors: const [Color(0xFF10B981), Color(0xFF059669)],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final pages = _getPages(l10n);
    final isLast = _currentIndex == pages.length - 1;

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
                        pages[_currentIndex].accentColor.withValues(alpha: 0.12),
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
                        child: Text(l10n.skip, style: const TextStyle(fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ),
                ),

                // Page content
                Expanded(
                  child: PageView.builder(
                    controller: _controller,
                    itemCount: pages.length,
                    onPageChanged: (index) {
                      HapticFeedback.lightImpact();
                      setState(() => _currentIndex = index);
                    },
                    itemBuilder: (context, index) =>
                        _OnboardingPageWidget(page: pages[index]),
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
                        count: pages.length,
                        effect: ExpandingDotsEffect(
                          activeDotColor: pages[_currentIndex].accentColor,
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
                            colors: pages[_currentIndex].gradientColors,
                          ),
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: pages[_currentIndex].accentColor
                                  .withValues(alpha: 0.4),
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
                                        ? l10n.getStarted
                                        : l10n.continueBtn,
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
    HapticFeedback.lightImpact();
    await AuthService.markOnboardingDone();
    if (context.mounted) {
      context.go('/permission-priming');
    }
  }

}

class _OnboardingPageWidget extends StatelessWidget {
  const _OnboardingPageWidget({required this.page});
  final _OnboardingPageData page;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 280,
            child: Icon(
              page.tag.contains('TASK') || page.tag.contains('TUGAS') ? Icons.task_alt_rounded :
              page.tag.contains('FOCUS') || page.tag.contains('FOKUS') ? Icons.timer_outlined : Icons.insights_rounded,
              size: 160,
              color: page.accentColor.withValues(alpha: 0.8),
            )
            .animate(onPlay: (controller) => controller.repeat(reverse: true))
            .scale(duration: 2.seconds, begin: const Offset(0.9, 0.9), end: const Offset(1.1, 1.1), curve: Curves.easeInOutQuad)
            .rotate(begin: -0.05, end: 0.05)
            .shimmer(duration: 3.seconds, color: Colors.white24),
          ).animate().fadeIn(),

          const SizedBox(height: 48),

          // Tag
          Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: page.accentColor.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: page.accentColor.withValues(alpha: 0.3),
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
