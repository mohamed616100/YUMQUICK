import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';
import 'package:yumquick/features/best_seller_alll/views/bestseller_All_view.dart';
class ViewAll extends StatelessWidget {
  const ViewAll({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:AppPaddings.Appbarhorizontalsymatric,
      child: Row(
        children: [
          Text('Best Seller',style: GoogleFonts.leagueSpartan(
              fontSize: 20.sp,
              fontWeight: FontWeight.w500
          ),),
          Spacer(),
          GestureDetector(
            onTap: (){
              MyNavigator.goTo(context, BestsellerAllView(

              ),type: NavigatorType.push);
            },
            child: Row(
              children: [
                Text('View All',style: GoogleFonts.leagueSpartan(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: Appcolors.secondarycolor
                ),),
                SizedBox(width: 10.w,),
                CustomSvg(path: AppIcons.Arrowfrowerdicon, width: 8.w, height: 13.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
