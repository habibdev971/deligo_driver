import 'package:flutter/material.dart';
import 'package:deligo_driver/data/models/order_response/order_model/order/order.dart';
import 'package:deligo_driver/presentation/auth/views/change_password_page.dart';
import 'package:deligo_driver/presentation/auth/views/driver_personal_info_page.dart';
import 'package:deligo_driver/presentation/auth/views/vehicle_info_page.dart';
import 'package:deligo_driver/presentation/auth/views/login_page.dart';
import 'package:deligo_driver/presentation/auth/views/login_with_password_page.dart';
import 'package:deligo_driver/presentation/auth/views/set_password_page.dart';
import 'package:deligo_driver/presentation/auth/views/verify_otp_page.dart';
import 'package:deligo_driver/presentation/booking/views/booking_page.dart';
import 'package:deligo_driver/presentation/broken_page/view/broken_page.dart';
import 'package:deligo_driver/presentation/dashboard/view/dashboard.dart';
import 'package:deligo_driver/presentation/no_internet/view/no_internet_view.dart';
import 'package:deligo_driver/presentation/payment_method/view/payment_method_view.dart';
import 'package:deligo_driver/presentation/payout_method/view/payout_method_view.dart';
import 'package:deligo_driver/presentation/profile_under_review/view/profile_under_review.dart';
import 'package:deligo_driver/presentation/ride_history/view/ride_history_view.dart';
import 'package:deligo_driver/presentation/ride_history_detail/view/ride_history_detail.dart';
import 'package:deligo_driver/presentation/settngs/views/language_setting_page.dart';
import 'package:deligo_driver/presentation/settngs/views/settings_page.dart';
import 'package:deligo_driver/presentation/splash/views/splash_page.dart';
import 'package:deligo_driver/presentation/wallet/views/wallet.dart';

import '../../data/models/auth_models/register_data_model.dart';
import '../../presentation/auth/views/firebase_otp_page.dart';
import '../../presentation/home_page/view/home_page.dart';
import '../../presentation/payout_method/view/add_payment_gateway.dart';
import '../../presentation/profile/view/profile_info_page.dart';
import '../../presentation/report_issue/view/report_issue_view.dart';
import '../widgets/error_view.dart';
import 'app_routes.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashPage());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginPage());
      case '/dashboard':
        return MaterialPageRoute(builder: (_) => const DashboardPage());
      case '/login-with-password':
        return MaterialPageRoute(builder: (_) => const LoginWithPasswordPage());
      case '/verify-otp':
        return MaterialPageRoute(builder: (_) {
          final String? code = settings.arguments as String?;
          return VerifyOtpPage(code: code,);
        });
      case AppRoutes.verifyOtp:
        return MaterialPageRoute(
            builder: (_){
              final RegisterDataModel? data = settings.arguments as RegisterDataModel?;
              return FirebaseOtpPage(data: data,);
            },
            );
      case '/set-password':
        return MaterialPageRoute(builder: (_) => const SetPasswordPage());
      case '/change-password':
        return MaterialPageRoute(builder: (_) => const ChangePasswordPage());
      case '/driver-personal-info-page':
        final isUpdating = settings.arguments != null ? true : false;
        return MaterialPageRoute(builder: (_) => DriverPersonalInfoPage(isUpdatingProfile: isUpdating,));
      case '/profile-under-review':
        return MaterialPageRoute(builder: (_) => const ProfileUnderReview());
      case '/vehicle-info-page':
        return MaterialPageRoute(builder: (_) => const DriverDocumentsPage());
      case '/home-page':
        return MaterialPageRoute(builder: (_) => const HomePage());
      case '/booking-page':
        return MaterialPageRoute(builder: (_) => const BookingPage());
      case '/profile-info-page':
        return MaterialPageRoute(builder: (_) => const ProfileInfoPage());
      case '/payout-method':
        return MaterialPageRoute(builder: (_) => const PayoutMethodView());
      // case '/settings-page':
      //   return MaterialPageRoute(builder: (_) => const SettingsPage());
      // case '/language-settings-page':
      //   return MaterialPageRoute(builder: (_) => const LanguageSettingPage());
      case '/ride-history-page':
        return MaterialPageRoute(builder: (_) => const RideHistoryPage());
      case '/payment-methods':
        return MaterialPageRoute(builder: (_) => const PaymentMethodsPage());
      case '/wallets-page':
        return MaterialPageRoute(builder: (_) => const Wallet());
      case '/report-issue':
        final orderId = settings.arguments as int?;
        return MaterialPageRoute(builder: (_) => ReportIssueView(orderId));
      case '/ride-history-detail':
        final Order? order = settings.arguments as Order? ;
        return MaterialPageRoute(builder: (_) => RideHistoryDetail(order: order,));
      case '/add-payment-gateway':
        return MaterialPageRoute(builder: (_) => const AddPaymentGateway());
      case '/no-internet':
        return MaterialPageRoute(builder: (_) => const NoInternetPage());
      case '/broken-page':
        return MaterialPageRoute(builder: (_) => const BrokenPage());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: ErrorView(
              message: 'No route defined for ${settings.name}',
            ),
          ),
        );
    }
  }
}
