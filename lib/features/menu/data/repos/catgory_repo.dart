
import 'package:dartz/dartz.dart';
import 'package:yumquick/core/network/api_helper.dart';
import 'package:yumquick/core/network/api_response.dart';
import 'package:yumquick/core/network/end_points.dart';
import 'package:yumquick/features/menu/data/models/CatgoryResonseModel.dart';

class CatgoryRepo{
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, List<Categories>>> getCatgory() async {
    try {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.getMenu,
        isProtected: true,
      );
      if (response.status) {
        final CatgoryResponse catgoryResponse
        = CatgoryResponse.fromJson(response.data as Map<String, dynamic>);

        return Right(catgoryResponse.categories!);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      return Left(ApiResponse.fromError(e).message);
    }
  }
}