import 'package:deligo_driver/core/utils/date_time_expiry.dart';
import 'package:deligo_driver/data/services/local_storage_service.dart';
import 'package:deligo_driver/presentation/booking/provider/ride_providers.dart';
import 'package:flutter/material.dart';
import 'package:deligo_driver/core/utils/exit_app_dialogue.dart';
import 'package:deligo_driver/core/utils/set_status_bar_color.dart';
import 'package:deligo_driver/core/widgets/location_permission_wrapper.dart';
import 'package:deligo_driver/presentation/account_page/view/account_page.dart';
import 'package:deligo_driver/presentation/wallet/views/wallet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../home_page/view/home_page.dart';
import '../../ride_history/view/ride_history.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class DashboardPage extends ConsumerStatefulWidget {
  const DashboardPage({super.key});

  @override
  ConsumerState<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends ConsumerState<DashboardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    setStatusBarColor(change: true);
    Future.microtask((){
      ref.read(rideDetailsProvider.notifier).reset();
    });
  }

  Future<void> handleRideRequestNotification()async{
    final locale = LocalStorageService();
    final rideData = await locale.getRideNotification();
    if(rideData != null){
      final orderId = rideData['order_id'];
      final sendTime = rideData['notification_send_time'];
      if(orderId != null && sendTime != null){
        final sentTime = DateTime.tryParse(sendTime); //?.toLocal()
        if(sentTime != null){
          final result = checkExpiry(sentTime);
          if(result.isExpired){
            await locale.clearRideNotification();
          }else{
            ref.read(rideDetailsProvider.notifier).getRideDetails(orderId);

          }
        }
      }
    }
  }

  final List<Widget> _pages = const [
    HomePage(),
    Wallet(),
    RideHistoryView(),
    AccountPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) => ExitAppWrapper(
      child: LocationPermissionWrapper(
        child: Scaffold(
          key: _scaffoldKey,
          body: _pages[_selectedIndex],
          bottomNavigationBar: CustomBottomNavBar(
            currentIndex: _selectedIndex,
            onTap: _onItemTapped,
          ),
        ),
      ),
    );
}
