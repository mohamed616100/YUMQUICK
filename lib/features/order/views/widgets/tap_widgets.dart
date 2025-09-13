import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';

class TapWidgets extends StatelessWidget {
  const TapWidgets({super.key, required this.icon, required this.text, this.OnTap});
  final String icon;
  final String text;
  final Function()? OnTap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: OnTap,
      child: Row(
        children: [
          CustomSvg(path:icon,
            width:18.w,
            height: 26.h,
            color: Appcolors.secondarycolor,),
          SizedBox(width: 32.w,),
          Text(text,style: GoogleFonts.leagueSpartan(
              fontSize: 24.sp,
              fontWeight: FontWeight.w500
          ),),
          Spacer(),
          CustomSvg(path: AppIcons.Arrowfrowerdicon,width: 18.w,height: 18.h,)

        ],
      ),
    );
  }
}
