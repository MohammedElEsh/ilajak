import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:ilajak/core/constants/app_constants.dart';
import 'package:ilajak/core/routing/app_router.dart';
import 'package:ilajak/core/shared/wrappers/connectivity_wrapper.dart';
import 'package:ilajak/core/shared/wrappers/screen_util_wrapper.dart';
import 'package:ilajak/core/theme/themes/app_themes.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilWrapper(
      child: MaterialApp.router(
        title: AppConstants.appName,
        debugShowCheckedModeBanner: false,
        theme: AppThemes.light,
        darkTheme: AppThemes.dark,
        themeMode: ThemeMode.light,
        routerConfig: appRouter,
        locale: context.locale,
        supportedLocales: context.supportedLocales,
        localizationsDelegates: context.localizationDelegates,
        builder: (context, child) => ConnectivityWrapper(child: child),
      ),
    );
  }
}
