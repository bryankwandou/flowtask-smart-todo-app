import 'package:flutter/material.dart';
import '../../core/theme/colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile & Settings', style: TextStyle(fontWeight: FontWeight.bold)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Center(
            child: CircleAvatar(
              radius: 50,
              backgroundColor: AppColors.primary,
              child: Text('NB', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text('Nayr Bryan', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
          const Center(
            child: Text('nayr@example.com', style: TextStyle(color: AppColors.textSecondary)),
          ),
          const SizedBox(height: 32),
          // Subscription Status
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(colors: [AppColors.secondary, Color(0xFF047857)]),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text('Flow Intelligence Pro', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
                    SizedBox(height: 4),
                    Text('Active Lifetime Plan', style: TextStyle(color: Colors.white70)),
                  ],
                ),
                const Icon(Icons.workspace_premium, color: Colors.white, size: 32),
              ],
            ),
          ),
          const SizedBox(height: 32),
          _buildSettingsTile(Icons.dark_mode, 'Theme Preferences', 'System Default'),
          _buildSettingsTile(Icons.timer, 'Focus Timer Settings', '25m Work / 5m Break'),
          _buildSettingsTile(Icons.notifications_active, 'Smart Reminders', 'Enabled'),
          const Divider(height: 40, color: Colors.white10),
          _buildSettingsTile(Icons.privacy_tip, 'Privacy Policy', null),
          _buildSettingsTile(Icons.description, 'Terms of Service', null),
          const SizedBox(height: 24),
          TextButton(
            onPressed: () {},
            child: const Text('Log Out', style: TextStyle(color: AppColors.error, fontSize: 16)),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingsTile(IconData icon, String title, String? subtitle) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: AppColors.textSecondary),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      subtitle: subtitle != null ? Text(subtitle, style: const TextStyle(color: AppColors.textSecondary, fontSize: 12)) : null,
      trailing: const Icon(Icons.chevron_right, color: AppColors.textSecondary),
      onTap: () {},
    );
  }
}
