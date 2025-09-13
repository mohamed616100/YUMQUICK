import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';
import 'package:yumquick/features/CartPage/views/cart_page_view.dart';
import 'package:yumquick/features/search/views/Search_view.dart';

class CoustomSerachWidget extends StatelessWidget {
  const CoustomSerachWidget({super.key,});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.Appbarhorizontalsymatric,
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: (){
                MyNavigator.goTo(context, SearchView(),type: NavigatorType.push);              },
              child: SizedBox(
                width: 282.w,
                height: 26.h,
                child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.symmetric(horizontal: 10.0.w),
                  decoration: BoxDecoration(
                    color: Appcolors.textcolorwhite,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    'Search',style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  ),
                )
              ),
            ),
          ),

          SizedBox(width: 8.0.w),
          GestureDetector(
            onTap: (){
              MyNavigator.goTo(context, CartPage(),type: NavigatorType.push);
            },
            child: Container(
                width: 26.w,
                height: 26.h,
                padding: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Appcolors.textcolorwhite,
                  borderRadius: BorderRadius.circular(10.r),
                ),
                child:
                CustomSvg(path: AppIcons.shopingicon,width: 16.h,height: 16.w)
            ),
          ),
        ],
      ),
    );
  }
}
