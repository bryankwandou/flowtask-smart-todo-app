import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../core/theme/colors.dart';
import '../../../core/providers/settings_provider.dart';

class NotificationSettingsScreen extends ConsumerWidget {
  const NotificationSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notification Intelligence', style: TextStyle(fontWeight: FontWeight.w900, letterSpacing: -0.5)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Stay Synchronized',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
            ).animate().fadeIn(),
            const SizedBox(height: 12),
            const Text(
              'Manage your cognitive alerts and focus triggers. We optimize these to protect your flow state.',
              style: TextStyle(color: AppColors.textSecondary, height: 1.5, fontSize: 15),
            ).animate().fadeIn(delay: 200.ms),
            
            const SizedBox(height: 48),
            
            _buildSection(
              'Core Alerts',
              [
                _buildSwitchTile(
                   'System Notifications',
                   'Enable overall task and focus reminders.',
                   Icons.notifications_active_outlined,
                   settings.notificationsEnabled,
                   (val) => ref.read(settingsProvider.notifier).setNotifications(val),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            _buildSection(
              'Intelligence Features',
              [
                _buildSwitchTile(
                   'Daily Strategy Briefing',
                   'Receive a smart summary of your goals every morning.',
                   Icons.wb_sunny_outlined,
                   true, // Default on, can be moved to settings later
                   (val) {},
                   isPremium: true,
                ),
                const Divider(color: Colors.white10, height: 1, indent: 64),
                _buildSwitchTile(
                   'Peak Hour Focus Reminder',
                   'Automated trigger when your Productivity IQ is highest.',
                   Icons.insights_rounded,
                   true,
                   (val) {},
                   isPremium: true,
                ),
              ],
            ),
            
            const SizedBox(height: 48),
            
            if (!settings.isPremium)
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: AppColors.primaryGradient,
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.bolt_rounded, color: Colors.amber, size: 32),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Unlock IQ Notifications', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                          const SizedBox(height: 4),
                          const Text('Get morning briefings and peak hour insights with Pro.', style: TextStyle(color: Colors.white70, fontSize: 12)),
                        ],
                      ),
                    ),
                  ],
                ),
              ).animate().shimmer(duration: 2.seconds).fadeIn(delay: 600.ms),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(color: AppColors.primaryLight, fontSize: 11, fontWeight: FontWeight.w900, letterSpacing: 2),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface.withOpacity(0.5),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(children: children),
        ),
      ],
    ).animate().fadeIn(delay: 400.ms);
  }

  Widget _buildSwitchTile(String title, String sub, IconData icon, bool value, ValueChanged<bool> onChanged, {bool isPremium = false}) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      leading: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: isPremium ? Colors.amber : AppColors.primaryLight, size: 24),
      ),
      title: Row(
        children: [
          Text(title, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16)),
          if (isPremium) ...[
            const SizedBox(width: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.amber.withOpacity(0.2), borderRadius: BorderRadius.circular(4)),
              child: const Text('PRO', style: TextStyle(color: Colors.amber, fontSize: 8, fontWeight: FontWeight.bold)),
            ),
          ],
        ],
      ),
      subtitle: Text(sub, style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
      trailing: Switch.adaptive(
        value: value,
        onChanged: onChanged,
        activeColor: AppColors.primaryLight,
      ),
    );
  }
}
