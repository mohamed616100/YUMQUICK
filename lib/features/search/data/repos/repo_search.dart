import 'package:dartz/dartz.dart';
import 'package:yumquick/core/network/api_helper.dart';
import 'package:yumquick/core/network/api_response.dart';
import 'package:yumquick/core/network/end_points.dart';
import 'package:yumquick/features/Home/data/models/Top_Rated_Product.dart';


class SearchRepo{
  ApiHelper apiHelper = ApiHelper();
  Future<Either<String, List<Products>>> search({
    required String q,
  }) async {
    try {
      var response = await apiHelper.getRequest(
        endPoint: EndPoints.search(q: q),
        isProtected: true,
      );
      if (response.status) {
        final TopRatedProduct topRatedProduct
        = TopRatedProduct.fromJson(response.data as Map<String, dynamic>);

        return Right(topRatedProduct.products!);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      print(e);
      return Left(ApiResponse.fromError(e).message);
    }
  }
}