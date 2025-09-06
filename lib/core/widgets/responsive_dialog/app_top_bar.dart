import 'package:flutter/material.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';

import '../buttons/app_back_button.dart';

class AppTopBar extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget? trailing;

  const AppTopBar({
    super.key,
    required this.title,
    this.subtitle,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const AppBackButton(),
            if (trailing != null) ...[
              const Spacer(),
              trailing!,
            ],
          ],
        ),
        const SizedBox(height: 16),
        Text(
          title,
          style: context.headlineSmall,
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: context.bodyLarge,
          ),
        ]
      ],
    );
}
