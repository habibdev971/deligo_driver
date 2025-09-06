import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/common/error_view.dart';
import 'package:deligo_driver/common/loading_view.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/data/models/report_response/report_type_response.dart';

import '../provider/report_provider.dart';

Widget reportTypeDropdown(
  BuildContext context, {
  Function(String v)? onChange,
}) => Consumer(
  builder: (context, ref, _) {
    final selectedState = ref.watch(selectReportTypeProvider);
    final selectedStateNotifier = ref.watch(selectReportTypeProvider.notifier);
    final state = ref.watch(reportTypesNotifierProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localize(context).reportType,
          textAlign: TextAlign.start,
          style: context.bodyMedium?.copyWith(
            fontSize: 18.sp,
            fontWeight: FontWeight.w600,
            color: isDarkMode() ? const Color(0xFF687387) : const Color(0xFF24262D),
          ),
        ),
        Gap(12.h),
        state.when(
          initial: () => const SizedBox.shrink(),
          loading: () => const LoadingView(),
          success: (list) => DropdownButtonFormField<ReportTypes>(
            value: selectedState,
            isExpanded: true,
            icon: Icon(
              Icons.keyboard_arrow_down_outlined,
              color: isDarkMode() ? Colors.white : Colors.black,
              size: 18.h,
            ),
            dropdownColor: context.surface,
            hint: Text(
              localize(context).selectReportType,
              style: context.bodyMedium?.copyWith(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF687387),
              ),
            ),
            items: list
                .map(
                  (e) => DropdownMenuItem<ReportTypes>(
                    value: e,
                    child: Text(
                      e.reportType ?? '',
                      style: context.bodyMedium?.copyWith(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: isDarkMode() ? Colors.white : const Color(0xFF687387),
                      ),
                    ),
                  ),
                )
                .toList(),
            onChanged: (v) {
              if (v != null) {
                selectedStateNotifier.setReportType(v);
              }
            },
          ),
          error: (e) => ErrorView(message: e.message),
        ),
      ],
    );
  },
);
