
import 'package:yumquick/features/MyOrders/data/models/OrderResponse.dart';

abstract class OrderState{}
class OrderInitial extends OrderState{}
class OrderLoading extends OrderState{}
class OrderSuccess extends OrderState{
  final OrderResopnse order;
  OrderSuccess(this.order);
}
class OrderError extends OrderState{
  final String message;
  OrderError(this.message);

}