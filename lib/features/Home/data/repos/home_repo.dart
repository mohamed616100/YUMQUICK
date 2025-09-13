import 'package:dartz/dartz.dart';
import 'package:yumquick/core/network/api_helper.dart';
import 'package:yumquick/core/network/api_response.dart';
import 'package:yumquick/core/network/end_points.dart';
import 'package:yumquick/features/Auth/data/models/login_response_model.dart';
import 'package:yumquick/features/Home/data/models/Top_Rated_Product.dart';
import 'package:yumquick/features/Home/data/models/best_seller_model.dart';
import 'package:yumquick/features/Home/data/models/slider_response_model.dart';

class HomeRepo {
  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, UserModel>> getUser() async
  {
    try {
      var response = await apiHelper.getRequest(
          endPoint: EndPoints.getUserData,
          isProtected: true
      );
      if (response.status) {
        var data = response.data as Map<String, dynamic>;
        LoginResponseModel responseModel =
        LoginResponseModel.fromJson(data);
        return right(responseModel.user!);
      }
      else {
        return Left(response.message);
      }
    }
    catch (e) {
      return Left(e.toString());
    }
  }
  Future<Either<String, List<BestSellerProducts>>> getBestSeller() async
  {
    try
    {
      var response = await apiHelper.getRequest(
          endPoint: EndPoints.bestSeller,
          isProtected: true
      );
      if(response.status)
      {
        bestseller bestSeller= bestseller.fromJson(response.data as Map<String, dynamic>);
        return Right(bestSeller.bestSellerProducts!);
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


  Future<Either<String, List<Sliders>>> getslider() async
  {
    try
    {
      var response = await apiHelper.getRequest(
          endPoint: EndPoints.slider,
          isProtected: false
      );
      if(response.status)
      {
        SliderResponse slider= SliderResponse.fromJson(response.data as Map<String, dynamic>);
        return Right(slider.sliders!);
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

  Future<Either<String, List<Products>>> getTopRated() async
  {
    try
    {
      var response = await apiHelper.getRequest(
          endPoint: EndPoints.topRated,
          isProtected: true
      );
      if(response.status)
      {
        TopRatedProduct topRatedProduct= TopRatedProduct.fromJson(response.data as Map<String, dynamic>);
        return Right(topRatedProduct.products!);
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
