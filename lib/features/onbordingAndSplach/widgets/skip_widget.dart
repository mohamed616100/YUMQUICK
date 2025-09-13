import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';

class SkipWidget extends StatelessWidget {
  const SkipWidget({super.key, this.onTap});
  final void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 21.h,
      right: 35.w,
      child: GestureDetector(
        onTap: onTap,
        child: Row(
          children:[
            Text(
              "Skip",
              style: GoogleFonts.leagueSpartan(
                color: Appcolors.secondarycolor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(width: 8.w),
            CustomSvg(path:AppIcons.Arrowfrowerdicon,width: 8.w,height: 13.h)
          ],
        ),
      ),
    );
  }
}
