import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/presentation/account_page/provider/theme_provider.dart';

import '../../../gen/assets.gen.dart';
import 'navigation_card.dart';

class CustomBottomNavBar extends ConsumerWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const CustomBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeModeProvider);
    final isDarkMode = themeMode == ThemeMode.dark;
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: isDarkMode ? Colors.black54 : Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildNavItem(0, localize(context).home, Assets.icons.home, isDarkMode),
          _buildNavItem(1, localize(context).wallet, Assets.icons.wallet, isDarkMode),
          _buildNavItem(2, localize(context).ride_history, Assets.icons.wallet, isDarkMode),
          _buildNavItem(3, localize(context).account, Assets.icons.account, isDarkMode),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, AssetGenImage iconAsset, bool isDark) => InkWell(
      onTap: () => onTap(index),
      child: NavBarItem(
        icon: iconAsset.image(height: 24, width: 24, fit: BoxFit.fill),
        label: label,
        selected: index == currentIndex, isDark: isDark,
      ),
    );
}
