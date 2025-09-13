import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_images.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/features/Home/cubit/user_cubit/user_cubit.dart';
import 'package:yumquick/features/Home/cubit/user_cubit/user_state.dart';
import 'package:yumquick/features/order/views/widgets/shimmer_appbar.dart';


class CustomAppbarOder extends StatelessWidget {
  const CustomAppbarOder({super.key,});
  ImageProvider _buildImageProvider(String? path) {
    if (path == null || path.isEmpty) {
      return AssetImage(AppImages.Presonoimageifnull);
    } else if (path.startsWith("http")) {
      return NetworkImage(path);
    } else {
      return FileImage(File(path));
    }
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit,UserState>(
      builder: (context, state) {
        if (state is UserLoading){
          return ShimmerAppbar();
        }else if(state is UserError){
          return Center(child: Text(state.error));
        }else if(state is UserSuccess){
          return Padding(
            padding: AppPaddings.Appbarhorizontalsymatric,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 40.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        width: 50.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: _buildImageProvider(state.user.imagePath)),
                            shape: BoxShape.circle
                        ),
                      ),
                    ),
                    SizedBox(width: 23.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(state.user.name??'John Smith', style: GoogleFonts.leagueSpartan(
                            fontSize: 33.sp,
                            fontWeight: FontWeight.w500,
                            color: Appcolors.textcolorwhite
                        ),),
                        Text(state.user.email??'Loremipsum@email.com',
                          style: GoogleFonts.leagueSpartan(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                          ),)
                      ],
                    )
                  ],
                ),
              ],
            ),
          );
        }else{
          return Container();
        }
      },
    );
  }
}
