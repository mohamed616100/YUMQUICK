import 'package:dartz/dartz.dart';
import 'package:restaurant/core/network/api_helper.dart';
import 'package:restaurant/core/network/api_response.dart';
import 'package:restaurant/core/network/end_points.dart';
import 'package:restaurant/features/order/data/model_response_logout.dart';

class LogoutRepository {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Either<String,responslogout>> logout() async {
    try {
      ApiResponse response = await _apiHelper.deleteRequest(
        endPoint: EndPoints.logout,
        isProtected: true,
      );

      if (response.status) {
        final responslogout result = responslogout.fromJson(response.data);
        return Right(result);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      return Left(e.toString());
    }
  }
}
