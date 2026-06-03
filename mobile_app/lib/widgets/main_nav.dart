import 'package:flowtask/core/theme/colors.dart';
import 'package:flowtask/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../features/analytics/views/analytics_screen.dart';
import '../features/profile/views/profile_screen.dart';
import '../features/tasks/views/home_screen.dart';

class MainNavWrapper extends StatefulWidget {
  const MainNavWrapper({super.key});

  @override
  State<MainNavWrapper> createState() => _MainNavWrapperState();
}

class _MainNavWrapperState extends State<MainNavWrapper> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const AnalyticsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Colors.white10, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            if (_currentIndex != index) {
              HapticFeedback.selectionClick();
              setState(() => _currentIndex = index);
            }
          },
          backgroundColor: AppColors.background,
          selectedItemColor: AppColors.primary,
          unselectedItemColor: AppColors.textSecondary,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          elevation: 0,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.check_box_outlined),
              activeIcon: const Icon(Icons.check_box),
              label: l10n.homeTitle,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.bar_chart_outlined),
              activeIcon: const Icon(Icons.bar_chart),
              label: l10n.analyticsTitle,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person_outline),
              activeIcon: const Icon(Icons.person),
              label: l10n.profileTitle,
            ),
          ],
        ),
      ),
    );
  }
}
