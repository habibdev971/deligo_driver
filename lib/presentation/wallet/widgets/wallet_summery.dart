import 'package:deligo_driver/presentation/dashboard/view_model/currency_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/theme/color_palette.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/presentation/wallet/provider/provider.dart';
import 'package:deligo_driver/presentation/wallet/widgets/withdraw_dialogue.dart';

import '../../payment_method/provider/provider.dart';

Widget walletSummery(BuildContext context) => Consumer(
  builder: (context, ref, _) {
    final balance = ref.watch(walletsBalanceProvider);
    final data = balance.whenOrNull(success: (data) => data.data);
    final currency = ref.watch(currencyProvider);
    return Container(
      padding: EdgeInsets.all(12.r),
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(12.r),
      //   image: DecorationImage(
      //     image: Assets.images.walletBackground.provider(),
      //     fit: BoxFit.fill,
      //   ),
      // ),
      child: IntrinsicHeight(
        child: Column(
          children: [
            // Row(
            //   children: [
            //     gradientCard(
            //       context,
            //       title: localize(context).payment_received,
            //       value: (data?.receivedAmount ?? 0).toString(),
            //       currency: currency,
            //     ),
            //     Gap(16.w),
            //     gradientCard(
            //       context,
            //       title: localize(context).payment_withdraw,
            //       value: (data?.paymentWithdraw ?? 0).toString(),
            //       isReceived: false,
            //       currency: currency,
            //     ),
            //   ],
            // ),
            // Gap(12.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        currency + (data?.balance?.toString() ?? '0'),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: context.bodyMedium?.copyWith(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.w700,
                          // color: Colors.black,
                        ),
                      ),
                      Text(
                        localize(context).current_balance,

                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                        style: context.bodyMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          // color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

              ],
            ),
            Gap(16.h),
            InkWell(
              onTap: () {
                ref
                    .read(paymentMethodsNotifierProvider.notifier)
                    .getPaymentMethods();
                showWithdrawDialog(context);
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 8.h,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: ColorPalette.primary50,
                ),
                child: Text(
                  localize(context).tips_withdraw,
                  style: context.bodyMedium?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  },
);
