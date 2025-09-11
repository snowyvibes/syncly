import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/list_tile.dart';
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
                    // APPEARANCE SECTION
                    // const SectionHeader(title: 'Appearance'),
                    // const SettingTile(
                    //   text: 'Theme',
                    //   subtitle: 'Light, Dark, System',
                    //   icon: Icons.palette_outlined,
                    // ),
                    // const SettingTile(
                    //   text: 'Language',
                    //   subtitle: 'English',
                    //   icon: Icons.language,
                    // ),
                    // const SettingTile(
                    //   text: 'Default View',
                    //   subtitle: 'Tasks, Notes, Calendar',
                    //   icon: Icons.view_list,
                    // ),
                    const SizedBox(height: AppSizes.size8),

                    // DATA & SYNC SECTION
                    const SectionHeader(title: 'Data & Sync'),
                    SettingTile(
                      text: 'Backup',
                      subtitle: 'Manage backup settings',
                      icon: FontAwesomeIcons.copy,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(AppSizes.padding),
                            height: 500,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Backup',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                const SizedBox(height: AppSizes.size16),
                                Text(
                                  'Cloud Backups',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: AppSizes.size8),
                                CustomListTile(
                                  leading: const Icon(Icons.backup),
                                  title: 'Sync to Cloud',
                                  subtitle: 'Sync your data to the cloud',
                                  trailing: Switch(
                                    value: true,
                                    onChanged: (val) {},
                                  ),
                                  onTap: () {},
                                ),
                                const SizedBox(height: AppSizes.size16),
                                Text(
                                  'Local Backups',
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: AppSizes.size8),
                                CustomListTile(
                                  leading: const Icon(Icons.backup),
                                  title: 'Create Backup',
                                  subtitle: 'Create a local backup of your data',
                                  onTap: () {},
                                ),
                                CustomListTile(
                                  leading: const Icon(Icons.restore),
                                  title: 'Restore Backup',
                                  subtitle: 'Restore data from a previous local backup',
                                  onTap: () {},
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    // NOTIFICATIONS SECTION
                    const SectionHeader(title: 'Notifications'),
                    SettingTile(
                      text: 'Notifications',
                      subtitle: 'Manage notification settings',
                      icon: Icons.notifications,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(AppSizes.padding),
                            height: 300,
                            child: Column(
                              spacing: AppSizes.columnSpacing,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Notifications',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                CustomListTile(
                                  leading: const Icon(Icons.notifications_active),
                                  title: 'Enable Notifications',
                                  subtitle: 'Turn on to receive notifications',
                                  trailing: Switch(
                                    value: true,
                                    onChanged: (val) {},
                                  ),
                                ),

                                CustomListTile(
                                  leading: const Icon(Icons.event),
                                  title: 'Event Notifications',
                                  subtitle: 'Notifications for calendar events',
                                  trailing: Switch(
                                    value: false,
                                    onChanged: (val) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    SettingTile(
                      text: 'Sounds & Haptics',
                      subtitle: 'Customize sounds and vibrations',
                      icon: Icons.vibration,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => Container(
                            padding: const EdgeInsets.all(AppSizes.padding),
                            height: 300,
                            child: Column(
                              spacing: AppSizes.columnSpacing,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sounds & Haptics',
                                  style: Theme.of(context).textTheme.headlineSmall,
                                ),
                                CustomListTile(
                                  leading: const Icon(Icons.volume_up),
                                  title: 'Sound Effects',
                                  subtitle: 'Play sounds for interactions',
                                  trailing: Switch(
                                    value: true,
                                    onChanged: (val) {},
                                  ),
                                ),
                                CustomListTile(
                                  leading: const Icon(Icons.vibration),
                                  title: 'Haptic Feedback',
                                  subtitle: 'Feel vibrations for interactions',
                                  trailing: Switch(
                                    value: false,
                                    onChanged: (val) {},
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),

                    // PRIVACY & SECURITY SECTION
                    const SectionHeader(title: 'Privacy & Security'),
                    // const SettingTile(
                    //   text: 'Security',
                    //   subtitle: 'Biometric lock, PIN',
                    //   icon: Icons.security,
                    // ),
                    SettingTile(
                      text: 'Privacy',
                      subtitle: 'Data usage and permissions',
                      icon: Icons.privacy_tip,
                      onTap: () {
                        context.push('/privacy');
                      },
                    ),

                    // SUPPORT & INFO SECTION
                    const SectionHeader(
                      title: 'Support & Info',
                    ),
                    SettingTile(
                      text: 'Help & Support',
                      subtitle: 'Report a bug',
                      icon: Icons.help_outline,
                      onTap: () {
                        context.push('/support');
                      },
                    ),
                    SettingTile(
                      text: 'About',
                      subtitle: 'Version, licenses, credits',
                      icon: Icons.info_outline,
                      onTap: () {
                        showAboutDialog(
                          context: context,
                          applicationName: 'Syncly',
                          applicationVersion: '0.0.1',

                          children: [
                            const SizedBox(height: AppSizes.size12),
                            Text(
                              'Syncly is a productivity app that helps you manage your tasks and notes efficiently and privately. Privacy is our top priority, and we do not collect any personal data.',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],

                          applicationLegalese: '© 2025 Syncly Inc. All rights reserved.',
                        );
                      },
                    ),

                    // ACCOUNT SECTION
                    const SectionHeader(title: 'Account'),
                    SettingTile(
                      text: 'Delete Account',
                      subtitle: 'Delete your account and all your data',
                      iconColor: Colors.redAccent,
                      icon: Icons.delete,
                      onTap: () {
                        // Show confirmation dialog before deleting account
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Delete Account'),
                            content: const Text(
                              'Are you sure you want to delete your account? This action cannot be undone.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Cancel'),
                              ),
                              TextButton(
                                onPressed: () {
                                  // Perform account deletion logic here
                                  Navigator.pop(context); // Close the dialog
                                  context.go('/login'); // Navigate to login page
                                },
                                child: const Text(
                                  'Delete',
                                  style: TextStyle(color: Colors.redAccent),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
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
