import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'app.dart';
import 'core/dev/bloc_observer.dart';
import 'core/di/injection.dart';
import 'core/localization/localization_helper.dart';
import 'core/routing/app_router.dart';
import 'core/services/session/session_manager.dart';
import 'core/services/storage/hive_storage_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await HiveStorageService.init();

  await EasyLocalization.ensureInitialized();
  await initDependencies();

  await sl<SessionManager>().initialize();

  initRouter();

  if (kDebugMode) {
    Bloc.observer = AppBlocObserver();
    // await DevTools.resetAll();
  }

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
