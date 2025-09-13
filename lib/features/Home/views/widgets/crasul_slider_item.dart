import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/custom_svg.dart';
import 'package:yumquick/features/Home/data/models/slider_response_model.dart';
class CrasulSliderItem extends StatelessWidget {
  const CrasulSliderItem({super.key,
    required this.slider,
    required this.activeIndex,
    required this.count
  });
  final Sliders slider;
  final int activeIndex;
  final int count;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPaddings.Appbarhorizontalsymatric,
      child: Container(
        height: 138.h,
        width: 323.w,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Stack(
            children:[
              Row(
                children: [
                  Container(
                    height: 128.h,
                    width: 161.5.w,
                    decoration: BoxDecoration(
                      color: Appcolors.secondarycolor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(20.r),
                        bottomLeft: Radius.circular(20.r),),
                    ),
                    child: Padding(
                      padding:EdgeInsets.symmetric(horizontal: 17.w,vertical: 18.h),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(slider.title??'No Offer',style: GoogleFonts.leagueSpartan(
                              fontWeight: FontWeight.w400,
                              fontSize: 16.sp,
                              color: Appcolors.textcolorwhite
                          ),),
                          Flexible(
                            child: Text(
                              slider.description ?? '0%',
                              style: GoogleFonts.leagueSpartan(
                                fontWeight: FontWeight.bold,
                                fontSize: 28.sp,
                                color: Appcolors.textcolorwhite,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 128.h,
                    width: 161.5.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20.r),
                        bottomRight: Radius.circular(20.r),
                      ),
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: CachedNetworkImageProvider(
                          slider.imagePath ?? '',
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Positioned(
                  top: 0.h,
                  left: 117.w,
                  child: CustomSvg(path: AppIcons.Ellipsehight,
                  )),
             Positioned(
                bottom: 10.h,
                  child: CustomSvg(path: AppIcons.Ellipsebottom,
                  )),
              Align(
                alignment: Alignment.bottomCenter,
                  child: AnimatedSmoothIndicator(
                    activeIndex:activeIndex,
                    count: count,
                    effect: WormEffect(
                      activeDotColor:Appcolors.secondarycolor,
                      dotColor: Appcolors.Yellow2,
                      dotHeight: 4.h,
                      dotWidth: 20.w,
                      spacing: 4.w,
                      radius: 12.r,
                    ),
                  ),
              )
            ]
        ),
      ),
    );
  }
}
