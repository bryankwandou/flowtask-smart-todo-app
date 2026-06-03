import 'package:flowtask/core/theme/colors.dart';
import 'package:flutter/material.dart';
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
                          color: AppColors.primary.withValues(alpha: 0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: const Icon(Icons.check_circle_rounded, size: 50, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  'FlowTask',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.w900, color: Colors.white, letterSpacing: -1),
                ),
                Text(
                  'Version $version ($buildNumber)',
                  style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
                ),
                const SizedBox(height: 48),
                _buildInfoCard(
                  'Platinum Production Status',
                  'FlowTask is now in Stable Production. This Platinum build includes the full suite of cognitive intelligence features and localized focus optimizations.',
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  'Mission',
                  'To transform daily chaos into focused progress through high-fidelity task management and cognitive behavioral analytics.',
                ),
                const SizedBox(height: 16),
                _buildInfoCard(
                  'Privacy & Sovereignty',
                  'FlowTask is built on a Zero-Cloud architecture. Your data is encrypted and stored exclusively on this device. We do not collect, share, or sell any user information.',
                ),
                const SizedBox(height: 16),
                _buildTransparencyCard(),
                const SizedBox(height: 48),
                const Text(
                  '© 2026 FlowTask — Built for Focus.',
                  style: TextStyle(color: AppColors.textMuted, fontSize: 12, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        },
      ),
    );
  }



  Widget _buildTransparencyCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.secondary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.25)),
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
                style: const TextStyle(color: AppColors.secondary, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const _TransparencyItem(label: 'Encryption', value: 'AES-256 (On-Device)'),
          const _TransparencyItem(label: 'Storage', value: 'Offline-First Persistence'),
          const _TransparencyItem(label: 'Identity', value: 'Local Secure Identity'),
          const _TransparencyItem(label: 'Data Deletion', value: 'Irreversible Local Purge'),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title.toUpperCase(),
            style: const TextStyle(color: AppColors.primaryLight, fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5),
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(color: AppColors.textSecondary, height: 1.5, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _TransparencyItem extends StatelessWidget {
  const _TransparencyItem({required this.label, required this.value});
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textMuted, fontSize: 11)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}


