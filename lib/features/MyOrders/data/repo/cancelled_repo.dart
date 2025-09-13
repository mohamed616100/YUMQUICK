import 'package:dartz/dartz.dart';
import 'package:yumquick/core/network/api_helper.dart';
import 'package:yumquick/core/network/api_response.dart';
import 'package:yumquick/core/network/end_points.dart';
import 'package:yumquick/features/MyOrders/data/models/Cancelleed_resopnse_model.dart';

class CancelledRepo {
  final ApiHelper apiHelper = ApiHelper();
  Future<Either<String,CanceldResopnse>> CancelOrder({
    required int id,
  }) async {
    try {
      final response = await apiHelper.postRequest(
        endPoint: EndPoints.CancelOrder(id: id),
        isFormData: false,
        isProtected: true,
      );
      if (response.status) {
        final canceled =CanceldResopnse.fromJson(
          response.data as Map<String, dynamic>,
        );
        return Right(canceled);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}
