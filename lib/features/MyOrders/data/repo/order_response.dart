import 'package:dartz/dartz.dart';
import 'package:yumquick/core/network/api_helper.dart';
import 'package:yumquick/core/network/api_response.dart';
import 'package:yumquick/core/network/end_points.dart';
import 'package:yumquick/features/MyOrders/data/models/OrderResponse.dart';

class OrderRepo{
  Future<Either<String, OrderResopnse>> getOredrs() async
  {
    try
    {
      var apiHelper = ApiHelper();
      var response = await apiHelper.getRequest(
          endPoint: EndPoints.Order,
          isProtected: true
      );
      if(response.status)
      {
        OrderResopnse orders= OrderResopnse.fromJson(response.data as Map<String, dynamic>);
        return Right(orders);
      }
      else
      {
        return Left(response.message);
      }
    }
    catch(e)
    {
      return Left(ApiResponse.fromError(e).message);
    }
  }

}