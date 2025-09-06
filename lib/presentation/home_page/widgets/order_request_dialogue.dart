import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/common/loading_view.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/show_global_dialogue.dart';
import 'package:deligo_driver/presentation/home_page/widgets/rider_details.dart';
import 'package:deligo_driver/presentation/home_page/widgets/location_time_calculated.dart';
import 'package:deligo_driver/presentation/home_page/widgets/order_request_buttons.dart';
import 'package:deligo_driver/presentation/home_page/widgets/readable_location_view.dart';
import 'package:deligo_driver/presentation/home_page/widgets/ride_preference.dart';

import '../../booking/provider/ride_providers.dart';

void orderRequestDialogue() {
  showGlobalAlertDialog(
    child: const _OrderRequestDialog(),
  );
}

class _OrderRequestDialog extends ConsumerWidget {
  const _OrderRequestDialog();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rideOrderNotifierProvider);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r), side: isDarkMode() ? const BorderSide(color: Colors.white) : BorderSide.none),
      insetPadding: EdgeInsets.all(16.r),
      child: IntrinsicHeight(
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: state.when(
              loading: ()=> const LoadingView(), success: (order)=> Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween, // even spacing
            children: [
              riderDetails(context, order?.rider, amount: order?.payableAmount.toString()),
              Gap(8.h),
              locationTime(context, time: ((order?.duration ?? 0) / 60).toStringAsFixed(1), distance: ((order?.distance  ?? 0) / 1000).toStringAsFixed(1)),
              Gap(8.h),
              readAbleLocationView(context, order?.addresses),
              Gap(8.h),
              ridePreference(context, preferenceList: order?.ridePreference ?? []),
              Gap(16.h),
              orderRequestButtons(context, orderId: order?.id),

            ],
          ),
          )

        ),
      ),
    );
  }
}
