import '../../../../core/constants/app_assets.dart';
import '../../../../core/constants/app_strings.dart';

class OnboardingPage {
  final String image;
  final String titleKey;
  final String descriptionKey;

  const OnboardingPage({
    required this.image,
    required this.titleKey,
    required this.descriptionKey,
  });
}

final List<OnboardingPage> onboardingPages = [
  const OnboardingPage(
    image: AppAssets.onboarding1,
    titleKey: AppStrings.onboardingStepTitle1,
    descriptionKey: AppStrings.onboardingStepSubtitle1,
  ),
  const OnboardingPage(
    image: AppAssets.onboarding2,
    titleKey: AppStrings.onboardingStepTitle2,
    descriptionKey: AppStrings.onboardingStepSubtitle2,
  ),
  const OnboardingPage(
    image: AppAssets.onboarding3,
    titleKey: AppStrings.onboardingStepTitle3,
    descriptionKey: AppStrings.onboardingStepSubtitle3,
  ),
];
