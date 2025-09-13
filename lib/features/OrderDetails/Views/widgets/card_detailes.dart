import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/features/MyOrders/data/models/OrderResponse.dart';

class CardDetailes extends StatelessWidget {
  const CardDetailes({super.key, required this.detiles});
  final Items detiles;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Divider(
          color: Appcolors.secondarycolor,
          thickness: 1,
        ),
        SizedBox(height: 10.h,),
        Row(
          children: [
            Container(
              height: 80.h,
              width: 80.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(detiles.imagePath ?? ''),
                ),
              ),
            ),
            SizedBox(width: 15.w,),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(detiles.name!,style: GoogleFonts.leagueSpartan(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),),
                SizedBox(width: 20.w,),
                Text('\$${detiles.price}',style: GoogleFonts.leagueSpartan(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Appcolors.secondarycolor,

                ),),
                SizedBox(height: 10.h,),
                Text(detiles.quantity.toString(),style: GoogleFonts.leagueSpartan(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),)
              ],
            ),
          ],
        ),
        SizedBox(height: 10.h,),
        Divider(
          color: Appcolors.secondarycolor,
          thickness: 1,
        ),
        SizedBox(height: 30.h,),
      ],
    );
  }
}
