import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/widgets/Custom_bottom.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';
import 'package:yumquick/features/onbordingAndSplach/models/onBording_data_model.dart';
import 'package:yumquick/features/onbordingAndSplach/views/Launch_Welcome_Screen.dart';
import 'package:yumquick/features/onbordingAndSplach/widgets/skip_widget.dart';
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});
  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}
class _OnboardingViewState extends State<OnboardingView> {
  final PageController _pageController = PageController();
  int currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    if (currentIndex < OnboardingContent.getOnboardingData().length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    } else {
     MyNavigator.goTo(context, const LaunchWelcomeScreen()
         ,type: NavigatorType.pushAndRemoveUntil);

    }
  }

  @override
  Widget build(BuildContext context) {
    final onboardingData = OnboardingContent.getOnboardingData();
    return Scaffold(
      body: ColoredBox(
        color: Appcolors.primarycolor,
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  onboardingData[currentIndex].image,
                  fit: BoxFit.cover,
                ),
              ),

              if (currentIndex != onboardingData.length - 1)
                SkipWidget(
                  onTap: () {
                   MyNavigator.goTo(context, const LaunchWelcomeScreen(),
                       type: NavigatorType.pushAndRemoveUntil);
                  },
                ),

              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  height: 338.h,
                  width: double.infinity,
                  decoration:BoxDecoration(
                    color: Appcolors.textcolorwhite,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                  ),
                  child: Padding(
                    padding:
                    EdgeInsets.symmetric(vertical: 23.h,),
                    child: Column(
                      children: [
                        SizedBox(
                          height:155.h,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: onboardingData.length,
                            onPageChanged: (index) {
                              setState(() {
                                currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              final item = onboardingData[index];
                              return Column(
                                children: [
                                  CustomSvg(
                                    path: item.icon,
                                    width: 31.w,
                                    height: 37.h,
                                  ),
                                  SizedBox(height: 20.h),
                                  Text(
                                    item.title,
                                    style: GoogleFonts.inter(
                                      fontSize: 24.sp,
                                      fontWeight: FontWeight.w900,
                                      color: Appcolors.secondarycolor,
                                    ),
                                  ),
                                  SizedBox(height: 20.h),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                                    child: Text(
                                      item.description,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.leagueSpartan(
                                        fontSize: 14.sp,
                                        height: 0.875.h,
                                        fontWeight: FontWeight.w500,
                                        color: const Color(0xff391713),
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 31.h),
                        SmoothPageIndicator(
                          controller: _pageController,
                          count: onboardingData.length,
                          effect: WormEffect(
                            activeDotColor: Appcolors.secondarycolor,
                            dotColor: const Color(0xffF3E9B5),
                            dotHeight: 4.h,
                            dotWidth: 20.w,
                            radius: 12.r,
                          ),
                        ),
                        SizedBox(height: 32.h),
                        CustomBottom(
                          width: 133.w,
                          height: 36.h,
                          backgroundColor: Appcolors.secondarycolor,
                          reduis: 100.r,
                          text: onboardingData[currentIndex].buttonText,
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w500,
                          letterspacing: -0.5,
                          lineheight: 1.5.h,
                          onTap: _onNextPressed,
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
