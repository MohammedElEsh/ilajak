import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

import '../logger/logger_service.dart';

abstract class ConnectivityService {
  Future<bool> get isConnected;

  Stream<bool> get onConnectivityChanged;

  bool get currentStatus;

  void dispose();
}

class ConnectivityServiceImpl implements ConnectivityService {
  final Connectivity _connectivity;
  final _controller = StreamController<bool>.broadcast();
  bool _lastStatus = true;
  Timer? _debounce;

  ConnectivityServiceImpl(this._connectivity) {
    LoggerService.i('ConnectivityService initialized', tag: 'Connectivity');
    _connectivity.onConnectivityChanged.listen(_onConnectivityEvent);
  }

  @override
  bool get currentStatus => _lastStatus;

  @override
  Future<bool> get isConnected async {
    final result = await _connectivity.checkConnectivity();
    final connected = !result.contains(ConnectivityResult.none);
    LoggerService.d(
      'isConnected check: $connected (${result.map((e) => e.name).join(', ')})',
      tag: 'Connectivity',
    );
    return connected;
  }

  @override
  Stream<bool> get onConnectivityChanged => _controller.stream;

  void _onConnectivityEvent(List<ConnectivityResult> results) {
    final connected = !results.contains(ConnectivityResult.none);

    if (connected == _lastStatus) return;

    _debounce?.cancel();
    _debounce = Timer(const Duration(seconds: 1), () {
      _lastStatus = connected;
      LoggerService.i(
        'Connectivity changed: ${connected ? "ONLINE" : "OFFLINE"} '
        '(${results.map((e) => e.name).join(', ')})',
        tag: 'Connectivity',
      );
      _controller.add(connected);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.close();
  }
}
