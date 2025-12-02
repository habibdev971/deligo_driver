import 'package:deligo_driver/data/models/ride_details_model/RideDetailsModel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';

import '../../../core/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/utils/build_network_image.dart';
import '../../../core/utils/format_minute.dart';
import '../../../core/widgets/custom_list_tile.dart';

Widget activityBuilder(
  BuildContext context, {
  List<RideRequest> orderList = const <RideRequest>[],
  bool showPrice = false,
      required String currency
}) => ListView.builder(
  padding: EdgeInsets.symmetric(vertical: 8.h),
  itemCount: orderList.length,
  itemBuilder: (context, index) {
    final ride = orderList[index];
    return listTile(
      context,
      onTap: () async {
        // log('ride id: ${ride.id}');
        // log(await LocalStorageService().getToken() ?? '');
        NavigationService.pushNamed(
          AppRoutes.rideHistoryDetailsPage,
          arguments: ride,
        );
      },
      leading: ClipOval(
        child: buildNetworkImage(
          imageUrl: ride.rider?.profilePicture,
          height: 35,
          width: 35,
          fit: BoxFit.fill,
          errorIconSize: 15,
        ),
      ),
      title: ride.rider?.name ?? 'N/A',
      subtitle:
          "${ride.distance ?? 0}km, ${formatDurationMinutes(ride.estimatedTime)}, ${ride.estimatedFare ?? 0}$currency, ${ride.orderTime ?? ''}",
      subTitleColor: AppColors.contentDisable,
    );
    // final order = orderList[index];
    // return activityCard(context, order: order, onTap: (){
    //   NavigationService.pushNamed(AppRoutes.rideHistoryDetailsPage, arguments: order);
    // }, showCancelItem: order.status != null && order.status!.toLowerCase() == 'cancelled', showPrice: showPrice);
  },
);
