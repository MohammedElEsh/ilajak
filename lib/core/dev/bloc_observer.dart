import 'package:flutter_bloc/flutter_bloc.dart';

import '../services/logger/logger_service.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    LoggerService.d('onCreate(${bloc.runtimeType})', tag: 'BlocObserver');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    LoggerService.d(
      'onChange(${bloc.runtimeType})\n'
      '  before: ${change.currentState.runtimeType}\n'
      '  after:  ${change.nextState.runtimeType}',
      tag: 'BlocObserver',
    );
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    LoggerService.e(
      'onError(${bloc.runtimeType})',
      error: error,
      stackTrace: stackTrace,
      tag: 'BlocObserver',
    );
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    LoggerService.d('onClose(${bloc.runtimeType})', tag: 'BlocObserver');
  }
}
