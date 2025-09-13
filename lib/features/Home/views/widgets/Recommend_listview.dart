import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yumquick/features/Home/cubit/top_rated_cubit/top_rated_cubit.dart';
import 'package:yumquick/features/Home/cubit/top_rated_cubit/top_rated_state.dart';
import 'package:yumquick/features/Home/views/widgets/Recommecd_item.dart';

class RecommendListview extends StatelessWidget {
  const RecommendListview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TopRatedCubit, TopRatedState>(
      builder: (context, state) {
        if (state is TopRatedLoading) {
          return SliverList.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                child: Row(
                  children: [
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 180.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 7.w),
                    Expanded(
                      child: Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: Container(
                          height: 180.h,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: 2,
          );
        } else if (state is TopRatedError) {
          return SliverToBoxAdapter(child: Center(child: Text(state.error)));
        } else if (state is TopRatedSuccess) {
          final items = state.data;
          final itemCount = items.length;

          if (itemCount == 0) {
            return SliverToBoxAdapter(
                child: Center(child: Text('No items found')));
          }

          final rowCount = (itemCount / 2).ceil();

          return SliverList.builder(
            itemBuilder: (context, index) {
              final firstItemIndex = index * 2;
              final secondItemIndex = index * 2 + 1;
              final hasSecondItem = secondItemIndex < itemCount;

              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 5.h),
                child: Row(
                  children: [
                    Expanded(
                      child: RecommecdItem(data: items[firstItemIndex]),
                    ),
                    SizedBox(width: 7.w),
                    hasSecondItem
                        ? Expanded(
                      child: RecommecdItem(data: items[secondItemIndex]),
                    )
                        : Expanded(child: SizedBox()),
                  ],
                ),
              );
            },
            itemCount: rowCount,
          );
        } else {
          return SliverToBoxAdapter(child: Container());
        }
      },
    );
  }
}
