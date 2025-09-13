
import 'package:dartz/dartz.dart';
import 'package:yumquick/core/network/api_helper.dart';
import 'package:yumquick/core/network/api_response.dart';
import 'package:yumquick/core/network/end_points.dart';
import 'package:yumquick/features/confirm_checkout/data/model/place_order_response.dart';

class OrderRepo {
  Future<Either<String, PlaceOrderResponse>>placeOrder({
    required List<Map<String, dynamic>> items,
  }) async {
    try {
      ApiHelper apiHelper = ApiHelper();
      final response = await apiHelper.postRequest(
        endPoint: EndPoints.PlaceOrder,
        isFormData: false,
        isProtected: true,
        data: {
          "items": items,
        },
      );

      if (response.status) {
        final orderResponse = PlaceOrderResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        return Right(orderResponse);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}
