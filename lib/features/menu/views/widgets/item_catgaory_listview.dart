import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:shimmer/shimmer.dart';
import 'package:yumquick/core/utils/app_paddings.dart';
import 'package:yumquick/features/menu/cubit_Ctagory/catgory_cubit.dart';
import 'package:yumquick/features/menu/cubit_Ctagory/catgory_state.dart';
import 'package:yumquick/features/menu/cubit_Ctagory/pro_cubit/cubit.dart';
import 'package:yumquick/features/menu/views/widgets/item_ctagory.dart';
class ItemCatgaoryListview extends StatefulWidget {
  const ItemCatgaoryListview({super.key});

  @override
  State<ItemCatgaoryListview> createState() => _ItemCatgaoryListviewState();
}

class _ItemCatgaoryListviewState extends State<ItemCatgaoryListview> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CatgoryCubit, CatgoryState>(
      builder: (context, state) {
        if(state is CatgoryLoading){
          return SizedBox(
            height: 109.h,
            child: ListView.separated(
              itemCount: 5,
              scrollDirection: Axis.horizontal,
              padding: AppPaddings.Appbarhorizontalonlyleft,
              separatorBuilder: (context, index) => SizedBox(width: 10.w),
              itemBuilder: (context, index) {
                return Shimmer.fromColors(
                  baseColor: Colors.grey[300]!,
                  highlightColor: Colors.grey[100]!,
                  child: Container(
                    width: 80.w,
                    height: 100.h,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                );
              },
            ),
          );
        }else if(state is CatgoryError){
          return Center(child: Text(state.error));
        }else if(state is CatgorySuccess){
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (selectedIndex == 0) {
              context.read<ProductCubit>().loadProducts(state.data[0].products!);
            }
          });
          return SizedBox(
            height: 109.h,
            child: ListView.builder(itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                  final selectedCategory = state.data[index];
                  context.read<ProductCubit>().loadProducts(selectedCategory.products!);
                },
                child: ItemCtagory(
                  isSelected:selectedIndex == index,
                  categories: state.data[index],
                ),
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
