import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/features/Home/cubit/best_saller_cubit/best_seller_cubit.dart';
import 'package:yumquick/features/Home/cubit/best_saller_cubit/best_seller_state.dart';
import 'package:yumquick/features/Home/views/widgets/best_seller_item.dart';
import 'package:yumquick/features/Home/views/widgets/shimmers/best_seller_shimmer.dart';

class BestSellerListview extends StatelessWidget {
  const BestSellerListview({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BestSellerCubit, BestSellerState>(
      builder: (context, state) {
        if (state is BestSellerLoading) {
          return BestSellerShimmer();
        }else if (state is BestSellerError){
          return Center(child: Text(state.error));
        }else if (state is BestSellerSuccess){
          return  SizedBox(
            height: 108.h,
            child: ListView.builder(itemBuilder: (context, index) {
              return BestSellerItem(
                bestSellerProducts: state.data[index],
              );
            }, itemCount: state.data.length,
              scrollDirection: Axis.horizontal,
              padding: AppPaddings.Appbarhorizontalonlyleft,
            ),
          );
        }else{
          return Container();
        }
      },
    );
  }
}
