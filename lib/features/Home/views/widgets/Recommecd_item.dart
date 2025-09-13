import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';
import 'package:yumquick/features/Home/data/models/Top_Rated_Product.dart';
import 'package:yumquick/features/item/views/item_view.dart';

class RecommecdItem extends StatelessWidget {
  const RecommecdItem({super.key, required this.data});
  final Products data;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: GestureDetector(
        onTap: (){
          MyNavigator.goTo(context, ItemView(
            data: data,
          ));
        },
        child: Stack(
          children: [
            Container(
              width: 159.w,
              height: 140.h,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(data.imagePath??''))
              ),
            ),
            Positioned(
              bottom: 17.h,
              right: 0.w,
              child: Container(
                padding:EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: Appcolors.secondarycolor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  "\$${data.price}",
                  style: GoogleFonts.leagueSpartan(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ),
            Positioned(
                top: 10.h,
                left: 13.w,
                child:Container(
                  alignment: Alignment.center,
                  width: 34.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    color: Appcolors.textcolorwhite,
                    borderRadius: BorderRadius.circular(30.r),
                  ),child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        '${data.rating}',
                        style: GoogleFonts.leagueSpartan(
                          fontWeight: FontWeight.w400,
                          fontSize: 12.sp,
                        )
                    ),
                    SizedBox(width: 3.w,),
                    CustomSvg(path: AppIcons.staricon)
                  ],
                ),
                )
            ),
            Positioned(
                top: 10.h,
                left: 52.w,
                child: Container(
                  alignment: Alignment.center,
                  width: 14.w,
                  height: 14.h,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    color: Appcolors.textcolorwhite,
                  ),
                  child:CustomSvg(path: AppIcons.fevicon,),
                ))
          ],
        ),
      ),
    );
  }
}
