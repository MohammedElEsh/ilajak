import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ilajak/features/onboarding/data/models/onboarding_model.dart';
import 'package:ilajak/features/onboarding/presentation/manager/onboarding_cubit.dart';
import 'package:ilajak/features/onboarding/presentation/manager/onboarding_state.dart';
import 'package:ilajak/features/onboarding/presentation/widgets/onboarding_dots.dart';
import 'package:ilajak/features/onboarding/presentation/widgets/onboarding_footer.dart';
import 'package:ilajak/features/onboarding/presentation/widgets/onboarding_header.dart';
import 'package:ilajak/features/onboarding/presentation/widgets/onboarding_item.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    _pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void _previousPage() {
    _pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<OnboardingCubit, OnboardingState>(
      builder: (context, state) {
        final current = state.currentPage;
        final totalPages = onboardingPages.length;
        final isLast = current == totalPages - 1;

        return Scaffold(
          backgroundColor: theme.colorScheme.surface,
          body: Stack(
            children: [
              PageView.builder(
                controller: _pageController,
                itemCount: totalPages,
                onPageChanged: context.read<OnboardingCubit>().onPageChanged,
                itemBuilder: (_, i) {
                  final page = onboardingPages[i];

                  return OnboardingItem(
                    image: page.image,
                    title: page.titleKey.tr(),
                    description: page.descriptionKey.tr(),
                  );
                },
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: SafeArea(
                  child: OnboardingHeader(
                    current: current + 1,
                    total: totalPages,
                    showSkip: !isLast,
                    onSkip: context.read<OnboardingCubit>().complete,
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 200.h,
                child: OnboardingDots(count: totalPages, currentIndex: current),
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: OnboardingFooter(
                  isFirst: current == 0,
                  isLast: isLast,
                  onPrev: _previousPage,
                  onNext: () {
                    if (isLast) {
                      context.read<OnboardingCubit>().complete();
                    } else {
                      _nextPage();
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
