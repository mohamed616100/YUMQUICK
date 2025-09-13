import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:yumquick/core/network/api_helper.dart';
import 'package:yumquick/core/network/api_response.dart';
import 'package:yumquick/core/network/end_points.dart';
import 'package:yumquick/features/profile/data/models/Update_response.dart';

class UpdateProfileRepo {
  final ApiHelper _apiHelper = ApiHelper();

  Future<Either<String, UpdateResponse>> updateProfile({
    required String name,
    required String phone,
    XFile? image,
  }) async {
    try {
      final Map<String, dynamic> data = {
        "name": name,
        "phone": phone,
      };

      if (image != null) {
        data["image"] = await MultipartFile.fromFile(
          image.path,
          filename: image.name,
        );
      }

      ApiResponse response = await _apiHelper.putRequest(
        endPoint: EndPoints.UpdateProfile,
        data: data,
        isProtected: true,
        isFormData: true,
      );

      if (response.status) {
        if (response.data is Map<String, dynamic>) {
          final UpdateResponse result =
          UpdateResponse.fromJson(response.data as Map<String, dynamic>);
          return Right(result);
        } else {
          return Left("Unexpected response format");
        }
      } else {
        return Left(response.message);
      }
    } catch (e) {
      if (e is DioException) {
        return Left(ApiResponse.fromError(e).message);
      }
      return Left(e.toString());
    }
  }
}
