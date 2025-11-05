import 'package:deligo_driver/presentation/dashboard/view_model/currency_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/gen/assets.gen.dart';
import 'package:deligo_driver/presentation/home_page/provider/home_notifier_provider.dart';
import 'package:deligo_driver/presentation/home_page/widgets/summery_card.dart';

import '../../../core/utils/localize.dart';

Widget summery(BuildContext context)=> Consumer(
    builder: (context, ref, _) {
      final state = ref.watch(homeProvider);
      final data = state.whenOrNull(success: (d)=> d);
      final currency = ref.watch(currencyProvider);
      return Column(
        children: [
          Row(
            children: [
              summeryCard(context, title: localize(context).your_balance, value: '$currency${data?.wallet ?? 0}', icon: Assets.images.balance, backgroundColor: const Color(0xFF3B3E4B)),
              Gap(12.w),
              summeryCard(context, title: localize(context).todays_earning, value:  '$currency${data?.todayEarning ?? 0}', icon: Assets.images.balance, backgroundColor: const Color(0xFF8154DA)),
            ],
          ),
          Gap(12.h),
          Row(
            children: [
              summeryCard(context, title: localize(context).cancel_ride, value: '${data?.cancelRide ?? 0}', icon: Assets.images.taxi, backgroundColor: const Color(0xFFF87A5E)),
              Gap(12.w),
              summeryCard(context, title: localize(context).your_ride_complete, value: '${data?.completeRide ?? 0}', icon: Assets.images.taxi, backgroundColor: const Color(0xFF0CA96A)),
            ],
          ),
          Gap(8.h),
        ],
      );
    }
  );