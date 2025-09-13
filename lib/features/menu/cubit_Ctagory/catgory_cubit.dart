 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/menu/cubit_Ctagory/catgory_state.dart';
import 'package:yumquick/features/menu/data/repos/catgory_repo.dart';

class CatgoryCubit extends Cubit<CatgoryState> {
  CatgoryCubit() : super(CatgoryInitial());
  static CatgoryCubit get(context) => BlocProvider.of(context);
  CatgoryRepo catgoryRepo = CatgoryRepo();
  Future<void> getCatgory() async {
    emit(CatgoryLoading());
    var result = await catgoryRepo.getCatgory();
    result.fold((failure) {
      emit(CatgoryError(error: failure));
    }, (data) {
      emit(CatgorySuccess(data: data));
    });
  }
}