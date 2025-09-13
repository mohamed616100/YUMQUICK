import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';
import 'package:yumquick/features/onbordingAndSplach/views/Launch_Welcome_Screen.dart';
class LogoutWidget extends StatelessWidget {
  const LogoutWidget({super.key});
  Future<void> _logout(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('access_token');
    await prefs.remove('refresh_token');
   MyNavigator.goTo(context, LaunchWelcomeScreen(),type: NavigatorType.pushAndRemoveUntil);
  }
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
            onTap: () {
              _logout(context);
            },
            child: Row(
              children: [
                CustomSvg(path: AppIcons.LogOuticon, width: 20.w, height: 20.h),
                SizedBox(width: 32.w,),
                Text('Log Out',
                  style: TextStyle(
                      fontSize: 20.sp, fontWeight: FontWeight.w500),)
              ],
            ),
    );
  }
}
