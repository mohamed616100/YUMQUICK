import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
class BestSellerShimmer extends StatelessWidget {
  const BestSellerShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return  Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: SizedBox(
        height: 108.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: AppPaddings.Appbarhorizontalonlyleft,
          itemCount: 10,
          itemBuilder: (context, index) {
            return Container(
              margin: EdgeInsets.only(right: 12.w),
              width: 120.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
              ),
            );
          },
        ),
      ),
    );
  }
}
