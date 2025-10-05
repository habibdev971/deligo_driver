import 'package:deligo_driver/presentation/account_page/provider/selected_language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_builder_validators/localization/l10n.dart';
import 'package:deligo_driver/core/routes/app_router.dart';
import 'package:deligo_driver/presentation/account_page/provider/theme_provider.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/fonts.dart';
import 'core/theme/theme.dart';
import 'data/services/navigation_service.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, ref) => ScreenUtilInit(
      designSize: const Size(375, 812),
      splitScreenMode: true,
      minTextAdapt: true,
      builder: (context, child) => MaterialApp(
        navigatorKey: NavigationService.navigatorKey,
        debugShowCheckedModeBanner: false,
        title: dotenv.env['APP_NAME'] ?? '',
        themeMode: ref.watch(themeModeProvider),
        theme: AppTheme.light(Fonts.primary, Fonts.secondary),
        darkTheme: AppTheme.dark(Fonts.primary, Fonts.secondary),
        locale: ref.watch(selectedLanguageProvider),
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
          FormBuilderLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.delegate.supportedLocales,
        onGenerateRoute: AppRouter.generateRoute,
        initialRoute: AppRoutes.splash,
      ),
    );
}
