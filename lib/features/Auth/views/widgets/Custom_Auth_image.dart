import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/App_images.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';

class CustomAuthImage extends StatelessWidget {
  const CustomAuthImage({super.key, this.image = const AssetImage(AppImages.Presonoimageifnull)});
  final ImageProvider image;
  @override
  Widget build(BuildContext context) {
    return Stack(
        children:[
          Container(
            height: 60.h,
            width: 60.w,
            alignment: Alignment.bottomRight,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: image)
            ),
            child: Container(
              alignment: Alignment.center,
              width: 30.w,
              height: 30.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: Appcolors.secondarycolor,
              ),
              child: CustomSvg(path:AppIcons.CameraIcon),
            ),
          ),

        ]
    );
  }
}
