import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/colors.dart';
import '../../../services/auth_service.dart';
import 'package:go_router/go_router.dart';

class PrivacySettingsScreen extends StatelessWidget {
  const PrivacySettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Privacy & Security', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Your Productivity Data',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
            ).animate().fadeIn(),
            const SizedBox(height: 8),
            const Text(
              'We isolate your task history and focus patterns to your local identity. Data is encrypted and managed via Google Firebase infrastructure.',
              style: TextStyle(color: AppColors.textSecondary, height: 1.5),
            ).animate().fadeIn(delay: 200.ms),
            
            const SizedBox(height: 32),
            
            _buildSection(
              'Data Control',
              [
                _buildActionTile(
                  'Data Sovereignty Info',
                  'Understand how your flow data is stored.',
                  Icons.info_outline_rounded,
                  () => _showDataInfoSheet(context),
                ),
              ],
            ),
            
            const SizedBox(height: 32),
            
            _buildSection(
              'Account Transparency',
              [
                _buildActionTile(
                  'Privacy Policy',
                  'View our commitment to your data safety.',
                  Icons.policy_outlined,
                  () => _launchURL('https://flowtask-smart-todo-app.vercel.app/privacy'),
                ),
                _buildActionTile(
                  'Delete Account',
                  'Irreversibly wipe all tasks and analytics.',
                  Icons.delete_forever_outlined,
                  () => _showDeleteConfirmation(context),
                  isDestructive: true,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title.toUpperCase(),
          style: const TextStyle(color: AppColors.primaryLight, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
        ),
        const SizedBox(height: 16),
        Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: Colors.white10),
          ),
          child: Column(children: children),
        ),
      ],
    ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.1, end: 0);
  }

  Widget _buildActionTile(String title, String sub, IconData icon, VoidCallback onTap, {bool isDestructive = false}) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: isDestructive ? AppColors.error.withOpacity(0.1) : AppColors.primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(icon, color: isDestructive ? AppColors.error : AppColors.primaryLight, size: 22),
      ),
      title: Text(title, style: TextStyle(color: isDestructive ? AppColors.error : Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      subtitle: Text(sub, style: const TextStyle(color: AppColors.textMuted, fontSize: 13)),
      trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.textMuted),
    );
  }

  void _showDataInfoSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => Container(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.security_rounded, color: AppColors.secondary, size: 64),
            const SizedBox(height: 16),
            const Text('Your Data Sovereignty', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
            const SizedBox(height: 16),
            const Text(
              'FlowTask utilizes Google Firebase with end-to-end encryption. Your task history and productivity analytics are linked only to your secure account identity. You can request a manual data export by contacting support@flowtask.app or via the Settings menu in our web portal.',
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.textSecondary, height: 1.5),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                minimumSize: const Size(double.infinity, 56),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              ),
              child: const Text('Understand'),
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.surface,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        title: const Text('Delete Your Identity?', style: TextStyle(color: Colors.white)),
        content: const Text(
          'This action is irreversible. All your flow patterns, session history, and intelligence reports will be permanently purged from our secure servers. In compliance with Play Store policy, you can also delete your account via our web portal.',
          style: TextStyle(color: AppColors.textSecondary),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          TextButton(
            onPressed: () async {
              await AuthService.deleteAccount();
              if (context.mounted) {
                context.go('/login');
              }
            },
            child: const Text('WIPE DATA', style: TextStyle(color: AppColors.error, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

