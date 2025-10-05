// import 'package:flutter/cupertino.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
//
// import '../../../core/config/country_codes.dart';
// import '../../../core/routes/app_routes.dart';
// import '../../../core/state/lang_code_state.dart';
// import '../../../data/models/country_code.dart';
// import '../../../data/services/local_storage_service.dart';
// import '../../../data/services/navigation_service.dart';
// import '../../booking/provider/home_providers.dart';
//
// class SelectedCountryNotifier extends StateNotifier<LangCodeState> {
//   final Ref ref;
//
//   SelectedCountryNotifier(this.ref) : super(LangCodeState.empty()) {
//     _init();
//   }
//
//   Future<void> _init() async {
//     final savedLocale = await LocalStorageService().getSelectedLanguage();
//     final CountryCode initialCountry = countryCodeList.firstWhere(
//           (c) => c.languageCode == savedLocale,
//       orElse: () => countryCodeList[1],
//     );
//     state = state.copyWith(selectedLang: initialCountry,
//         selectedCode:
//         initialCountry
//     // countryCodeList[0]
//     );
//   }
//
//   void setCountry(CountryCode countryCode, {bool loadAddress = false}) {
//     state = state.copyWith(selectedLang: countryCode);
//     LocalStorageService().selectLanguage(countryCode.languageCode);
//
//     Future.delayed(const Duration(microseconds: 300)).then((_){
//       Navigator.of(NavigationService.navigatorKey.currentContext!).pushNamedAndRemoveUntil(
//         AppRoutes.splash,
//             (route)=> false,
//       );
//       if(loadAddress){
//         ref.read(bookingNotifierProvider.notifier).initialize();
//       }
//     });
//   }
//
//   void setPhoneCode(CountryCode phoneCode){
//     LocalStorageService().saveCountryCode(phoneCode.phoneCode);
//     state = state.copyWith(selectedCode: phoneCode);
//   }
//   void reset()=> _init();
//
// }