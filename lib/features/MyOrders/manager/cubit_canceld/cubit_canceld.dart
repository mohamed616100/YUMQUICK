import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/MyOrders/data/repo/cancelled_repo.dart';
import 'package:yumquick/features/MyOrders/manager/cubit_canceld/canceld_state.dart';

class CanceldCubit extends Cubit<CanceldState>{
  CanceldCubit() : super(CanceldInitial());
  static CanceldCubit get(context) => BlocProvider.of(context);
  CancelledRepo cancelledRepo = CancelledRepo();
  Future<void> CaneldOrder({
    required int id,
}) async {
    emit(CanceldLoading());
    var response = await cancelledRepo.CancelOrder(id: id);
    response.fold(
          (error) => emit(CanceldError(error)),
          (data) => emit(CanceldSuccess(data)),
    );
  }
}