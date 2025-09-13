import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/features/menu/data/models/CatgoryResonseModel.dart';
class ItemCtagory extends StatelessWidget {
  const ItemCtagory({super.key, required this.categories, required this.isSelected,});
  final Categories categories;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.only(right: 19.w),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.r),
              child: CachedNetworkImage(
                imageUrl: categories.imagePath!,
                width: 60.w,
                height: 80.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 60.w,
                    height: 80.h,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height:6.h),
            Text(categories.title!,style:GoogleFonts.leagueSpartan(
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
              color: isSelected?Appcolors.secondarycolor:Appcolors.textcolorblack,
            ) ),
          ],
        ),

    );
  }
}
