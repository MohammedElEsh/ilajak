import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../services/logger/logger_service.dart';
import 'feedback_card.dart';
import 'feedback_message.dart';

class FeedbackHandler {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static void show({
    required FeedbackType type,
    String? title,
    required String description,
    Duration? duration,
  }) {
    final context = navigatorKey.currentContext;
    if (context == null) {
      LoggerService.w('Cannot show feedback: no navigator context',
          tag: 'FeedbackHandler');
      return;
    }

    final message =
        FeedbackMessage(type: type, title: title, description: description);

    LoggerService.i(
        '${type.name}: ${message.title ?? ""} ${message.description}',
        tag: 'FeedbackHandler');

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: FeedbackCard(message: message),
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.floating,
        duration: duration ?? _defaultDuration(type),
        margin: EdgeInsets.all(16.w),
        padding: EdgeInsets.zero,
      ),
    );
  }

  static void success(String description, {String? title, Duration? duration}) {
    show(
        type: FeedbackType.success,
        title: title,
        description: description,
        duration: duration);
  }

  static void error(String description, {String? title, Duration? duration}) {
    show(
        type: FeedbackType.error,
        title: title,
        description: description,
        duration: duration);
  }

  static void info(String description, {String? title, Duration? duration}) {
    show(
        type: FeedbackType.info,
        title: title,
        description: description,
        duration: duration);
  }

  static void warning(String description, {String? title, Duration? duration}) {
    show(
        type: FeedbackType.warning,
        title: title,
        description: description,
        duration: duration);
  }

  static Duration _defaultDuration(FeedbackType type) {
    switch (type) {
      case FeedbackType.success:
        return const Duration(seconds: 2);
      case FeedbackType.error:
        return const Duration(seconds: 4);
      case FeedbackType.info:
        return const Duration(seconds: 3);
      case FeedbackType.warning:
        return const Duration(seconds: 3);
    }
  }
}
