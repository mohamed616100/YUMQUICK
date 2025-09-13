import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Custom_appbar.dart';
import 'package:yumquick/features/best_seller_alll/views/widgets/best_seller_grad_view.dart';
class BestsellerAllView extends StatelessWidget {
  const BestsellerAllView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolors.primarycolor,
      body: BaseBody(
          height:131.h,
          childcontiner: CustomAppbar(
            title: "Best Seller",
            icon: AppIcons.BackiconArrow,
            onTap: () => MyNavigator.goBack(context),
          ),
        body:  Column(
          children: [
           BestSellerGradView(),

          ],
        )
      ),
    );
  }
}
