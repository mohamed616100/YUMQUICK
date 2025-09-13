import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yumquick/features/Home/cubit/slider_cubit/slider_cubit.dart';
import 'package:yumquick/features/Home/cubit/slider_cubit/slider_state.dart';
import 'package:yumquick/features/Home/views/widgets/crasul_slider_item.dart';
import 'package:yumquick/features/Home/views/widgets/shimmers/Carsol_shimmer.dart';
class CarsulSliderWidget extends StatelessWidget {
  const CarsulSliderWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SeliderCubit,SliderState>(
  builder: (context, state) {
    if (state is SliderLoading) {
      return CarsolShimmer();
    }
    else if(state is SliderSuccess){
      final cubit= SeliderCubit.get(context);
      return CarouselSlider.builder(
        carouselController:cubit.controller,
        itemCount: state.data.length,
        itemBuilder: (context, index, realIndex) {
          return CrasulSliderItem(
            slider: state.data[index],
            activeIndex: index,
            count: state.data.length,
          );
        },
        options:CarouselOptions(
          height: 138.h,
          autoPlay: true,
          viewportFraction: 1.0,
          enlargeCenterPage: false,
          onPageChanged:cubit.onPageChanged,
        ),
      );
    }else if(state is SliderError){
      return SizedBox(
          height: 128.h,
          child: Center(child: Text(state.error),));
    }else{
      return Container();
    }
  },
);
  }
}
