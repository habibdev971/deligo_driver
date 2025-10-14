import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deligo_driver/common/shimmer_loader.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/core/utils/is_arabic.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';

import '../../../core/enums/driver_status.dart';
import '../../../core/utils/localize.dart';
import '../../booking/provider/driver_providers.dart';

// Constants for reusability
class SwitchConstants {
  static const double width = 200;
  static const double height = 44;
  static const double borderRadius = 22;
  static const double padding = 3;
  static const double fontSize = 12;
  static const Duration animationDuration = Duration(milliseconds: 250);
  static const Color borderColor = Color(0xFFEDEBFC);
  static const double borderWidth = 1;
  static const double gap = 0; // Remove gap for perfect alignment
}

// Data model for switch states
class SwitchState {
  final bool isLoading;
  final bool isOnline;

  const SwitchState({
    required this.isLoading,
    required this.isOnline,
  });
}

// Extracted widget for switch text item
class SwitchTextItem extends StatelessWidget {
  final String text;
  final bool isActive;
  final bool isDarkMode;

  const SwitchTextItem({
    super.key,
    required this.text,
    required this.isActive,
    required this.isDarkMode,
  });

  @override
  Widget build(BuildContext context) => Expanded(
      child: Container(
        height: SwitchConstants.height - (SwitchConstants.padding * 2),
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        alignment: Alignment.center,
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.center,
          style: context.bodyMedium?.copyWith(
            color: _getTextColor(),
            fontWeight: FontWeight.w600,
            fontSize: SwitchConstants.fontSize.sp,
            height: 1.0, // Consistent line height
          ),
        ),
      ),
    );

  Color _getTextColor() {
    if (isActive) {
      return isDarkMode ? Colors.white : isArabic() ? ColorPalette.primary50 : Colors.white;
    }
    return isDarkMode ? Colors.white : Colors.black;
  }
}

// Extracted animated background widget
class AnimatedSwitchBackground extends StatelessWidget {
  final bool isOnline;

  const AnimatedSwitchBackground({
    super.key,
    required this.isOnline,
  });

  @override
  Widget build(BuildContext context) => AnimatedAlign(
      alignment: !isOnline ? Alignment.centerLeft : Alignment.centerRight,
      duration: SwitchConstants.animationDuration,
      curve: Curves.easeInOutCubic,
      child: Container(
        width: (SwitchConstants.width - (SwitchConstants.padding * 2)) / 2,
        height: SwitchConstants.height - (SwitchConstants.padding * 2),

        decoration: BoxDecoration(
          color: ColorPalette.primary50,
          borderRadius: BorderRadius.circular(SwitchConstants.borderRadius - SwitchConstants.padding),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      ),
    );
}

// Main switch widget with extracted logic
class OnlineOfflineSwitch extends ConsumerWidget {
  const OnlineOfflineSwitch({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) => ValueListenableBuilder<bool>(
      valueListenable: isOnlineNotifier,
      builder: (context, isOnline, _) {
        final switchState = _getSwitchState(ref);

        return GestureDetector(
          onTap: () => _handleTap(ref, isOnline),
          child: _buildSwitchContainer(context, switchState),
        );
      },
    );

  SwitchState _getSwitchState(WidgetRef ref) {
    final status = ref.watch(driverStatusNotifierProvider);

    final bool isLoading = status.whenOrNull(loading: () => true) ?? false;
    final bool isOnlineFromState = status.whenOrNull(
      online: () => true,
      orderRequest: (d) => true,
    ) ?? false;

    return SwitchState(
      isLoading: isLoading,
      isOnline: isOnlineFromState,
    );
  }

  void _handleTap(WidgetRef ref, bool isOnline) {
    ref.read(driverStatusNotifierProvider.notifier)
        .updateOnlineStatus(!isOnline);
  }

  Widget _buildSwitchContainer(BuildContext context, SwitchState switchState) => Container(
      width: SwitchConstants.width.w,
      height: SwitchConstants.height.h,
      padding: EdgeInsets.all(SwitchConstants.padding.r),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(SwitchConstants.borderRadius.r),
        border: Border.all(
          color: SwitchConstants.borderColor,
          width: SwitchConstants.borderWidth.w,
        ),
      ),
      child: switchState.isLoading
          ? _buildLoadingState()
          : _buildActiveState(context, switchState),
    );

  Widget _buildLoadingState() => buildShimmer(
      height: SwitchConstants.height,
      width: SwitchConstants.width,
      borderRadius: BorderRadius.circular(SwitchConstants.borderRadius),
    );

  Widget _buildActiveState(BuildContext context, SwitchState switchState) {
    final isDark = isDarkMode();

    return Stack(
      children: [
        AnimatedSwitchBackground(isOnline: switchState.isOnline),
        Row(
          children: [
            SwitchTextItem(
              text: localize(context).offline,
              isActive: !switchState.isOnline,
              isDarkMode: isDark,
            ),
            SwitchTextItem(
              text: localize(context).lets_ride,
              isActive: switchState.isOnline,
              isDarkMode: isDark,
            ),
          ],
        ),
      ],
    );
  }
}

// Factory function for backward compatibility
Widget onlineOfflineSwitch(BuildContext context) => const OnlineOfflineSwitch();

final ValueNotifier<bool> isOnlineNotifier = ValueNotifier<bool>(false);