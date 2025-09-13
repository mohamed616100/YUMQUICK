import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/widgets/Custom_bottom.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';
import 'package:yumquick/features/Auth/views/Login_view.dart';
import 'package:yumquick/features/Auth/views/SignUp_view.dart';
class LaunchWelcomeScreen extends StatelessWidget {
  const LaunchWelcomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.secondarycolor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomSvg(path: AppIcons.iconsplach,
            width: 179.h,
            height: 202.w,
            color: Appcolors.primarycolor,
          ),
          SizedBox(height: 27.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('YUM',style:GoogleFonts.poppins(
                fontSize: 34.85.sp,
                fontWeight: FontWeight.w800,
                color: Appcolors.primarycolor,
              )),
              Text('QUICK',style:GoogleFonts.poppins(
                fontSize: 34.85.sp,
                fontWeight: FontWeight.w800,
                color: Appcolors.textcolorwhite,
              )),
            ],
          ),
          SizedBox(height: 27.h),
          Padding(
            padding:EdgeInsets.symmetric(horizontal: 50.w),
            child: Text('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod.',
              textAlign: TextAlign.center,
              style: GoogleFonts.leagueSpartan(
                fontSize: 14.sp,
                height: 0.875.h,
                fontWeight: FontWeight.w500,
                color: Appcolors.textcolorwhite,
              )
            ),
          ),
          SizedBox(height: 40.h),
          CustomBottom(
            onTap: (){
              MyNavigator.goTo(context, LoginView(),
                  type: NavigatorType.push);
            },
              width: 207.w,
              height: 45.h,
              backgroundColor: Appcolors.primarycolor,
              reduis: 30.r,
              text: 'Log In',
              fontSize: 24.sp,
              fontWeight: FontWeight.w500,
              letterspacing: 0,
              lineheight: 1,
            colortext: Appcolors.secondarycolor,
          ),
          SizedBox(height: 4.h),
          CustomBottom(
            onTap: (){
              MyNavigator.goTo(context, SignupView(),type: NavigatorType.push);
            },
            width: 207.w,
            height: 45.h,
            backgroundColor: Appcolors.Yellow2,
            reduis: 30.r,
            text: 'Sign Up',
            fontSize: 24.sp,
            fontWeight: FontWeight.w500,
            letterspacing: 0,
            lineheight: 1,
            colortext: Appcolors.secondarycolor,
          )
        ],
      ),
    );
  }
}
