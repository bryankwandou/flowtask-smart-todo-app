import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authRepository = ref.watch(authRepositoryProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account Settings', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        children: [
          // User Profile Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: Colors.white10),
            ),
            child: Column(
              children: const [
                CircleAvatar(
                  radius: 40,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.person, size: 40, color: Colors.white),
                ),
                SizedBox(height: 16),
                Text('Productivity Pro', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text('premium@flowtask.com', style: TextStyle(color: AppColors.textSecondary)),
              ],
            ),
          ),
          const SizedBox(height: 32),

          _buildSectionHeader('General'),
          _buildActionTile(Icons.notifications_active_outlined, 'Notifications', 'Manage alerts & reminders'),
          _buildActionTile(Icons.workspace_premium_outlined, 'Flow Intelligence Pro', 'Manage your subscription'),
          
          const SizedBox(height: 24),
          _buildSectionHeader('Support & Legal'),
          _buildActionTile(Icons.privacy_tip_outlined, 'Privacy Policy', 'Read our data handling rules'),
          _buildActionTile(Icons.description_outlined, 'Terms of Service', 'Application usage terms'),
          
          const SizedBox(height: 48),
          
          // Sign Out Button
          ElevatedButton.icon(
            onPressed: () => authRepository.signOut(),
            icon: const Icon(Icons.logout),
            label: const Text('Sign Out'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.surface,
              foregroundColor: AppColors.textPrimary,
              side: const BorderSide(color: Colors.white10),
            ),
          ),
          
          const SizedBox(height: 16),

          /// HARD REQUIREMENT FOR GOOGLE PLAY 2024+
          /// Account deletion must be prominent and easy to find for apps with login.
          TextButton.icon(
            onPressed: () => _confirmAccountDeletion(context, ref),
            icon: const Icon(Icons.delete_forever_outlined),
            label: const Text('Delete Account'),
            style: TextButton.styleFrom(
              foregroundColor: AppColors.error,
              padding: const EdgeInsets.symmetric(vertical: 12),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Deleting your account will permanently remove all your tasks, stats, and profile data from our servers.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textMuted, fontSize: 12),
          ),
        ],
      ),
    );
  }

  void _confirmAccountDeletion(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: const Text('Delete Account?', style: TextStyle(color: AppColors.error)),
        content: const Text(
          'This action is irreversible. All your data including 100% of your tasks and productivity analytics will be permanently destroyed.',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: AppColors.textSecondary)),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              // Show a loading snackbar or dialog here
              try {
                await ref.read(authRepositoryProvider).deleteAccount();
                // Success - the auth redirect will handle it
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error during deletion: \$e'), backgroundColor: AppColors.error),
                  );
                }
              }
            },
            child: const Text('Yes, Delete Everything', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 12),
      child: Text(
        title.toUpperCase(),
        style: const TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 1.2),
      ),
    );
  }

  Widget _buildActionTile(IconData icon, String title, String subtitle) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(12)),
        child: Icon(icon, color: AppColors.primaryLight, size: 20),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      trailing: const Icon(Icons.chevron_right, size: 20, color: AppColors.textMuted),
      onTap: () {},
    );
  }
}
