import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/core/utils/App_style.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';


class CustomAppbar extends StatelessWidget {
  const CustomAppbar({
    super.key,
    required this.title,
    required this.icon,
    this.onTap, this.addimage, this.iconButton,
  });
   final Widget? addimage;
  final String title;
  final String icon;
  final void Function()? onTap;
  final IconButton? iconButton;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              padding: AppPaddings.Appbarhorizontalsymatric,
              onPressed: onTap,
              icon: CustomSvg(
                path: icon,
                width: 8.w,
                height: 13.h,
              ),
            ),
          ),
          Align(
              alignment: Alignment.bottomCenter,
              child:addimage),
          Align(
            alignment: Alignment.center,
            child: Text(
              title,
              style: AppStyle.AppbarTextStyle,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: iconButton
          ),
        ],
      ),
    );
  }
}
