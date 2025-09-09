import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:syncly/core/utils/constants.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/features/settings/presentation/widgets/setting_tile.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSizes.padding),
          child: Text(
            'Settings',
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.surface),
          ),
        ),
        Expanded(
          child: Material(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(AppSizes.borderRadius),
              topRight: Radius.circular(AppSizes.borderRadius),
            ),
            clipBehavior: Clip.antiAlias,
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const ProfileBar(),

                    // APPEARANCE SECTION
                    const SectionHeader(title: 'Appearance'),
                    const SettingTile(
                      text: 'Theme',
                      subtitle: 'Light, Dark, System',
                      icon: Icons.palette_outlined,
                    ),
                    const SettingTile(
                      text: 'Language',
                      subtitle: 'English',
                      icon: Icons.language,
                    ),
                    const SettingTile(
                      text: 'Default View',
                      subtitle: 'Tasks, Notes, Calendar',
                      icon: Icons.view_list,
                    ),

                    // DATA & SYNC SECTION
                    const SectionHeader(title: 'Data & Sync'),
                    const SettingTile(
                      text: 'Backup',
                      subtitle: 'Manage backup settings',
                      icon: FontAwesomeIcons.copy,
                    ),
                    const SettingTile(
                      text: 'Sync Settings',
                      subtitle: 'Auto-sync every 15 minutes',
                      icon: Icons.sync,
                    ),
                    const SettingTile(
                      text: 'Storage',
                      subtitle: 'Manage local data',
                      icon: Icons.storage,
                    ),

                    // NOTIFICATIONS SECTION
                    const SectionHeader(title: 'Notifications'),
                    const SettingTile(
                      text: 'Notifications',
                      subtitle: 'Manage notification settings',
                      icon: Icons.notifications,
                    ),
                    const SettingTile(
                      text: 'Reminders',
                      subtitle: 'Task and event alerts',
                      icon: Icons.alarm,
                    ),
                    const SettingTile(
                      text: 'Sounds & Haptics',
                      subtitle: 'Customize sounds and vibrations',
                      icon: Icons.vibration,
                    ),

                    // PRIVACY & SECURITY SECTION
                    const SectionHeader(title: 'Privacy & Security'),
                    const SettingTile(
                      text: 'Security',
                      subtitle: 'Biometric lock, PIN',
                      icon: Icons.security,
                    ),
                    const SettingTile(
                      text: 'Privacy',
                      subtitle: 'Data usage and permissions',
                      icon: Icons.privacy_tip,
                    ),

                    // SUPPORT & INFO SECTION
                    const SectionHeader(title: 'Support & Info'),
                    const SettingTile(
                      text: 'Help & Support',
                      subtitle: 'Report a bug',
                      icon: Icons.help_outline,
                    ),
                    const SettingTile(
                      text: 'About',
                      subtitle: 'Version, licenses, credits',
                      icon: Icons.info_outline,
                    ),

                    // ACCOUNT SECTION
                    const SectionHeader(title: 'Account'),
                    SettingTile(
                      text: 'Sign Out',
                      subtitle: 'Logout of your account',
                      icon: Icons.logout,
                      onTap: () {
                        context.go('/login');
                      },
                    ),

                    const SizedBox(height: 32), // Bottom padding
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

class SectionHeader extends StatelessWidget {
  final String title;

  const SectionHeader({super.key, required this.title});

  @override
  Widget build(BuildContext context) => Container(
    width: double.infinity,
    padding: const EdgeInsets.symmetric(
      horizontal: AppSizes.padding,
      vertical: AppSizes.padding / 2,
    ),
    child: Text(
      title,
      style: Theme.of(context).textTheme.titleSmall?.copyWith(
        color: Theme.of(context).colorScheme.primary,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    ),
  );
}

class ProfileBar extends StatelessWidget {
  const ProfileBar({super.key});

  @override
  Widget build(BuildContext context) => const Card(
    elevation: 3,
    child: Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
          ),
          kSizedBoxHorizontal,
          Text('John Doe'),
        ],
      ),
    ),
  );
}
