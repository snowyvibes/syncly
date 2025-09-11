import 'package:flutter/material.dart';
import 'package:syncly/core/widgets/list_tile.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Support & Bug Reports'),
    ),
    body: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Need Help?',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          _buildSupportOption(
            icon: Icons.bug_report,
            title: 'Report a Bug',
            subtitle: 'Found an issue? Let us know!',
            onTap: () => _reportBug(),
          ),
          _buildSupportOption(
            icon: Icons.help_outline,
            title: 'Get Support',
            subtitle: 'Contact our support team',
            onTap: () => _contactSupport(),
          ),
          _buildSupportOption(
            icon: Icons.feedback,
            title: 'Send Feedback',
            subtitle: 'Share your thoughts and suggestions',
            onTap: () => _sendFeedback(),
          ),
          _buildSupportOption(
            icon: Icons.description,
            title: 'Documentation',
            subtitle: 'Browse our help articles',
            onTap: () => _openDocumentation(),
          ),
          const Spacer(),
          const Center(
            child: Text(
              'Version 0.0.1',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildSupportOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) => Card(
    child: CustomListTile(
      leading: Icon(icon, size: 32),
      title: title,
      subtitle: subtitle,
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    ),
  );

  Future<void> _reportBug() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@syncly.com',
      query: 'subject=Bug Report&body=Please describe the bug you encountered:',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _contactSupport() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'support@syncly.com',
      query: 'subject=Support Request',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _sendFeedback() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'feedback@syncly.com',
      query: 'subject=App Feedback',
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  Future<void> _openDocumentation() async {
    final Uri url = Uri.parse('https://syncly.com/help');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }
}
