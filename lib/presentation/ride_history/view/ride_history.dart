import 'dart:developer';

import 'package:deligo_driver/common/error_view.dart';
import 'package:deligo_driver/common/loading_view.dart';
import 'package:deligo_driver/core/extensions/extensions.dart';
import 'package:deligo_driver/core/routes/app_routes.dart';
import 'package:deligo_driver/core/utils/app_colors.dart';
import 'package:deligo_driver/core/utils/exit_app_dialogue.dart';
import 'package:deligo_driver/core/utils/format_minute.dart';
import 'package:deligo_driver/core/utils/is_dark_mode.dart';
import 'package:deligo_driver/core/utils/localize.dart';
import 'package:deligo_driver/core/widgets/app_bar/app_bar.dart';
import 'package:deligo_driver/data/services/navigation_service.dart';
import 'package:deligo_driver/presentation/dashboard/view_model/currency_notifier.dart';
import 'package:deligo_driver/presentation/ride_history/provider/ride_history_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../core/utils/build_network_image.dart';
import '../../../core/widgets/custom_list_tile.dart';
import '../../../data/models/ride_details_model/RideDetailsModel.dart';

class RideHistoryView extends ConsumerStatefulWidget {
  const RideHistoryView({super.key});

  @override
  ConsumerState<RideHistoryView> createState() => _RideHistoryState();
}

class _RideHistoryState extends ConsumerState<RideHistoryView> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _scrollControllers = List.generate(4, (_) => ScrollController());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

    _tabController.index = 2;
    // Load Completed tab by default
    Future.microtask(() {
      ref.read(rideHistoryProvider.notifier).refreshRideHistory(status: 'COMPLETED');
    });

    // Scroll listener for pagination
    for (int i = 0; i < _scrollControllers.length; i++) {
      _scrollControllers[i].addListener(() {
        final notifier = ref.read(rideHistoryProvider.notifier);
        final state = ref.read(rideHistoryProvider);
        if (_scrollControllers[i].position.pixels >=
            _scrollControllers[i].position.maxScrollExtent - 100 &&
            state.hasMore) {
          notifier.loadMoreRideHistory();
        }
      });
    }

    // Tab change listener
    // _tabController.addListener(() {
    //   if (_tabController.indexIsChanging) return;
    //   final status = getStatusFromIndex(_tabController.index);
    //   ref.read(rideHistoryProvider.notifier).refreshRideHistory(status: status);
    // });
  }

  @override
  void dispose() {
    _tabController.dispose();
    for (final c in _scrollControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ExitAppWrapper(
      child: Scaffold(
        backgroundColor: isDarkMode() ? Colors.black : Colors.white,
        appBar: mainAppBar(context, title: localize(context).ride_history, hideLeading: true),
        body: SafeArea(
          child: Column(
            children: [
              // SizedBox(height: 12.h),
              Container(
                color: isDarkMode() ? Colors.black : Colors.white,
                padding: EdgeInsets.all(16.r),
                child: Container(
                  // margin: EdgeInsets.symmetric(horizontal: 16.w),
                  decoration: BoxDecoration(
                    // color: AppColors.primary.withValues(alpha: 0.05),
                    color: isDarkMode() ? Colors.black12 : Colors.white ,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: AppColors.primary),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    // isScrollable: true,
                    indicator: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    // physics: ,
          
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    unselectedLabelColor: AppColors.textTertiary,
                    dividerColor: Colors.transparent,
                    labelStyle: context.bodyMedium?.copyWith(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                    ),
                    labelPadding: EdgeInsets.symmetric(horizontal: 0.w),
                    // indicatorSize: TabBarIndicatorSize.label,
          
                    onTap: (index){
                      final status = getStatusFromIndex(index);
                      ref.read(rideHistoryProvider.notifier).refreshRideHistory(status: status);
                    },
                    tabs:  [
                      Tab(text: localize(context).tab_upcoming),
                      Tab(text:  localize(context).tab_ongoing),
                      Tab(text: localize(context).tab_completed),
                      Tab(text: localize(context).tab_cancelled),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    buildTabView(context, 'SCHEDULED', _scrollControllers[0]),
                    buildTabView(context, 'ON_GOING', _scrollControllers[1]),
                    buildTabView(context, 'COMPLETED', _scrollControllers[2]),
                    buildTabView(context, 'CANCELLED', _scrollControllers[3]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

  Widget buildTabView(BuildContext context, String status, ScrollController controller) {
    final state = ref.watch(rideHistoryProvider);
    final currency = ref.watch(currencyProvider);
    return state.list.when(initial: ()=> const SizedBox.shrink(), loading: ()=> const LoadingView(), success: (data){

      if (data.isEmpty) {
        return Center(child: Text(localize(context).no_status_rides_found(status)));
      }else{
        return RefreshIndicator(
          onRefresh: () async {
            await ref.read(rideHistoryProvider.notifier).refreshRideHistory();
          },
          child: ListView.builder(
            controller: controller,
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            itemCount: data.length + 1,
            itemBuilder: (context, i) {
              if (i == data.length) {
                return state.hasMore
                    ? const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Center(child: CircularProgressIndicator()),
                )
                    : const SizedBox.shrink();
              }

              final ride = data[i];
              return listTile(
                context,
                  onTap: ()async{
                  log('ride id: ${ride.id}');
                  // log(await LocalStorageService().getToken() ?? '');
                  NavigationService.pushNamed(AppRoutes.rideHistoryDetailsPage, arguments: ride);
              },
                leading: ClipOval(child: buildNetworkImage(imageUrl: ride.rider?.profilePicture, height: 35, width: 35, fit: BoxFit.fill, errorIconSize: 15)),
                title: ride.rider?.name ?? 'N/A',
                subtitle: "${ride.distance ?? 0}km, ${formatDurationMinutes(ride.estimatedTime)}, ${ride.estimatedFare ?? 0}$currency, ${ride.orderTime ?? ''}",
                subTitleColor: AppColors.contentDisable,
                trailing: Text(
                  ride.status ?? '',
                  style: context.bodyMedium?.copyWith(
                    fontSize: 8.sp,
                    fontWeight: FontWeight.w500,
                    color: getStatusColor(status),
                  ),
                ),
              );
            },
          ),
        );
      }
    }, error: (error)=> ErrorView(message: error.message));

  }

  String getStatusFromIndex(int index) {
    switch (index) {
      case 0: return 'SCHEDULED';
      case 1: return 'ON_GOING';
      case 2: return 'COMPLETED';
      case 3: return 'CANCELLED';
      default: return 'COMPLETED';
    }
  }

  String getStatusText(String status, RideRequest ride) {
    if (status == 'SCHEDULED') return 'Scheduled at ${ride.orderTime ?? 'N/A'}';
    if (status == 'ON_GOING') return 'On Going';
    if (status == 'COMPLETED') return 'Done';
    if (status == 'CANCELLED') return 'Canceled';
    return '';
  }


}

Color getStatusColor(String status) {
  if (status == 'COMPLETED') return Colors.green;
  if (status == 'CANCELLED') return Colors.red;
  if (status == 'ON_GOING') return Colors.orange;
  return AppColors.textSecondary;
}