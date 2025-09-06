import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';

import '../../../core/theme/color_palette.dart';

class NavBarItem extends StatelessWidget {
  final Widget icon;
  final String label;
  final bool selected;
  final EdgeInsets? margin;
  final bool isDark;

  const NavBarItem({
    required this.icon,
    required this.label,
    required this.selected,
    super.key, this.margin,
    required this.isDark
  });

  @override
  Widget build(BuildContext context) {
    final iconColor = selected ? Colors.white : Colors.grey;
    final textColor = selected ? Colors.white : const Color(0xFF565F73);
    final double iconSize = selected ? 24 : 19;

    final iconWidget = ColorFiltered(
      colorFilter: ColorFilter.mode(
        iconColor,
        BlendMode.srcIn,
      ),
      child: SizedBox(
        height: iconSize,
        width: iconSize,
        child: icon,
      ),
    );

    final labelWidget = Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: GoogleFonts.inter(fontSize: 12.sp, fontWeight: FontWeight.w500, color: textColor),
    );
    return Container(
      constraints: const BoxConstraints(maxWidth: 80, maxHeight: 56),
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: selected ? ColorPalette.primary50 : isDark ? context.surface : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isDark && !selected ? Border.all(color: Colors.white, width: 1.w) : null,
      ),

      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          iconWidget,
          const SizedBox(height: 4, width: double.infinity,),
          labelWidget,
        ],
      ),
    );
  }
}
