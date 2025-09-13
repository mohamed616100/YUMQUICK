
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/App_images.dart';

class OnboardingData {
  final String image;
  final String icon;
  final String title;
  final String description;
  final String buttonText;

  OnboardingData({
    required this.image,
    required this.icon,
    required this.title,
    required this.description,
    required this.buttonText,
  });
}

class OnboardingContent {
  static List<OnboardingData> getOnboardingData() {
    return [
      OnboardingData(
        image: AppImages.onbording1,
        icon: AppIcons.IcononBording1,
        title: 'Order For Food',
        description: 'Lorem ipsum dolor sit amet, conse ctetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        buttonText: 'Next',
      ),
      OnboardingData(
        image: AppImages.onbording2,
        icon:AppIcons.IcononBording2,
        title: 'Easy Payment',
        description: 'Lorem ipsum dolor sit amet, conse ctetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        buttonText: 'Next',
      ),
      OnboardingData(
        image: AppImages.onbording3,
        icon: AppIcons.IcononBording3,
        title: 'Fast Delivery',
        description: 'Lorem ipsum dolor sit amet, conse ctetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna.',
        buttonText: 'Get Started',
      ),
    ];
  }
}