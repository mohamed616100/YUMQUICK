import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:yumquick/core/helper/my_navgetor.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/App_icons.dart';
import 'package:yumquick/core/utils/App_style.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Custom_appbar.dart';
import 'package:yumquick/features/Settings/manger/cubit.dart';
import 'package:yumquick/features/Settings/manger/state.dart';

class SettingsView extends StatelessWidget {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
  create: (context) => togellcubit(),
  child: Scaffold(
      backgroundColor: Appcolors.primarycolor,
      body: BaseBody(
        height: 129.h,
          childcontiner: Padding(
            padding:  EdgeInsets.only(top: 20.h),
            child: CustomAppbar(title: 'Settings',
                icon: AppIcons.BackiconArrow,onTap: (){
              MyNavigator.goBack(context);
              },),
          ),
            body: BlocBuilder<togellcubit, togellstate>(
  builder: (context, state) {
    return Column(
              children: [
            Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Language", style:GoogleFonts.leagueSpartan(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: Colors.brown[800],
            )),
            Row(
              children: [
                GestureDetector(
                  onTap: () => togellcubit.get(context).changeLanguage("AR"),
                  child: Container(
                    alignment: Alignment.center,
                    height: 36.h,
                    width: 51.w,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                      ),
                      color:  togellcubit.get(context).selectedLang == "AR"
                          ? Appcolors.secondarycolor
                          : Appcolors.primarycolor,
                    ),
                    child: Text(
                      "AR",
                      style: AppStyle.LabelTextStyle.copyWith(
                        color: togellcubit.get(context).selectedLang == "AR"
                            ? Appcolors.textcolorwhite
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => togellcubit.get(context).changeLanguage("EN"),
                  child: Container(
                    alignment: Alignment.center,
                    height: 36.h,
                    width: 51.w,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      color: togellcubit.get(context).selectedLang == "EN"
                          ? Appcolors.secondarycolor
                          : Appcolors.primarycolor,
                    ),
                    child: Text(
                      "EN",
                      style:AppStyle.LabelTextStyle.copyWith(
                        color: togellcubit.get(context).selectedLang == "EN"
                            ? Appcolors.primarycolor
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    ],
            );
  },
),
      ) ,
    ),
);
  }
}
