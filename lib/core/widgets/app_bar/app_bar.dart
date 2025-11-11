import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/app_colors.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'back_button.dart';

AppBar mainAppBar(
    BuildContext context, {
      String? title,
      void Function()? onPressed,
      PreferredSizeWidget? bottom,
      bool hideLeading = false
    }) => AppBar(
    leadingWidth: hideLeading ? null : 100,
    backgroundColor: isDarkMode() ? Colors.black : Colors.white,
    bottom: bottom,
    leading: hideLeading ? null : Semantics(
      label:
      '${AppLocalizations.of(context).back} ${AppLocalizations.of(context).button}',
      child: backButton(context, onPressed: onPressed),
    ),
    centerTitle: true,
    title: title != null
        ? Text(
      title,
      style: context.bodyMedium?.copyWith(
        fontSize: 18.sp,
        fontWeight: FontWeight.w500,
        color: isDarkMode() ? Colors.white : AppColors.contentPrimary,
      ),
    )
        : null,
  );
