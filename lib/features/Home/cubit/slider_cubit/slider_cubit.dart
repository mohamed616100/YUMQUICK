import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/Home/cubit/slider_cubit/slider_state.dart';
import 'package:yumquick/features/Home/data/repos/home_repo.dart';

class SeliderCubit extends Cubit<SliderState>{
  SeliderCubit():super(SliderInitial());
   static SeliderCubit get(context)=>BlocProvider.of(context);
  int currentIndex = 0;
  final CarouselSliderController controller = CarouselSliderController();
  getSlider()async{
    HomeRepo homeRepo=HomeRepo();
    emit(SliderLoading());
    var response =await homeRepo.getslider();
    response.fold((error) {
      emit(SliderError(error: error));
    }, (data) {
      emit(SliderSuccess(data: data));
    });
  }

  void onPageChanged(index,reason) {
    currentIndex = index;
  }

}