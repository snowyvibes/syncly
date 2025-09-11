import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  const CustomListTile({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.trailing,
    this.onTap,
    this.subtitleColor,
    this.padding,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final Widget? trailing;
  final GestureTapCallback? onTap;
  final Color? subtitleColor;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) => ListTile(
    onTap: onTap,
    title: Text(title, style: Theme.of(context).textTheme.titleSmall),
    subtitle: subtitle != null
        ? Text(
            subtitle!,
            style: Theme.of(
              context,
            ).textTheme.bodySmall!.copyWith(color: subtitleColor),
          )
        : null,
    leading: leading,
    trailing: trailing,
    contentPadding: padding,
  );
}
