import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/app_colors.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

import '../../../core/config/localization/country_data.dart';
import '../provider/selected_language_provider.dart';

Widget buildLanguagePickerButton() => Consumer(
    builder: (context, ref, _) {
      final languageState = ref.watch(selectedLanguageProvider);

      final currentLang = allowedLanguages.firstWhere(
            (lang) => lang['code'] == languageState.languageCode,
        orElse: () => allowedLanguages.first,
      );

      return GestureDetector(
        onTap: () => _showLanguageBottomSheet(context),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: IntrinsicWidth(
            child: Row(
              children: [
                Text(
                  currentLang['flag']!,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    color: AppColors.primary,
                  ),
                ),
                Gap(6.w),
                Flexible(
                  child: Text(
                    currentLang['name']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: context.bodySmall?.copyWith(color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );

void _showLanguageBottomSheet(
    BuildContext context, {
      void Function(String newCode)? onChanged,
    }) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) => Consumer(
      builder: (context, ref, _) {
        final languageNotifier = ref.read(selectedLanguageProvider.notifier);
        return SafeArea(
          child: ListView.separated(
            shrinkWrap: true,
            padding: EdgeInsets.all(16.r),
            itemCount: allowedLanguages.length,
            separatorBuilder: (_, _) => Gap(12.h),
            itemBuilder: (context, index) {
              final lang = allowedLanguages[index];
              return ListTile(
                leading: Text(
                  lang['flag']!,
                  style: const TextStyle(fontSize: 24),
                ),
                title: Text(lang['name']!),
                onTap: () async {
                  final newCode = lang['code']!;
          
                  languageNotifier.changeLanguage(newCode);
          
                  onChanged != null
                      ? onChanged(newCode)
                      : context.mounted
                      ? NavigationService.pop()
                      : null;
                },
              );
            },
          ),
        );
      },
    ),
  );
}


