import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/Home/cubit/top_rated_cubit/top_rated_state.dart';
import 'package:yumquick/features/Home/data/repos/home_repo.dart';

class TopRatedCubit extends Cubit<TopRatedState>{
  TopRatedCubit():super(TopRatedInitial());
  static TopRatedCubit get(context)=>BlocProvider.of(context);
  getToRated()async{
    HomeRepo homeRepo=HomeRepo();
    emit(TopRatedLoading());
    var response =await homeRepo.getTopRated();
    response.fold((error) {
      emit(TopRatedError(error: error));
    }, (data) {
      emit(TopRatedSuccess(data: data));
    });
  }
}
