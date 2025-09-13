import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/MyOrders/data/repo/order_response.dart';
import 'package:yumquick/features/MyOrders/manager/Order_state.dart';


class OrderCubit extends Cubit<OrderState> {
  OrderCubit() : super(OrderInitial());

  static OrderCubit get(context) => BlocProvider.of<OrderCubit>(context);

  final OrderRepo orderRepo = OrderRepo();

  Future<void> getOrders() async {
    emit(OrderLoading());
    var response = await orderRepo.getOredrs();
    response.fold(
          (error) => emit(OrderError(error)),
          (data) => emit(OrderSuccess(data)),
    );
  }
}
