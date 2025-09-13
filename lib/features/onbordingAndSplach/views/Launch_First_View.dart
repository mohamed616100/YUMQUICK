import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';
import 'package:yumquick/features/Home/views/main_home_view.dart';
import 'package:yumquick/features/onbordingAndSplach/views/onbordingView.dart';

class LaunchFirstView extends StatefulWidget {
  const LaunchFirstView({super.key, this.AccessToken});
  final AccessToken;
  @override
  State<LaunchFirstView> createState() => _LaunchFirstViewState();
}
class _LaunchFirstViewState extends State<LaunchFirstView> {
  @override
  void initState() {
    gotoonbording();
    super.initState();
  }
  gotoonbording() {
    Future.delayed(Duration(milliseconds: 2000), () {
      if (!mounted) return;
      if (widget.AccessToken != null) {
        MyNavigator.goTo(
            context, MainHomeView(
        ), type: NavigatorType.pushAndRemoveUntil);
      } else {
        MyNavigator.goTo(
            context, OnboardingView(),
            type: NavigatorType.pushAndRemoveUntil);
      }
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Appcolors.primarycolor,
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           CustomSvg(path: AppIcons.iconsplach,
             width: 179.h,
             height: 202.w,
           ),
           SizedBox(height: 27.h),
           Row(
             mainAxisAlignment: MainAxisAlignment.center,
             children: [
               Text('YUM',style:GoogleFonts.poppins(
                 fontSize: 34.85.sp,
                 fontWeight: FontWeight.w800,
                 color: Appcolors.secondarycolor,
               )),
               Text('QUICK',style:GoogleFonts.poppins(
                 fontSize: 34.85.sp,
                 fontWeight: FontWeight.w800,
                 color: Appcolors.textcolorwhite,
               )),
             ],
           )
         ],
       ),
    );
  }
}
