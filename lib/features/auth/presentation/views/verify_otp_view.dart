import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:hugeicons/hugeicons.dart';

import '../../../../core/constants/app_strings.dart';
import '../../../../core/formatters/timer_formatter.dart';
import '../../../../core/routing/route_names.dart';
import '../../../../core/shared/buttons/app_button.dart';
import '../../../../core/shared/feedback/feedback_handler.dart';
import '../../../../core/utils/timer_manager.dart';
import '../manager/auth_verify_otp_cubit.dart';
import '../manager/auth_verify_otp_state.dart';
import '../widgets/otp_field.dart';

class VerifyOtpView extends StatefulWidget {
  const VerifyOtpView({super.key, required this.email});

  final String email;

  @override
  State<VerifyOtpView> createState() => _VerifyOtpViewState();
}

class _VerifyOtpViewState extends State<VerifyOtpView> {
  final TimerManager _timerManager = TimerManager();
  final _otpFieldKey = GlobalKey<OtpFieldState>();
  int _remainingSeconds = 60;
  bool _canResend = false;
  String _otpCode = '';

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _remainingSeconds = 60;
    _canResend = false;
    _timerManager.start(60);
    _timerManager.tick.listen((seconds) {
      if (mounted) {
        setState(() {
          _remainingSeconds = seconds;
          if (seconds == 0) _canResend = true;
        });
      }
    });
  }

  void _onOtpCompleted(String code) {
    setState(() => _otpCode = code);
  }

  void _onVerify() {
    if (_otpCode.length < 6) {
      FeedbackHandler.error(AppStrings.authVerifyOtpIncomplete.tr());
      return;
    }
    context.read<AuthVerifyOtpCubit>().verifyOtp(
      email: widget.email,
      code: _otpCode,
    );
  }

  void _onResend() {
    if (!_canResend) return;
    context.read<AuthVerifyOtpCubit>().resendOtp(email: widget.email);
    _otpFieldKey.currentState?.reset();
    _otpCode = '';
    _startTimer();
  }

  @override
  void dispose() {
    _timerManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      backgroundColor: colors.surface,
      body: SafeArea(
        child: BlocConsumer<AuthVerifyOtpCubit, AuthVerifyOtpState>(
          listener: (context, state) {
            if (state is AuthVerifyOtpSuccess) {
              context.push(
                RouteNames.resetPassword,
                extra: {
                  'email': widget.email,
                  'otp': _otpCode,
                },
              );
            } else if (state is AuthVerifyOtpResendSuccess) {
              FeedbackHandler.success(AppStrings.authVerifyOtpResent.tr());
            } else if (state is AuthVerifyOtpError) {
              FeedbackHandler.error(state.message);
            }
          },
          builder: (context, state) {
            final isVerifyLoading = state is AuthVerifyOtpLoading;
            final isResendLoading = state is AuthVerifyOtpResendLoading;

            return LayoutBuilder(
              builder: (context, constraints) {
                return SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 48.w),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      minHeight: constraints.maxHeight,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 32.h),
                        Center(
                          child: Container(
                            width: 200.w,
                            height: 200.w,
                            decoration: BoxDecoration(
                              color: colors.primary.withValues(alpha: 0.1),
                              shape: BoxShape.circle,
                            ),
                            child: Center(
                              child: HugeIcon(
                                icon: HugeIcons.strokeRoundedPasswordValidation,
                                color: colors.primary,
                                size: 84.sp,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 32.h),
                        Text(
                          AppStrings.authVerifyOtpTitle.tr(),
                          style: theme.textTheme.displayLarge,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 12.h),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: AppStrings.authVerifyOtpSubtitle.tr(),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: colors.onSurfaceVariant,
                                  wordSpacing: 2.sp,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextSpan(
                                text: widget.email,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: colors.primary,
                                  fontWeight: FontWeight.bold,
                                  wordSpacing: 2.sp,
                                  fontSize: 16.sp,
                                ),
                              ),
                              TextSpan(
                                text: AppStrings.authVerifyOtpSubtitleEnd.tr(),
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  color: colors.onSurfaceVariant,
                                  wordSpacing: 2.sp,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 48.h),
                        OtpField(key: _otpFieldKey, onCompleted: _onOtpCompleted),
                        SizedBox(height: 36.h),
                        AppButton(
                          variant: AppButtonVariant.elevated,
                          label: AppStrings.authVerifyOtpButton.tr(),
                          onPressed: _onVerify,
                          isLoading: isVerifyLoading,
                        ),
                        SizedBox(height: 32.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedStopWatch,
                              color: colors.onSurfaceVariant,
                              size: 18.r,
                            ),
                            SizedBox(width: 6.w),
                            Text(
                              '${AppStrings.authVerifyOtpResendIn.tr()} ${TimerFormatter.formatCountdown(_remainingSeconds)}',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.authVerifyOtpDidntReceive.tr(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colors.onSurfaceVariant,
                              ),
                            ),
                            SizedBox(width: 4.w),
                            GestureDetector(
                              onTap: _canResend && !isResendLoading
                                  ? _onResend
                                  : null,
                              child: isResendLoading
                                  ? SizedBox(
                                      width: 16.r,
                                      height: 16.r,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: colors.primary,
                                      ),
                                    )
                                  : Text(
                                      AppStrings.authVerifyOtpResendButton.tr(),
                                      style: theme.textTheme.bodyMedium?.copyWith(
                                        color: _canResend
                                            ? colors.primary
                                            : colors.onSurfaceVariant
                                                .withValues(alpha: 0.5),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
