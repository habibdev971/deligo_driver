// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../core/routes/app_routes.dart';
// import '../../../core/state/app_flow_state.dart';
// import '../../../core/utils/helpers.dart';
// import '../../../data/services/local_storage_service.dart';
// import '../../../data/services/navigation_service.dart';
// import '../../booking/provider/ride_providers.dart';
// import '../../booking/view_model/handle_order_status_update.dart';
//
// class AppFlowNotifier extends StateNotifier<AppFlowState> {
//   final Ref _ref;
//   AppFlowNotifier(this._ref) : super(const AppFlowState.loginRequired());
//
//   void setAppFlowState() async{
//     final bool isLoggedIn = await LocalStorageService().isLoggedIn();
//     final String? pageName = await LocalStorageService().getRegistrationProgress();
//
//     if (_isRegistrationComplete(pageName)) {
//       _handleRegisteredFlow(isLoggedIn);
//     } else {
//       _handleIncompleteRegistration(pageName);
//     }
//   }
//
//   bool _isRegistrationComplete(String? pageName) => pageName == AppRoutes.dashboard;
//
//   void _handleRegisteredFlow(bool isLoggedIn) {
//     if (isLoggedIn) {
//       _ref.watch(tripActivityNotifierProvider).when(success: (order){
//         if(order != null){
//           // return handleOrderStatusUpdate(status: order.status?.toLowerCase() ?? '', orderId: order.id?.toInt(), ref: _ref, payMethod: order.payMethod);
//         }else{
//            NavigationService.pushNamedAndRemoveUntil(AppRoutes.dashboard);
//            return;
//         }
//       }, initial: () {  }, loading: () {  }, error: ( failure) {
//         NavigationService.pushNamedAndRemoveUntil(AppRoutes.brokenPage);
//         }, );
//
//     } else {
//       NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
//     }
//   }
//
//   void _handleIncompleteRegistration(String? pageName) {
//
//     switch (pageName) {
//       case AppRoutes.verifyOTP:
//       case AppRoutes.profileUnderReview:
//         if (pageName == AppRoutes.profileUnderReview) {
//           showNotification(
//             message: 'Thank you for uploading all information. Please wait, we will notify you.',
//             isSuccess: true,
//           );
//         }
//         NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
//         break;
//
//       case null:
//         NavigationService.pushNamedAndRemoveUntil(AppRoutes.login);
//         break;
//
//       default:
//         showNotification(message: 'Please complete your registration');
//         NavigationService.pushNamedAndRemoveUntil(pageName);
//         break;
//     }
//   }
// }
