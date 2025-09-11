import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Privacy Policy'),
    ),
    body: SingleChildScrollView(
      padding: const EdgeInsets.all(AppSizes.padding),
      child: Column(
        spacing: AppSizes.columnSpacing,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Privacy Policy',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: AppSizes.size8),
          const Text(
            'Last updated: Sep 11, 2025',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),

          const _SectionWidget(
            title: 'Our Privacy Commitment',
            content:
                'Syncly is built with privacy as our core principle. We believe your personal data belongs to you, and we are committed to protecting it with the highest standards of security and transparency.',
          ),

          const _SectionWidget(
            title: 'Data Collection',
            content:
                'We collect only the minimum data necessary to provide our services:\n\n• Account information (email, username)\n• Device information for security purposes\n\nWe never collect sensitive personal information without explicit consent.',
          ),

          const _SectionWidget(
            title: 'Data Usage',
            content:
                'Your data is used exclusively to:\n\n• Ensure account security\n• Send important service updates\n\nWe never sell, rent, or share your personal data with third parties for marketing purposes.',
          ),

          const _SectionWidget(
            title: 'Data Storage & Security',
            content:
                'All data is encrypted both in transit and at rest using industry-standard encryption protocols. We employ zero-knowledge architecture where possible, meaning we cannot access your private content even if we wanted to.',
          ),

          const _SectionWidget(
            title: 'Your Rights',
            content:
                'You have the right to:\n\n• Access your personal data\n• Correct inaccurate information\n• Delete your account and all associated data\n• Export your data in a portable format\n• Opt-out of non-essential data processing',
          ),

          const _SectionWidget(
            title: 'Data Retention',
            content:
                'We retain your data only as long as necessary to provide our services or as required by law. When you delete your account, we permanently remove all your personal data immediately.',
          ),

          const _SectionWidget(
            title: 'Contact Us',
            content:
                'If you have any questions about this Privacy Policy or your data, please contact us at klyra.dev@gmail.com.',
          ),

          const SizedBox(height: 32),
        ],
      ),
    ),
  );
}

class _SectionWidget extends StatelessWidget {
  final String title;
  final String content;

  const _SectionWidget({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(bottom: AppSizes.padding),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    ),
  );
}
