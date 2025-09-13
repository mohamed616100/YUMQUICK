
import 'package:yumquick/features/confirm_checkout/data/model/place_order_response.dart';

abstract class PlaceOrderState{}

class PlaceOrderInitial extends PlaceOrderState {}

class PlaceOrderLoading extends PlaceOrderState {}

class PlaceOrderSuccess extends PlaceOrderState {
  final PlaceOrderResponse response;

  PlaceOrderSuccess(this.response);
}
class PlaceOrderFailure extends PlaceOrderState {
  final String message;
  PlaceOrderFailure(this.message);
}
