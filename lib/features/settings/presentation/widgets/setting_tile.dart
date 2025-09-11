import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({super.key, required this.text, this.subtitle, this.onTap, required this.icon});

  final String text;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => Card(
    elevation: AppSizes.elevation,
    child: ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: AppSizes.iconSize,
        color: Theme.of(context).colorScheme.primary,
      ),
      title: Text(text),
      subtitle: subtitle != null ? Text(subtitle!) : null,
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 10,
      ),
    ),
  );
}
