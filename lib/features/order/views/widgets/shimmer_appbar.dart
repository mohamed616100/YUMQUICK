import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
class ShimmerAppbar extends StatelessWidget {
  const ShimmerAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.Appbarhorizontalsymatric,
      child: Column(
        children: [
          SizedBox(height: 40.h),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // profile picture placeholder
              Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 50.w,
                  height: 50.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              SizedBox(width: 23.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name placeholder
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 120.w,
                      height: 20.h,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  // email placeholder
                  Shimmer.fromColors(
                    baseColor: Colors.grey[300]!,
                    highlightColor: Colors.grey[100]!,
                    child: Container(
                      width: 180.w,
                      height: 16.h,
                      color: Colors.white,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }
}
