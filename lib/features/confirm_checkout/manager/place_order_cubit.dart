import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yumquick/features/confirm_checkout/data/repo/place_order_repo.dart';
import 'package:yumquick/features/confirm_checkout/manager/placeorderstate.dart';

class PlaceOrderCubit extends Cubit<PlaceOrderState> {
  PlaceOrderCubit() : super(PlaceOrderInitial());

  Future<void> placeOrder(List<Map<String, dynamic>> cartItems) async {
    OrderRepo orderRepo = OrderRepo();
    emit(PlaceOrderLoading());

    try {
      final items = cartItems.map((item) {
        return {
          "product_id": item['id'],
          "quantity": item['quantity'],
        };
      }).toList();

      final result = await orderRepo.placeOrder(items: items);

      result.fold(
            (error) => emit(PlaceOrderFailure(error)),
            (response) => emit(PlaceOrderSuccess(response)),
      );
    } catch (e) {
      emit(PlaceOrderFailure(e.toString()));
    }
  }
}
