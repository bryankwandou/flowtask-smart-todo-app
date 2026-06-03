import 'package:flowtask/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../services/auth_service.dart';

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
              'Your task history and focus patterns are isolated to your local identity. Data is encrypted and managed exclusively on your device for maximum privacy.',
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
                  'Data Storage Agreement',
                  'Terms of your local secure storage.',
                  Icons.description_outlined,
                  () => _showDPASheet(context),
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
          color: isDestructive ? AppColors.error.withValues(alpha: 0.1) : AppColors.primary.withValues(alpha: 0.1),
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
              'FlowTask utilizes a local-first architecture with on-device AES-256 encryption. Your task history and productivity analytics are stored only on your physical device. No data is transmitted to external servers. You can wipe all data at any time via the button below.',
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

  void _showDPASheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.surface,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(32))),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.4,
        expand: false,
        builder: (context, scrollController) => SingleChildScrollView(
          controller: scrollController,
          padding: const EdgeInsets.all(32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(child: Icon(Icons.description_outlined, color: AppColors.primary, size: 48)),
              const SizedBox(height: 16),
              const Center(
                child: Text('Local Data Agreement', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
              ),
              const SizedBox(height: 24),
              const Text(
                'By using FlowTask, you agree to our local data handling policy.',
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              const Text(
                '1. Infrastructure: All data is stored locally in an encrypted SQLite database on your device.\n\n2. Security: We leverage industry-standard local encryption to ensure your tasks are protected at rest.\n\n3. Deletion: You have absolute control. When you wipe data or uninstall the app, everything is permanently removed from your device.\n\n4. Analytics: All productivity insights are calculated on-device and never leave your hardware.',
                style: TextStyle(color: AppColors.textSecondary, height: 1.6),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  minimumSize: const Size(double.infinity, 56),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: const Text('I Understand'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context) {
    final passwordController = TextEditingController();
    bool isLoading = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          backgroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          title: const Text('Confirm Identity Deletion', style: TextStyle(color: Colors.white)),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'This action is permanent. All your tasks, productivity analytics, and profile data will be purged. Please enter your password to confirm.',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 13),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: passwordController,
                obscureText: true,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  hintText: 'Password',
                  hintStyle: TextStyle(color: Colors.white.withValues(alpha: 0.3)),
                  filled: true,
                  fillColor: Colors.white.withValues(alpha: 0.05),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: isLoading ? null : () => Navigator.pop(context), 
              child: const Text('Cancel')
            ),
            ElevatedButton(
              onPressed: isLoading ? null : () async {
                if (passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password required for deletion'))
                  );
                  return;
                }

                setState(() => isLoading = true);
                try {
                  await AuthService.deleteAccount(passwordController.text);
                  if (context.mounted) {
                    Navigator.pop(context); // Close dialog
                    context.go('/login');
                  }
                } catch (e) {
                  setState(() => isLoading = false);
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Failed to delete: ${e.toString()}'))
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              child: isLoading 
                ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                : const Text('WIPE DATA', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}


