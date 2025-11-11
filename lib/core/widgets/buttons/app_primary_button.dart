import 'package:flutter/material.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../theme/color_palette.dart';
import '../../utils/is_dark_mode.dart';

class AppPrimaryButton extends StatelessWidget {
  final Function()? onPressed;
  final Widget? child;
  final bool isDisabled;
  final PrimaryButtonColor color;
  final Color? backgroundColor;
  final bool isLoading;
  final double width;
  final bool showBorder;

  final String title;
  final Color titleColor;
  final TextStyle? style;
  final double fontSize;
  final FontWeight fontWeight;

  const AppPrimaryButton({
    super.key,
    required this.onPressed,
    this.child,
    this.isDisabled = false,
    this.isLoading = false,
    this.color = PrimaryButtonColor.primary,
    this.backgroundColor,
    this.width = double.infinity,
    this.showBorder = true,

    this.title = '',
    this.titleColor = Colors.white,
    this.style,
    this.fontSize = 16,
    this.fontWeight = FontWeight.w500,
  });

  @override
  Widget build(BuildContext context,) {
    final bool isDark = isDarkMode();

    return ElevatedButton(
      onPressed: (isDisabled || isLoading) ? null : onPressed,
      style: ButtonStyle(
        minimumSize: WidgetStatePropertyAll(Size(width, 48)),
        padding: WidgetStateProperty.all(
          const EdgeInsets.symmetric(vertical: 13, horizontal: 16),
        ),
        backgroundColor: backgroundColor != null
            ? WidgetStatePropertyAll(isDark ? Colors.black : backgroundColor)
            : color == PrimaryButtonColor.primary
            ? primaryButtonBackground(context, isDark)
            : errorButtonBackground(context),
        shape: backgroundColor == null
            ? null
            : WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: showBorder
                  ? ColorPalette.primary50
                  : Colors.transparent,
            ),
          ),
        ),
      ),
      child: isLoading
          ? const SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      )
          : child ?? Text(
        title,
        style:
        style ??
            context.bodyMedium?.copyWith(
              fontSize: fontSize.sp,
              fontWeight: fontWeight,
              color:  titleColor ,
            ),
      ),
    );
  }
    WidgetStateProperty<Color> primaryButtonBackground(BuildContext context, bool isDark) =>
        WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return context.theme.colorScheme.onSurface.withValues(alpha: 0.12);
          } else if (states.contains(WidgetState.hovered)) {
            return context.colorScheme.primary;
          } else if (states.contains(WidgetState.pressed)) {
            return isDark ? Colors.black : context.colorScheme.primary;
          } else {
            return isDark ? Colors.black : context.colorScheme.primary;
          }
        });

    WidgetStateProperty<Color> errorButtonBackground(BuildContext context) =>
        WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.disabled)) {
            return context.theme.colorScheme.onSurface.withValues(alpha: 0.12);
          } else if (states.contains(WidgetState.hovered)) {
            return ColorPalette.error50;
          } else if (states.contains(WidgetState.pressed)) {
            return ColorPalette.error30;
          } else {
            return ColorPalette.error40;
          }
        });
  }


enum PrimaryButtonColor { primary, error }
