import 'dart:ui';

import 'package:deligo_driver/data/models/order_response/order_model/address/address.dart';
import 'package:deligo_driver/data/models/order_response/pusher_order/PusherRequestOrderModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/show_global_dialogue.dart';
import 'package:deligo_driver/presentation/home_page/widgets/rider_details.dart';
import 'package:deligo_driver/presentation/home_page/widgets/location_time_calculated.dart';
import 'package:deligo_driver/presentation/home_page/widgets/order_request_buttons.dart';
import 'package:deligo_driver/presentation/home_page/widgets/readable_location_view.dart';

import '../../../data/models/ride_details_model/RideDetailsModel.dart';
import '../../booking/view_model/reverse_timer_notifier.dart';

void orderRequestDialogue({PusherRequestOrderModel? data}) {
  showGlobalAlertDialog(
    child: _OrderRequestDialog(data: data,),
  );
}

class _OrderRequestDialog extends ConsumerStatefulWidget {
  final PusherRequestOrderModel? data;
  const _OrderRequestDialog({this.data});

  @override
  ConsumerState<_OrderRequestDialog> createState() => _OrderRequestDialogState();
}

class _OrderRequestDialogState extends ConsumerState<_OrderRequestDialog> {
  @override
  void initState() {
    super.initState();
    Future.microtask((){
      ref.read(reverseTimerProvider.notifier).startTimer();
    });
  }

  @override
  Widget build(BuildContext context) {
    final remaining = ref.watch(reverseTimerProvider);
    final notifier = ref.read(reverseTimerProvider.notifier);
    final double progress = 1 - (remaining / notifier.totalTime);

    return Dialog(
      backgroundColor: Colors.transparent, // transparent to see painter border
      insetPadding: EdgeInsets.all(16.r),
      child: CustomPaint(
        painter: RedBorderPainter(progress),
        child: Container(
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: isDarkMode() ? Colors.grey[900] : Colors.white,
            borderRadius: BorderRadius.circular(16.r),
          ),
          padding: EdgeInsets.all(16.r),
          child: IntrinsicHeight(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                riderDetails(
                  context,
                  Rider(
                    id: widget.data?.user?.id,
                    name: widget.data?.user?.fullName,
                    profilePicture: widget.data?.user?.userInfo?.picture,
                    rating: widget.data?.user?.userInfo?.rattings,
                  ),
                  amount: (widget.data?.estimatedFare ?? 0).toString(),
                ),
                Gap(8.h),
                locationTime(
                  context,
                  time: (widget.data?.estimatedTime ?? 0).toStringAsFixed(1),
                  distance:
                  (widget.data?.distanceFromDriver ?? 0).toStringAsFixed(1),
                ),
                Gap(8.h),
                readAbleLocationView(
                  context,
                  Addresses(
                    pickupAddress: widget.data?.pickupLocation?.address,
                    dropAddress: widget.data?.dropoffLocation?.address,
                  ),
                ),
                Gap(16.h),
                orderRequestButtons(context,
                    orderId: widget.data?.rideRequestId),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


class RedBorderPainter extends CustomPainter {
  final double progress; // 0 → 1
  RedBorderPainter(this.progress);

  @override
  void paint(Canvas canvas, Size size) {
    final double strokeWidth = 4;
    final Rect rect = Offset.zero & size;
    final double radius = 16;

    final Paint bgPaint = Paint()
      ..color = Colors.red.withValues(alpha: 0.2)
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    final Paint progressPaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    // Draw background border
    final RRect rRect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(radius),
    );
    canvas.drawRRect(rRect, bgPaint);

    // Draw progress around border (as an arc)
    final Path path = Path()..addRRect(rRect);
    final PathMetrics metrics = path.computeMetrics();

    final double remainingProgress = progress;
    for (final metric in metrics) {
      final pathLength = metric.length * remainingProgress;
      final Path extractPath = metric.extractPath(0, pathLength);
      canvas.drawPath(extractPath, progressPaint);
      break; // since only one segment is present
    }
  }

  @override
  bool shouldRepaint(covariant RedBorderPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
