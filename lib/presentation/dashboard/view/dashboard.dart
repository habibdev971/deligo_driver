import 'package:flutter/material.dart';
import 'package:deligo_driver/core/utils/exit_app_dialogue.dart';
import 'package:deligo_driver/core/utils/set_status_bar_color.dart';
import 'package:deligo_driver/core/widgets/location_permission_wrapper.dart';
import 'package:deligo_driver/presentation/account_page/view/account_page.dart';
import 'package:deligo_driver/presentation/ride_history/view/ride_history_view.dart';
import 'package:deligo_driver/presentation/wallet/views/wallet.dart';

import '../../home_page/view/home_page.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  int _selectedIndex = 0;


  @override
  void initState() {
    super.initState();
    setStatusBarColor(change: true);
  }

  final List<Widget> _pages = const [
    HomePage(),
    Wallet(),
    RideHistoryPage(),
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
