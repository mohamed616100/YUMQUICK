import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_style.dart';
import 'package:yumquick/core/utils/app_paddings.dart';

class CustomTextformfaild extends StatelessWidget {
  CustomTextformfaild({super.key,
    required this.obscureText,
    required this.keyboardType,
    this.suffixIcon,
    this.controller,
    this.validator,
    required this.hintText,
    this.maxLines,
    this.OnTap,
    required this.labeltext,
    this.initialValue,
  });
  final String? initialValue;
  final String labeltext;
  final bool obscureText;
  final TextInputType keyboardType;
  Widget ?suffixIcon;
  TextEditingController? controller;
  String? Function(String?)? validator;
  final String hintText;
  final int? maxLines;
  void Function()? OnTap;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.Appbarhorizontalsymatric,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(labeltext,style:AppStyle.LabelTextStyle),
          SizedBox(height: 6.h,),
          SizedBox(
            height:45.h,
            width: 322.w,
            child: TextFormField(
              style: AppStyle.LabelTextStyle.copyWith(
                fontWeight: FontWeight.w400,
              ),
              onTap: OnTap,
              validator: validator,
              initialValue:initialValue,
              controller: controller,
              keyboardType: keyboardType,
              obscureText: obscureText,
              obscuringCharacter: "*",
              maxLines: maxLines,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 16),
                  hintText: hintText,
                fillColor: Appcolors.Yellow2,
                filled: true,
                suffixIcon: suffixIcon,
                alignLabelWithHint: true,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.r),
                    borderSide: BorderSide(
                        color: Color(0xffE9F6FE),
                        width: 1.w
                    )
                ) ,
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.r),
                    borderSide: BorderSide(
                        color: Appcolors.primarycolor,
                        width: 1.w
                    )
                ),
                errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(13.r),
                    borderSide: BorderSide(
                        color: Colors.red,
                        width: 1.w
                    )
                )
              ),
            ),
          ),
        ],
      ),
    );
  }
}
