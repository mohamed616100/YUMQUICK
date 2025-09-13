import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:shimmer/shimmer.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/features/Home/data/models/best_seller_model.dart';
import 'package:yumquick/features/item/views/item_view.dart';
class BestSellerItem extends StatelessWidget {
  const BestSellerItem({super.key, required this.bestSellerProducts});
  final BestSellerProducts bestSellerProducts;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:EdgeInsets.symmetric(horizontal: 11.w,),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(19.r),
        child: GestureDetector(
          onTap: (){
            MyNavigator.goTo(context, ItemView(
              bestSellerProducts: bestSellerProducts,
            ),type: NavigatorType.push);
          },
          child: Stack(
            children: [
              CachedNetworkImage(
                imageUrl: bestSellerProducts.imagePath!,
                width: 71.68.w,
                height: 108.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 71.68.w,
                    height: 108.h,
                    color: Colors.white,
                  ),
                ),
                errorWidget: (context, url, error) => Icon(Icons.broken_image),
              ),
              Positioned(
                bottom: 12.h,
                right: 0.w,
                child: Container(
                  padding:EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: Appcolors.secondarycolor,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    "\$${bestSellerProducts.price}",
                    style: GoogleFonts.leagueSpartan(
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
