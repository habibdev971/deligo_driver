import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';

import '../theme/color_palette.dart';

class AppMenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onPressed;

  const AppMenuItem({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) => CupertinoButton(
      padding: const EdgeInsets.all(0),
      onPressed: onPressed, minimumSize: const Size(0, 0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: ColorPalette.neutralVariant99,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: ColorPalette.neutral90,
              ),
            ),
            child: Icon(
              icon,
              color: ColorPalette.primary30,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.labelLarge,
                ),
                if (subtitle != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    subtitle!,
                    style: context.labelLarge,
                  ),
                ]
              ],
            ),
          ),
          if (onPressed != null) ...[
            const SizedBox(width: 4),
            const Icon(
              Ionicons.chevron_forward,
              color: ColorPalette.neutral70,
              size: 16,
            ),
          ]
        ],
      ),
    );
}
