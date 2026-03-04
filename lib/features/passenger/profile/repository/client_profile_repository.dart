import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/services/errors/exceptions.dart';
import 'package:go_car/features/passenger/profile/model/client_model.dart';
import 'package:image_picker/image_picker.dart';

class ClientProfileRepository {
  final ApiConsumer Api;

  ClientProfileRepository({required this.Api});

  Future<Either<String, ClientModel>> getClientProfile() async {
    try {
      final id = CacheHelper().getData(key: ApiKeys.id);
      if (id == null) {
        return left("User not logged in");
      }
      final response = await Api.get(EndPoint.getClient(id));
      final data = response["data"];

      if (data == null) {
        return left("Profile data is empty");
      }

      final clientModel = ClientModel.fromJson(data);

      return right(clientModel);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  //   clientProfileUpdate

  Future<Either<String, ClientModel>> clientProfileUpdate({
    String? name,
    String? phoneNumber,
  }) async {
    try {
      final clientId = CacheHelper().getData(key: ApiKeys.id);
      final token = CacheHelper().getData(key: ApiKeys.token);

      print('Client ID: $clientId, Token: $token');
      final Map<String, dynamic> data = {};

      if (name != null && name.isNotEmpty) {
        data[ApiKeys.name] = name;
      }

      if (phoneNumber != null && phoneNumber.isNotEmpty) {
        data[ApiKeys.phoneNumber] = phoneNumber;
      }

     final response =await Api.patch(
       EndPoint.clientProfileUpdate(clientId),
       data: data);
    // final response = await Api.patch(
      //   EndPoint.clientProfileUpdate(clientId),
      //   data: {
      //     // if (name != null) ApiKeys.name: name,
      //     // if (phoneNumber != null) ApiKeys.phoneNumber: phoneNumber,
      //     ApiKeys.name: name,
      //     ApiKeys.phoneNumber: phoneNumber,
      //   },
      // );

      return right(ClientModel.fromJson(response["data"]));
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  // profile pic change
  //
  // Future<Either<String, ClientModel>> changeProfilePic({
  //   required XFile profilePicture,
  // }) async {
  //   try {
  //     final Map<String, dynamic> data = {};
  //     final token = CacheHelper.sharedPreferences.get(ApiKeys.token);
  //     if (token == null) return left("Authorization token is missing.");
  //
  //     // Prepare multipart/form-data
  //     final multipartFile = await UploadImageToApi(profilePicture);
  //     final formData = FormData.fromMap({ApiKeys.profilePhoto: multipartFile});
  //
  //     if (profilePicture.path!=null&&profilePicture.path.isNotEmpty) {
  //       data[ApiKeys.profilePhoto] =profilePicture.path.toString();
  //     }
  //
  //     final response = await Api.post(
  //       EndPoint.uploadImage,
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //           'Content-Type': 'multipart/form-data',
  //         },
  //       ),
  //     );
  //     return right(ClientModel.fromJson(response["data"]));
  //   } on ServerException catch (e) {
  //     return left(e.errorModel.errorMessage);
  //   }
  // }
  Future<Either<String, ClientModel>> changeProfilePic({
    required XFile profilePicture,
  }) async {
    try {
      final token = CacheHelper.sharedPreferences.get(ApiKeys.token);

      if (token == null || token.toString().isEmpty) {
        return left("Authorization token is missing.");
      }

      if (profilePicture.path.isEmpty) {
        return left("Invalid image file.");
      }

      // Create MultipartFile
      final multipartFile = await MultipartFile.fromFile(
        profilePicture.path,
        filename: profilePicture.name,
      );
      final formData = FormData.fromMap({
        ApiKeys.profilePhoto: multipartFile,
      });

      final response = await Api.post(
        EndPoint.uploadImage,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      final data = response["data"];

      if (data == null) {
        return left("Server did not return profile data.");
      }
      ClientModel clientModel =ClientModel.fromJson(data);
      debugPrint("repositoy : ${clientModel.toJson()}");
      return right(clientModel);

    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    } catch (e) {
      return left("Unexpected error: $e");
    }
  }

}
