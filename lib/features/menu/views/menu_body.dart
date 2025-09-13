import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/core/utils/App_colors.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/core/widgets/Base_body.dart';
import 'package:yumquick/core/widgets/Coustom_serach_widget.dart';
import 'package:yumquick/features/menu/cubit_Ctagory/catgory_cubit.dart';
import 'package:yumquick/features/menu/cubit_Ctagory/pro_cubit/cubit.dart';
import 'package:yumquick/features/menu/views/widgets/item_catgaory_listview.dart';
import 'package:yumquick/features/menu/views/widgets/product_listview.dart';

class MenuBody extends StatelessWidget {
  const MenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
          CatgoryCubit()
            ..getCatgory(),
        ),
        BlocProvider(
          create: (context) => ProductCubit(),
        ),
      ],
      child: BaseBody(height: 116.h,
          childcontiner: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              CoustomSerachWidget()
            ],
          ),
          body: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(child: SizedBox(height: 30.h)),
              SliverToBoxAdapter(child: ItemCatgaoryListview()),
              SliverToBoxAdapter(child: SizedBox(height: 13.h)),
              SliverToBoxAdapter(
                child: Padding(
                  padding: AppPaddings.Appbarhorizontalsymatric,
                  child: Divider(
                    color: Appcolors.secondarycolor,
                    thickness: 1,
                    height: 18,
                  ),
                ),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 13.h)),
              ProductListview()


            ],
          )
      ),
    );
  }
}
