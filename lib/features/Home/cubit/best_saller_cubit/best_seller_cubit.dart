import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/Home/cubit/best_saller_cubit/best_seller_state.dart';
import 'package:yumquick/features/Home/data/repos/home_repo.dart';


class BestSellerCubit extends Cubit<BestSellerState>{
  BestSellerCubit():super(BestSellerInitial());
  static BestSellerCubit get(context)=>BlocProvider.of(context);

  getBestSeller()async{
    HomeRepo homeRepo=HomeRepo();
    emit(BestSellerLoading());
    var response =await homeRepo.getBestSeller();
    response.fold((error) {
      emit(BestSellerError(error: error));
    }, (data) {
      emit(BestSellerSuccess(data: data));
    });
  }

}

