import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shimmer/shimmer.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';
class FavItem extends StatelessWidget {
  const FavItem({super.key, required this.product});
  final Map<String, dynamic> product;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: AppPaddings.Appbarhorizontalsymatric,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius:BorderRadius.circular(36.r),
            child: CachedNetworkImage(
              imageUrl: product['imagePath'] ?? '',
              width: 325.w,
              height: 174.h,
              fit: BoxFit.cover,
              placeholder: (context, url) => Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  width: 325.w,
                  height: 174.h,
                  color: Colors.white,
                ),
              ),
              errorWidget: (context, url, error) => Icon(Icons.broken_image),
            ),
          ),

          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      product['name'] ?? 'No Title'
                      ,style: GoogleFonts.leagueSpartan(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.brown[800],
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      width: 34.w,
                      height: 14.h,
                      decoration: BoxDecoration(
                        color: Appcolors.secondarycolor,
                        borderRadius: BorderRadius.circular(30.r),
                      ),child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            product['rating'].toString(),
                            style: GoogleFonts.leagueSpartan(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                              color: Colors.white,
                            )
                        ),
                        SizedBox(width: 3.w,),
                        CustomSvg(path: AppIcons.staricon)
                      ],
                    ),
                    ),
                    Text(
                      "\$${product['price']}",
                      style: GoogleFonts.leagueSpartan(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color:Appcolors.secondarycolor,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 4.h),
                Text(
                  product['description'] ?? 'No Description',
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[600],
                  ),
                ),
                SizedBox(height: 8.h),

              ],
            ),
          )
        ],
      ),
    );
  }
}
