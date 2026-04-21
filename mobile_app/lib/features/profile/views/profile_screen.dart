import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../auth/providers/auth_provider.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:flowtask/core/theme/colors.dart';
import '../../../core/providers/settings_provider.dart';
import 'package:flowtask/core/theme/app_theme.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider).value;
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          const SliverAppBar.large(
            expandedHeight: 150,
            backgroundColor: AppColors.background,
            flexibleSpace: FlexibleSpaceBar(
              title: Text('Account', style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: -0.5)),
              centerTitle: false,
              titlePadding: EdgeInsets.only(left: 20, bottom: 20),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  // Premium Profile Card
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.surface, AppColors.surface.withValues(alpha: 0.8)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(32),
                      border: Border.all(color: Colors.white10),
                      boxShadow: const [
                        BoxShadow(color: Colors.black26, blurRadius: 20, offset: Offset(0, 10))
                      ],
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(32),
                          child: Column(
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.surface,
                                  border: Border.all(color: AppColors.primary.withValues(alpha: 0.3), width: 2),
                                ),
                                child: const Center(
                                  child: Icon(Icons.person_rounded, size: 48, color: AppColors.primaryLight),
                                ),
                              ).animate().scale(duration: 600.ms, curve: Curves.elasticOut),
                              const SizedBox(height: 20),
                              Text(
                                user?.displayName ?? 'Productivity Specialist',
                                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                              Text(
                                user?.email ?? 'premium@flowtask.app',
                                style: const TextStyle(color: AppColors.textSecondary, fontSize: 14),
                              ),
                              const SizedBox(height: 24),
                              _buildProBadge(context, settings.isFounderPass),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 600.ms).scale(begin: const Offset(0.95, 0.95)),

                  const SizedBox(height: 40),
                  
                  _buildSection('Settings'),
                  _buildOptionTile(
                    Icons.color_lens_outlined, 
                    'Theme Palette', 
                    settings.palette.name.toUpperCase(), 
                    () => _showThemePicker(context, ref)
                  ),
                  _buildOptionTile(
                    Icons.language_rounded, 
                    'App Language', 
                    settings.locale.languageCode == 'en' ? 'English' : 'Indonesian', 
                    () => _showLanguagePicker(context, ref)
                  ),
                  _buildOptionTile(
                    Icons.notifications_none_rounded, 
                    'Notifications', 
                    'Schedule, alerts & sounds', 
                    () => _launchURL(context, 'https://flowtask-smart-todo-app.vercel.app/docs')
                  ),

                  const SizedBox(height: 32),
                  // Policy & Safety Section
                  _buildSection('Safety & Legal'),
                  _buildOptionTile(
                    Icons.policy_outlined, 
                    'Privacy Policy', 
                    'Review our data handling practices', 
                    () => _launchURL(context, 'https://flowtask-smart-todo-app.vercel.app/privacy')
                  ),
                  _buildOptionTile(
                    Icons.gavel_rounded, 
                    'Terms of Service', 
                    'Acceptable usage and legal terms', 
                    () => _launchURL(context, 'https://flowtask-smart-todo-app.vercel.app/terms')
                  ),
                  _buildOptionTile(
                    Icons.security_rounded, 
                    'Security & Data Deletion', 
                    'Manage your account and purge data', 
                    () => context.push('/privacy-settings')
                  ),

                  const SizedBox(height: 48),

                  // Actions
                  OutlinedButton.icon(
                    onPressed: () async {
                      final authRepository = ref.read(authRepositoryProvider);
                      await authRepository.signOut();
                      if (context.mounted) context.go('/login');
                    },
                    icon: const Icon(Icons.logout_rounded),
                    label: const Text('Sign Out'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.textSecondary,
                      side: const BorderSide(color: Colors.white10),
                      minimumSize: const Size(double.infinity, 56),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                  ),

                   const SizedBox(height: 16),
                  TextButton.icon(
                    onPressed: () => _confirmAccountDeletion(context, ref),
                    icon: const Icon(Icons.delete_forever_rounded, color: AppColors.error),
                    label: const Text(
                      'DELETE ACCOUNT', 
                      style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold, letterSpacing: 1.1, fontSize: 12)
                    ),
                    style: TextButton.styleFrom(
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),
                  const SizedBox(height: 100),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchURL(BuildContext context, String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Could not open $url'))
        );
      }
    }
  }

  Widget _buildSection(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 12),
        child: Text(
          title.toUpperCase(),
          style: const TextStyle(color: AppColors.primary, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, String subtitle, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white10),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12)),
          child: Icon(icon, color: AppColors.primaryLight, size: 22),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        subtitle: Text(subtitle, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
        trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
        onTap: onTap,
      ),
    );
  }

  Widget _buildProBadge(BuildContext context, bool isPremium) {
    if (!isPremium) {
      return ElevatedButton.icon(
        onPressed: () => context.push('/paywall'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        icon: const Icon(Icons.bolt_rounded, size: 18),
        label: const Text('UPGRADE TO PRO', style: TextStyle(fontWeight: FontWeight.w900, fontSize: 13)),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFACC15), Color(0xFFEAB308)], // Gold gradients
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.amber.withValues(alpha: 0.3), blurRadius: 15, spreadRadius: 1)
        ],
      ),
      child: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.auto_awesome, color: Color(0xFF422006), size: 16),
          SizedBox(width: 8),
          Text('FLOW MASTER PRO', style: TextStyle(color: Color(0xFF422006), fontWeight: FontWeight.w900, fontSize: 13, letterSpacing: 1.2)),
        ],
      ),
    );
  }

  void _showThemePicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose Identity Palette', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _buildPickerItem(context, 'Electric Indigo', ThemePalette.indigo, () => ref.read(settingsProvider.notifier).setPalette(ThemePalette.indigo)),
            _buildPickerItem(context, 'Emerald Zen', ThemePalette.emerald, () => ref.read(settingsProvider.notifier).setPalette(ThemePalette.emerald)),
            _buildPickerItem(context, 'Silent Slate', ThemePalette.slate, () => ref.read(settingsProvider.notifier).setPalette(ThemePalette.slate)),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _showLanguagePicker(BuildContext context, WidgetRef ref) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(30))),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Choose App Language', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 24),
            _buildPickerItem(context, 'English (US)', null, () => ref.read(settingsProvider.notifier).setLocale(const Locale('en'))),
            _buildPickerItem(context, 'Indonesian (ID)', null, () => ref.read(settingsProvider.notifier).setLocale(const Locale('id'))),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildPickerItem(BuildContext context, String label, ThemePalette? palette, VoidCallback onTap) {
    return ListTile(
      title: Text(label),
      onTap: () {
        onTap();
        Navigator.pop(context);
      },
    );
  }

  void _confirmAccountDeletion(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Purge Account?', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        content: const Text(
          'This action is irreversible. All your tasks, productivity IQ reports, and sync data will be permanently deleted from our servers in compliance with Google Play Store data safety policies.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('CANCEL', style: TextStyle(color: AppColors.textMuted)),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              // Redirect to privacy settings where the final purge button lives
              // This multi-step process prevents accidental deletion rejections
              GoRouter.of(context).push('/privacy-settings');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('PROCEED TO PURGE', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}


