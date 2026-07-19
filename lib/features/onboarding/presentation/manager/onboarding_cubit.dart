import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/session/session_manager.dart';
import 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  final SessionManager _sessionManager;

  OnboardingCubit(this._sessionManager) : super(const OnboardingState()) {
    // LoggerService.i('Onboarding initialized', tag: 'ONBOARDING');
  }

  void onPageChanged(int page) {
    // LoggerService.d('Page changed → $page', tag: 'ONBOARDING');

    emit(state.copyWith(currentPage: page));
  }

  Future<void> complete() async {
    // LoggerService.i('Onboarding completion done', tag: 'ONBOARDING');

    await _sessionManager.completeOnboarding();

    // LoggerService.i('Onboarding completed successfully', tag: 'ONBOARDING');

    emit(state.copyWith(completed: true));
  }
}
