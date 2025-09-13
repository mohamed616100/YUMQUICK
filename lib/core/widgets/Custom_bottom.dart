import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/utils/App_colors.dart';
class CustomBottom extends StatelessWidget {
  const CustomBottom({
    super.key,
    required this.width,
    required this.height,
    required this.backgroundColor,
    required this.reduis,
    required this.text,
    required this.fontSize,
    required this.fontWeight,
    required this.letterspacing,
    required this.lineheight,
    this.onTap, this.colortext,

  });
  final double lineheight;
  final double letterspacing;
  final double fontSize;
  final String text;
  final double reduis;
  final backgroundColor;
 final double width;
 final double height;
 final FontWeight fontWeight;
 final  void Function()? onTap;
 final  Color? colortext;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:onTap,
      child: Container(
        alignment: Alignment.center,
        width:width,
        height:height,
        decoration: BoxDecoration(
          color:backgroundColor,
          borderRadius: BorderRadius.circular(reduis)
        ),
        child: Text(text,style:GoogleFonts.leagueSpartan(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: colortext??Appcolors.textcolorwhite,
          letterSpacing:letterspacing,
          height: lineheight,
        )),
      ),
    );
  }
}
