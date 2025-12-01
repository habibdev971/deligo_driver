import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deligo_driver/common/loading_view.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/core/widgets/error_view.dart';
import 'package:deligo_driver/presentation/home_page/widgets/activity_builder.dart';
import 'package:deligo_driver/presentation/home_page/widgets/activity_top.dart';
import 'package:deligo_driver/presentation/ride_history/provider/ride_history_provider.dart';

import '../../dashboard/view_model/currency_notifier.dart';

Widget todayActivity(BuildContext context) => Padding(
  padding: EdgeInsets.symmetric(vertical: 9.0.h),
  child: Column(
    children: [
      activityTop(context),
      Expanded(
        child: Consumer(
          builder: (context, ref, _) {
            final state = ref.watch(rideHistoryProvider);
            final currency = ref.watch(currencyProvider);
            return state.list.when(
              initial: () => const SizedBox.shrink(),
              loading: () => const LoadingView(),
              success: (data) => activityBuilder(context, orderList: data, currency: currency),
              error: (e) => ErrorView(message: e.message),
            );
          },
        ),
      ),
    ],
  ),
);
