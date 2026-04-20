import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('About FlowTask', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          final version = snapshot.data?.version ?? '1.0.0';
          final buildNumber = snapshot.data?.buildNumber ?? '1';

          return SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const SizedBox(height: 40),
                Center(
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: const Icon(Icons.bolt_rounded, size: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'FlowTask',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -1),
                ),
                Text(
                  'Version $version ($buildNumber)',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 14),
                ),
                const SizedBox(height: 48),
                _buildInfoCard(
                  'Founder Alpha Status',
                  'FlowTask is currently in Early Access. Founders receive exclusive access to all premium intelligence features during this launch phase.',
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  'Mission',
                  'To transform daily chaos into focused progress through high-fidelity task management and cognitive behavioral analytics.',
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  'Legal & Compliance',
                  'FlowTask prioritizes User Data Sovereignty. Our infrastructure is secured via Google Firebase and complies with 2024 global Data Safety mandates.',
                ),
                const SizedBox(height: 16),
                _buildTransparencyCard(),
                const SizedBox(height: 32),
                
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTextLink('Privacy', () => _launchURL('https://flowtask-smart-todo-app.vercel.app/privacy')),
                    const SizedBox(width: 12),
                    const Text('|', style: TextStyle(color: Colors.white10)),
                    const SizedBox(width: 12),
                    _buildTextLink('Data Safety', () => _launchURL('https://flowtask-smart-todo-app.vercel.app/data-safety')),
                    const SizedBox(width: 12),
                    const Text('|', style: TextStyle(color: Colors.white10)),
                    const SizedBox(width: 12),
                    _buildTextLink('Disclaimer', () => _launchURL('https://flowtask-smart-todo-app.vercel.app/disclaimer')),
                    const SizedBox(width: 12),
                    const Text('|', style: TextStyle(color: Colors.white10)),
                    const SizedBox(width: 12),
                    _buildTextLink('Terms', () => _launchURL('https://flowtask-smart-todo-app.vercel.app/terms')),
                  ],
                ),
                const SizedBox(height: 48),
                const Text(
                  '© 2026 FlowTask — Built with Purpose.',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Widget _buildTextLink(String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Text(
        label,
        style: TextStyle(color: AppColors.primaryLight, fontSize: 12, fontWeight: FontWeight.bold, decoration: TextDecoration.underline),
      ),
    );
  }

  Widget _buildTransparencyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.secondary.withOpacity(0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.verified_user_outlined, color: AppColors.secondary, size: 16),
              const SizedBox(width: 8),
              Text(
                'Infrastructure Transparency'.toUpperCase(),
                style: TextStyle(color: AppColors.secondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _TransparencyItem(label: 'Encryption', value: 'AES-256 / TLS 1.3'),
          const _TransparencyItem(label: 'Storage', value: 'Google Firestore (Multi-Region)'),
          const _TransparencyItem(label: 'Identity', value: 'Firebase Auth (Identity Platform)'),
          const _TransparencyItem(label: 'Data Deletion', value: 'Instant Shard Purge Supported'),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.03),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: TextStyle(color: AppColors.primaryLight, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: TextStyle(color: AppColors.textSecondary, height: 1.5, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _TransparencyItem extends StatelessWidget {
  final String label;
  final String value;
  const _TransparencyItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: TextStyle(color: AppColors.textMuted, fontSize: 11)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

