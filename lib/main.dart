import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:ilajak/app.dart';
import 'package:ilajak/core/dev/bloc_observer.dart';
import 'package:ilajak/core/di/injection.dart';
import 'package:ilajak/core/localization/localization_helper.dart';
import 'package:ilajak/core/routing/app_router.dart';
import 'package:ilajak/core/services/session/session_manager.dart';
import 'package:ilajak/core/services/storage/hive_storage_service.dart';

void main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await HiveStorageService.init();

  await EasyLocalization.ensureInitialized();
  await initDependencies();

  await sl<SessionManager>().initialize();

  initRouter();

  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
    // await DevTools.resetAll();
  }

  FlutterNativeSplash.remove();

  runApp(
    EasyLocalization(
      supportedLocales: LocalizationHelper.supportedLocales,
      path: LocalizationHelper.path,
      fallbackLocale: LocalizationHelper.fallbackLocale,
      // startLocale: const Locale(AppConstants.arabicLangCode),
      child: const App(),
    ),
  );
}
