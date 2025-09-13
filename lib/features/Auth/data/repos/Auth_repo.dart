import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:yumquick/core/network/api_helper.dart';
import 'package:yumquick/core/network/api_response.dart';
import 'package:yumquick/core/network/end_points.dart';
import 'package:yumquick/features/Auth/data/models/login_response_model.dart';
class AuthRepo {
  ApiHelper apiHelper = ApiHelper();

  Future<Either<String, LoginResponseModel>> login({
    required String email,
    required String password,
  }) async {
    try {
      var response = await apiHelper.postRequest(
        endPoint: EndPoints.login,
        data: {
          'email': email,
          'password': password,
        },
      );
      print("🔹 Login Response Data: ${response.data}");
      if (response.status) {
        final loginResponseModel =
        LoginResponseModel.fromJson(response.data as Map<String, dynamic>);

        final sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString(
            'access_token', loginResponseModel.accessToken ?? '');
        await sharedPreferences.setString(
            'refresh_token', loginResponseModel.refreshToken ?? '');


        return Right(loginResponseModel);
      } else {
        return Left(response.message);
      }
    } catch (e) {
      print(e);
      return Left(ApiResponse.fromError(e).message);
    }
  }

  Future<Either<String,String>> register({
    required String phone,
    required String name,
    required String email,
    required String password,
    XFile? image
  }) async
  {
    try {
      final Map<String, dynamic> data = {
        'name': name,
        'email': email,
        'password': password,
        'phone': phone,

      };

      // If image exists, attach as file
      if (image != null) {
        data['image'] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }
      var response = await apiHelper.postRequest(
          endPoint: EndPoints.register,
          data: data
      );
      if (response.status) {
        return right(response.message);
      }
      else {
        return left(response.message);
      }
    }
    catch (e) {
      print(e);
      return Left(ApiResponse
          .fromError(e)
          .message);
    }
  }
}