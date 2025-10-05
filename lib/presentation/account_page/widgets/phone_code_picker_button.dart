import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/config/localization/country_data.dart';
import '../../../data/services/navigation_service.dart';
import '../provider/select_country_provider.dart';

Widget buildPhoneCodePickerButton() => Consumer(
    builder: (context, ref, _) {
      final phoneCode = ref.watch(selectedPhoneCodeProvider);
      final currentCountry = allowedLanguages.firstWhere(
        (lang) => lang['phone_code']!.contains(phoneCode),
        orElse: () => allowedLanguages.first,
      );

      return GestureDetector(
        onTap: () => _showPhoneCodeBottomSheet(context, ref),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Row(
            children: [
              Text(currentCountry['flag'] ?? '', style: TextStyle(fontSize: 16.sp)),
              SizedBox(width: 6.w),
              Flexible(
                child: Text(
                  currentCountry['phone_code'] ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );

void _showPhoneCodeBottomSheet(BuildContext context, WidgetRef ref) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
    ),
    builder: (context) => ListView.separated(
      shrinkWrap: true,
      padding: EdgeInsets.all(16.r),
      itemCount: allowedLanguages.length,
      separatorBuilder: (_, _) => SizedBox(height: 12.h),
      itemBuilder: (context, index) {
        final lang = allowedLanguages[index];
        final phoneCode = lang['phone_code'] ?? '';

        return ListTile(
          leading: Text(lang['flag']!, style: const TextStyle(fontSize: 24)),
          title: Text("${lang["name"]} ($phoneCode)"),
          onTap: () async {
            await ref
                .read(selectedPhoneCodeProvider.notifier)
                .changePhoneCode(phoneCode);

            if (context.mounted) {
              NavigationService.pop();
            }
          },
        );
      },
    ),
  );
}
