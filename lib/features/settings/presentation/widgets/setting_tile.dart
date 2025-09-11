import 'package:flutter/material.dart';
import 'package:syncly/core/utils/sizes.dart';
import 'package:syncly/core/widgets/card.dart';
import 'package:syncly/core/widgets/list_tile.dart';

class SettingTile extends StatelessWidget {
  const SettingTile({
    super.key,
    required this.text,
    this.subtitle,
    this.onTap,
    required this.icon,
    this.iconColor,
  });

  final String text;
  final String? subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) => CustomCard(
    margin: const EdgeInsets.symmetric(
      horizontal: AppSizes.padding,
      vertical: AppSizes.padding / 2,
    ),
    elevation: AppSizes.elevation,
    child: CustomListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        size: AppSizes.iconSize,
        color: iconColor ?? Theme.of(context).colorScheme.primary,
      ),
      title: text,
      subtitle: subtitle,
      trailing: const Icon(Icons.arrow_forward_ios, size: 10),
    ),
  );
}
