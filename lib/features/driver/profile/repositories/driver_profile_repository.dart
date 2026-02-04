import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/services/errors/exceptions.dart';
import 'package:go_car/features/driver/authentication/sign_up/functions/upload_image_to_api.dart';
import 'package:go_car/features/driver/profile/models/driver_model.dart';
import 'package:image_picker/image_picker.dart';

class DriverProfileRepository {
  final ApiConsumer Api;

  DriverProfileRepository({required this.Api});

  Future<Either<String, DriverModel>> getDriverProfile() async {
    try {
      final response = await Api.get(
        EndPoint.getDriver(CacheHelper().getData(key: ApiKeys.id)),
      );

      return right(DriverModel.fromJson(response['data']));
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverModel>> getDriverTrips() async {
    try {
      final response = await Api.get(
        EndPoint.getDriverTrips(CacheHelper().getData(key: ApiKeys.id)),
      );

      return right(DriverModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverModel>> deleteDriver() async {
    try {
      final response = await Api.delete(
        EndPoint.deleteDriver(CacheHelper().getData(key: ApiKeys.id)),
      );

      return right(DriverModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  // profile pic change

  Future<Either<String, DriverModel>> setProfilePic({
    required XFile profilepic,
  }) async {
    try {
      final token = CacheHelper.sharedPreferences.get(ApiKeys.token);
      if (token == null) return left("Authorization token is missing.");

      // Prepare multipart/form-data
      final multipartFile = await UploadImageToApi(profilepic);
      final formData = FormData.fromMap({ApiKeys.profilePhoto: multipartFile});

      final response = await Api.post(
        EndPoint.uploadImage, // matches your Postman endpoint
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      // Notice: response["data"] contains the driver object
      return right(DriverModel.fromJson(response["data"]));
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left(e.toString());
    }
  }

  // update driver data

  Future<Either<String, DriverModel>> driverUpdate({
    String? name,
    String? phoneNumber,
    String? password,
  }) async {
    try {
      final driverId = CacheHelper().getData(key: ApiKeys.id);
      final token = CacheHelper().getData(key: ApiKeys.token);

      print('Driver ID: $driverId, Token: $token');

      final response = await Api.patch(
        EndPoint.driverUpdate(driverId),
        data: {
          if (name != null) ApiKeys.name: name,
          if (phoneNumber != null) ApiKeys.phoneNumber: phoneNumber,

          if (password != null) ApiKeys.password: password,
        },
        // options: Options(headers: {'Authorization': 'Bearer ${ApiKeys.token}'}),
      );

      return right(DriverModel.fromJson(response["data"]));
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }
}
