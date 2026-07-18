import 'package:equatable/equatable.dart';

class OnboardingState extends Equatable {
  final int currentPage;
  final bool completed;

  const OnboardingState({
    this.currentPage = 0,
    this.completed = false,
  });

  OnboardingState copyWith({
    int? currentPage,
    bool? completed,
  }) {
    return OnboardingState(
      currentPage: currentPage ?? this.currentPage,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object?> get props => [currentPage, completed];
}
