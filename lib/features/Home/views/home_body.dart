 import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Coustom_serach_widget.dart';
import 'package:yumquick/features/Auth/data/models/login_response_model.dart';
import 'package:yumquick/features/Home/views/widgets/Recommend_listview.dart';
import 'package:yumquick/features/Home/views/widgets/best_seller_listview.dart';
import 'package:yumquick/features/Home/views/widgets/carsul_slider_Widget.dart';
import 'package:yumquick/features/Home/views/widgets/view_all.dart';

class HomeBody extends StatelessWidget {
  const HomeBody({super.key, this.datauser});
  final UserModel? datauser;
  @override
  Widget build(BuildContext context) {
    return BaseBody(
      height: 161.h,
      childcontiner: SafeArea(
        bottom: false,
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(child: SizedBox(height: 15.h)),
            SliverToBoxAdapter(child: CoustomSerachWidget()),
            SliverToBoxAdapter(child: SizedBox(height: 12.h)),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppPaddings.Appbarhorizontalonlyleft,
                child: Text(
                  'Good Morning',
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                    color: Appcolors.textcolorwhite,
                  ),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: AppPaddings.Appbarhorizontalonlyleft,
                child: Text(
                  'Rise and shine! Its breakfast time',
                  style: GoogleFonts.leagueSpartan(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w500,
                    color: Appcolors.secondarycolor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 34.h),
        child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: ViewAll()),
              SliverToBoxAdapter(child: SizedBox(height: 14.h,)),
              SliverToBoxAdapter(child: BestSellerListview()),
              SliverToBoxAdapter(child: SizedBox(height: 20.h,)),
              SliverToBoxAdapter(child: CarsulSliderWidget()),
              SliverToBoxAdapter(child: SizedBox(height: 20.h,)),
              SliverToBoxAdapter(
                child: Padding(
                  padding:AppPaddings.Appbarhorizontalsymatric,
                  child: Text('Recommend',style: GoogleFonts.leagueSpartan(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w500,
                  ),),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 14.h,)),
              RecommendListview(),


            ]
        ),
      ),
    );
  }
}