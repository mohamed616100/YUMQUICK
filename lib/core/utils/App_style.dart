import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/utils/App_colors.dart';

abstract class AppStyle{
  static  TextStyle AppbarTextStyle = GoogleFonts.leagueSpartan(
    fontSize: 28.sp,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );
  static TextStyle LabelTextStyle = GoogleFonts.leagueSpartan(
    fontSize: 20.sp,
    fontWeight: FontWeight.w500,
    color: Appcolors.textcolorblack,
  );
}