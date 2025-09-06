import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/common/error_view.dart';
import 'package:deligo_driver/common/loading_view.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/data/models/payment_methods_model/payment_methods_model.dart';
import '../../../core/utils/build_network_image.dart';
import '../provider/provider.dart';

Widget paymentMethodDropdown(BuildContext context,
    {Function(String v)? onChange}) => Consumer(builder: (context, ref, _) {
    final state = ref.watch(paymentMethodsNotifierProvider);
    final selectPaymentMethod = ref.read(selectedPayMethodProvider.notifier);
    final selectPaymentMethodState = ref.watch(selectedPayMethodProvider);

    return state.when(
        initial: () => const SizedBox.shrink(),
        loading: () => const LoadingView(),
        success: (list) {
          if(list.isEmpty){
            return Center(child: Text(localize(context).no_payment_methods_available),);
          }
          return DropdownButtonFormField<PaymentMethods?>(
              value: selectPaymentMethodState,
              isExpanded: true,
              icon: Icon(
                Icons.keyboard_arrow_down_outlined,
                color: isDarkMode() ? Colors.white : Colors.black,
                size: 18.h,
              ),

              hint: Text(
                localize(context).select_card_type,
                style: context.bodyMedium?.copyWith(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF687387)),
              ),
              dropdownColor: context.surface,
              items: list
                  .map(
                    (e) => DropdownMenuItem<PaymentMethods>(
                  value: e,
                  child: Row(
                    children: [
                      buildNetworkImage(
                          imageUrl: e.logo,
                          height: 25.h,
                          width: 70.w,
                          fit: BoxFit.fill,
                          errorIconSize: 20.h
                      ),
                      Gap(16.w),
                      Text(
                        e.value?.capitalize() ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.bodyMedium?.copyWith(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF687387)),
                      )
                    ],
                  ),
                ),
              )
                  .toList(),
              onChanged: (v) {
                if (v != null) {
                  selectPaymentMethod.selectPaymentMethod(v);
                }
              });
        },
        error: (e) => ErrorView(message: e.message));
  });
