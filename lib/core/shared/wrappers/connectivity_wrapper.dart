import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../constants/app_strings.dart';
import '../../di/injection.dart';
import '../../services/connectivity/connectivity_service.dart';
import '../../services/logger/logger_service.dart';
import '../../shared/feedback/feedback_handler.dart';
import 'offline_banner.dart';

class ConnectivityWrapper extends StatefulWidget {
  final Widget? child;

  const ConnectivityWrapper({super.key, required this.child});

  @override
  State<ConnectivityWrapper> createState() => _ConnectivityWrapperState();
}

class _ConnectivityWrapperState extends State<ConnectivityWrapper> {
  late final Stream<bool> _connectivityStream;
  late final bool _initialStatus;
  bool _isRetrying = false;

  @override
  void initState() {
    super.initState();
    final service = sl<ConnectivityService>();
    _connectivityStream = service.onConnectivityChanged;
    _initialStatus = service.currentStatus;
    LoggerService.d(
      'ConnectivityWrapper initialized — current: ${_initialStatus ? "online" : "offline"}',
      tag: 'Connectivity',
    );
  }

  Future<void> _onRetry() async {
    if (_isRetrying) return;
    setState(() => _isRetrying = true);

    LoggerService.i('Retry: checking connectivity...', tag: 'Connectivity');

    final connected = await sl<ConnectivityService>().isConnected;

    if (!mounted) return;

    if (connected) {
      LoggerService.i('Retry: device is online', tag: 'Connectivity');
      FeedbackHandler.success(AppStrings.sharedConnectionRestored.tr());
    } else {
      LoggerService.w('Retry: still offline', tag: 'Connectivity');
      FeedbackHandler.warning(AppStrings.sharedStillNoConnection.tr());
    }

    setState(() => _isRetrying = false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: _connectivityStream,
      initialData: _initialStatus,
      builder: (context, snapshot) {
        final offline = snapshot.data == false;

        return Stack(
          children: [
            widget.child!,
            if (offline) OfflineWidget(onRetry: _onRetry),
          ],
        );
      },
    );
  }
}
