import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Custom_appbar.dart';
import 'package:yumquick/features/fav/views/widgets/listview_item_fav.dart';

class FavView extends StatelessWidget {
  const FavView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primarycolor,
      body: BaseBody(height:131.h,
        childcontiner:Padding(
          padding:EdgeInsets.only(top:20.h),
          child: Padding(
            padding:EdgeInsets.only(top: 20.h),
            child: CustomAppbar(
              title: 'My Fav',
              icon: AppIcons.BackiconArrow,
              onTap: () {
                MyNavigator.goBack(context);
              },
            ),
          ),
        ),
        body: Column(
          children: [
            ListviewItemFav()
          ],
        ),),
    );
  }
}
