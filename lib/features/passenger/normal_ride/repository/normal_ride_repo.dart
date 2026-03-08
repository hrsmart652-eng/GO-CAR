import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_car/features/passenger/normal_ride/model/trip_response_model.dart';
import 'package:go_car/features/passenger/profile/model/client_model.dart';

import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/services/api/api_consumer.dart';
import '../../../../core/services/api/end_points.dart';
import '../model/driver_info_model.dart';
import '../model/normal_ride_model.dart';
import '../model/rating_model.dart';
import '../model/ride_accepted_model.dart';

class RequestRideRepository {
  final ApiConsumer api;

  RequestRideRepository({required this.api});

  Future<Either<String, NormalRideModel>> requestRide({
    required String userId,
    required String carType,
    required int passengerNo,
    required int luggageNo,
    required Map<String, dynamic> currentLocation,
    required Map<String, dynamic> destination,
    String? scheduledAt,
    required String paymentMethod,
  }) async {
    try {
      final response = await api.post(
        EndPoint.requestTrip,
        isFormData: false,
        data: {
          "userId": userId,
          "carType": carType,
          "passengerNo": passengerNo,
          "luggageNo": luggageNo,
          "currentLocation": currentLocation,
          "destination": destination,
          "scheduledAt": scheduledAt,
          "paymentMethod": paymentMethod,
        },
      );
      final tripResponse = response['trip'];
      //  ************************ // Save trip code*******************************
      final tripCode = response['trip']['tripCode'].toString();
      final tripId = response['trip']['_id'].toString();
      final rideMsg = response["message"].toString();
      await CacheHelper().saveData(key: EndPoint.requestTrip, value: tripId);
      await CacheHelper().saveData(key: ApiKeys.tripId, value: tripId);
      await CacheHelper().saveData(key: ApiKeys.message, value: rideMsg);
      await CacheHelper().saveData(key: ApiKeys.tripCode, value: tripCode);

      //************************************************************************
      debugPrint('Trip Code saved: ${tripCode}');
      debugPrint('Trip Response: ${tripResponse}');
      debugPrint('Normal Ride Response: ${response}');
      NormalRideModel normalRide = NormalRideModel.fromJson(response);
      TripModel trip = TripModel.fromJson(tripResponse);
      debugPrint('Trip Model: ${trip.toJson()}');
      return Right(normalRide);
    } catch (e) {
      debugPrint('Request Ride Error: $e');
      return Left(e.toString());
    }
  }

  Future<Either<String, String>> cancelTrip({required String tripId}) async {
    final tripId = CacheHelper().getData(key: ApiKeys.tripId);
    try {
      final response = await api.patch(
        isFormData: false,
        EndPoint.cancelTrip(tripId),
      );

      return Right(response.toString());
    } catch (error) {
      return Left(error.toString());
    }
  }

  // Future<Either<String, TripStatusModel>> acceptTrip({
  //   required String driverId,
  // }) async {
  //   try {
  //     final response = await api.patch(
  //       EndPoint.driverAcceptTrip(driverId),
  //       data: {"driverId": driverId},
  //     );
  //
  //     // تحقق من أن response مش null
  //     if (response == null) {
  //       return Left("No response from server");
  //     }
  //
  //     // هنا نستخدم الـ response مباشرة لإنشاء الموديل
  //     TripStatusModel tripStatusModel = TripStatusModel.fromJson(response);
  //
  //     // save driver ID locally
  //     await CacheHelper().saveData(key: ApiKeys.driverId, value: driverId);
  //
  //     debugPrint("Accepted Trip: ${tripStatusModel.toJson()}");
  //
  //     return Right(tripStatusModel);
  //   } catch (e) {
  //     debugPrint('Request Ride Error: $e');
  //     return Left(e.toString());
  //   }
  // }

  Future<Either<String, ClientModel>> getClientById() async {
    try {
      // ارسال GET request
      final clientId = CacheHelper().getData(key: ApiKeys.clientId);
      final response = await api.get(EndPoint.getClient(clientId));

      // التحقق من وجود البيانات ونجاح الاستجابة
      if (response != null && response["success"] == true) {
        final data = response["data"];
        if (data != null && data is Map<String, dynamic>) {
          // إنشاء DriverInfoModel من JSON
          final clientInfo = ClientModel.fromJson(data);
          debugPrint('Client fetched successfully: ${clientInfo.fullName}');
          return right(clientInfo);
        } else {
          return left("Client data is missing or malformed");
        }
      } else {
        // حالة فشل الاستجابة
        return left(
          "API returned an error: ${response?["message"] ?? "Unknown error"}",
        );
      }
    } catch (error) {
      debugPrint('getDriverById Error: ${error.toString()}');
      return left(error.toString());
    }
  }

  Future<Either<String, DriverInfoModel>> getDriverById({
    required String driverId,
  }) async {
    try {
      //final driverId = CacheHelper().getData(key: ApiKeys.driverId);
      final response = await api.get(EndPoint.getDriver(driverId));

      if (response != null && response["success"] == true) {
        final data = response["data"];
        if (data != null && data is Map<String, dynamic>) {
          final driverInfo = DriverInfoModel.fromJson(data);
          debugPrint('Driver fetched successfully: ${driverInfo.fullName}');
          return right(driverInfo);
        } else {
          return left("Driver data is missing or malformed");
        }
      } else {
        return left(
          "API returned an error: ${response?["message"] ?? "Unknown error"}",
        );
      }
    } catch (error) {
      debugPrint('getDriverById Error: ${error.toString()}');
      return left(error.toString());
    }
  }

  Future<Either<String, RatingModel>> sendTripRating({
    required String? tripId,
    required int? rating,
    required String? review,
  }) async {
    try {
      // نفترض إن api.patch بيرجع Map<String,dynamic> مباشرة
      final response = await api.patch(
        EndPoint.DriverRate(tripId),
        data: {"rating": rating, "review": review},
      );

      if (response == null) {
        return Left("No response from server");
      }

      // response هنا Map<String,dynamic> مباشرة
      final Map<String, dynamic> res = response;

      // جلب Trip من response
      final RatingModel resRating = RatingModel.fromJson(res);

      if (resRating.trip != null) {
        debugPrint("Trip Rated Successfully: ${resRating.trip}");
        return Right(resRating);
      } else {
        return Left(resRating.message ?? "Rating failed");
      }
    } catch (e) {
      debugPrint("patchDriverRateTrip Error: $e");
      return Left(e.toString());
    }
  }

  Future<Either<String, List<TripResponseModel>>> getAllTrips() async {
    try {
      final response = await api.get(EndPoint.getAllTrips());

      List<TripResponseModel> trips =
          response.map((trip) => TripResponseModel.fromJson(trip)).toList();

      debugPrint(
        "****************************************All Trips : ${trips}***********************************",
      );

      return right(trips);
    } catch (error) {
      return left(error.toString());
    }
  }

  Future<Either<String, TripStatusModel>> getTripAcceptedAndCompleted() async {
    try {
      final tripId = CacheHelper().getData(key: ApiKeys.tripId);
      final clientId = CacheHelper().getData(key: ApiKeys.clientId);
      final clientTripsResponse = await api.get(EndPoint.getTrip(clientId));

      final clientTripRes = clientTripsResponse["trips"] as List<dynamic>;

      List<TripStatusModel> clientTrips =
          clientTripRes
              .map(
                (trip) =>
                    TripStatusModel.fromJson(trip as Map<String, dynamic>),
              )
              .toList();

      TripStatusModel? foundTrip;

      for (var trip in clientTrips) {
        if ((trip.status?.toLowerCase() == "accepted" ||
                trip.status?.toLowerCase() == "completed") &&
            trip.driverId != null &&
            trip.id == tripId &&
            trip.client == clientId) {
          print("trip.status = ${trip.status}");
          print("trip.id = ${trip.id}");
          print("*************************************************");
          foundTrip = trip;
          final driverId = CacheHelper().saveData(
            key: ApiKeys.driverId,
            value: trip.driverId,
          );
          break;
        }
      }
      if (foundTrip == null) {
        print(
          "****************************Trip : ${foundTrip}***************************",
        );
        return left("No accepted or completed trip found");
      }

      return right(foundTrip);
    } catch (error) {
      return left(error.toString());
    }
  }

  Future<Either<String, List<TripStatusModel>>> getAllDriverTrips() async {
    try {
      final driverId = CacheHelper().getData(key: ApiKeys.driverId);
      final driveTripsResponse = await api.get(EndPoint.getTrip(driverId));

      final driveTripRes = driveTripsResponse["trips"] as List<dynamic>;

      List<TripStatusModel> driveTrips =
          driveTripRes
              .map(
                (trip) =>
                    TripStatusModel.fromJson(trip as Map<String, dynamic>),
              )
              .toList();
      return right(driveTrips);
    } catch (error) {
      return left(error.toString());
    }
  }
}
