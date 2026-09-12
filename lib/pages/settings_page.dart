import 'package:flutter/material.dart';
import 'package:liquid_glass_widgets/liquid_glass_widgets.dart';

/// Settings page — vehicle preferences and profile.
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Profile Card ──
          _buildProfileCard(),
          const SizedBox(height: 16),

          // ── Vehicle Settings ──
          _buildSectionHeader('Vehicle'),
          _buildSettingsTile(
            icon: Icons.lock,
            title: 'Auto Lock',
            subtitle: 'Lock doors when driving',
            trailing: GlassSwitch(
              value: true,
              onChanged: (_) {},
            ),
          ),
          _buildSettingsTile(
            icon: Icons.light_mode,
            title: 'Headlights',
            subtitle: 'Automatic on/off',
            trailing: GlassSwitch(
              value: true,
              onChanged: (_) {},
            ),
          ),
          _buildSettingsTile(
            icon: Icons.notifications,
            title: 'Notifications',
            subtitle: 'Vehicle alerts',
            trailing: GlassSwitch(
              value: false,
              onChanged: (_) {},
            ),
          ),
          const SizedBox(height: 16),

          // ── Climate Settings ──
          _buildSectionHeader('Climate'),
          _buildSettingsTile(
            icon: Icons.ac_unit,
            title: 'Pre-condition',
            subtitle: 'Start climate before driving',
            trailing: GlassSwitch(
              value: true,
              onChanged: (_) {},
            ),
          ),
          _buildSettingsTile(
            icon: Icons.thermostat,
            title: 'Temperature Unit',
            subtitle: 'Fahrenheit',
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.white54,
            ),
          ),
          const SizedBox(height: 16),

          // ── About ──
          _buildSectionHeader('About'),
          _buildSettingsTile(
            icon: Icons.info_outline,
            title: 'Vehicle Info',
            subtitle: 'Model 3 · 2024',
            trailing: const Icon(
              Icons.chevron_right,
              color: Colors.white54,
            ),
          ),
          _buildSettingsTile(
            icon: Icons.update,
            title: 'Software Update',
            subtitle: 'Up to date',
            trailing: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Text(
                'Current',
                style: TextStyle(
                  color: Colors.green,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildProfileCard() {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          // Avatar
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.blue.shade400,
                  Colors.purple.shade400,
                ],
              ),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Text(
                'JD',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          // Name & email
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'John Doe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'john.doe@email.com',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          // Edit
          const Icon(
            Icons.edit,
            color: Colors.white54,
            size: 20,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          color: Colors.white.withValues(alpha: 0.4),
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _buildSettingsTile({
    required IconData icon,
    required String title,
    required String subtitle,
    required Widget trailing,
  }) {
    return GlassCard(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          Icon(
            icon,
            color: Colors.white70,
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.5),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}
