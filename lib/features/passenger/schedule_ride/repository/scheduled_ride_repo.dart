import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/passenger/normal_ride/model/driver_info_model.dart';
import 'package:go_car/features/passenger/schedule_ride/model/scheduled_ride_model.dart';

import '../../normal_ride/model/ride_accepted_model.dart';
import '../../normal_ride/model/trip_response_model.dart';
import '../model/new_trip_response_model.dart';

class ScheduledRideRepository {
  final ApiConsumer api;

  ScheduledRideRepository({required this.api});

  Future<Either<String, ScheduledRideResponse>> requestRide({
    required String userId,
    required String? carType,
    required String rideType,
    required int passengerNo,
    required int luggageNo,
    required Map<String, dynamic> currentLocation,
    required Map<String, dynamic> destination,
    required String scheduledAt,
    required String paymentMethod,
    required double price,
    required String driverShift,
  }) async {
    try {
      final token = CacheHelper().getData(key: ApiKeys.token);

      final response = await api.post(
        isFormData: false,
        EndPoint.requestTrip,
        data: {
          "userId": userId,
          "carType": carType,
          "passengerNo": passengerNo,
          "luggageNo": luggageNo,
          "currentLocation": currentLocation,
          "destination": destination,
          "scheduledAt": scheduledAt,
          "paymentMethod": paymentMethod,
          "rideType": rideType,
          "price": price,
          "driverShift": driverShift,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json",
            "Authorization": "Bearer $token",
          },
        ),
      );
      ScheduledRideResponse scheduledResponse = ScheduledRideResponse.fromJson(
        response,
      );
      debugPrint(
        "================================Schedule Response $response=======================",
      );

      // // save data to cache
      //  CacheHelper().saveData(
      //   key: ApiKeys.tripId,
      //   value: trip['_id'],
      // );
      //
      //  CacheHelper().saveData(
      //   key: ApiKeys.id,
      //   value: trip['client'],
      // );
      //
      //  CacheHelper().saveData(
      //   key: ApiKeys.tripCode,
      //   value: trip['tripCode'],
      // );

      return Right(scheduledResponse);
    } catch (error) {
      debugPrint("ERROR => $error");
      return Left(error.toString());
    }
  }

  Future<Either<String, String>> cancelTrip({required String tripId}) async {
    final tripId = CacheHelper().getData(key: ApiKeys.tripId);
    try {
      final response = await api.patch(
        isFormData: false,
        EndPoint.cancelTrip(tripId), //path
      );

      return Right(response.toString());
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, TripStatusModel>> getTripStatus() async {
    try {
      final tripId = CacheHelper().getData(key: ApiKeys.tripId);
      final clientId = CacheHelper().getData(key: ApiKeys.clientId);
      debugPrint("Trip Id : ${tripId}");
      final response = await api.get(EndPoint.getTrip(clientId));
      final tripRes = response["trips"] as List<dynamic>;

      List<TripStatusModel> trips =
          tripRes
              .map(
                (item) =>
                    TripStatusModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
      TripStatusModel? foundTrip;

      for (var trip in trips) {
        if (trip.id == tripId && trip.client == clientId) {
          foundTrip = trip;
          break;
        }
      }

      if (foundTrip == null) {
        return left("Trip not found");
      }

      return right(foundTrip);
    } catch (error) {
      return left(error.toString());
    }
  }

  Future<Either<String, List<TripStatusModel>>> getALLTripStatus({
    required String id,
  }) async {
    try {
      debugPrint("Trip Id : ${id}");
      final response = await api.get(EndPoint.getTrip(id));
      final tripRes = response["trips"] as List<dynamic>;

      List<TripStatusModel> trips =
          tripRes
              .map(
                (item) =>
                    TripStatusModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();

      return right(trips);
    } catch (error) {
      return left(error.toString());
    }
  }

  Future<Either<String, List<NewTripResponseModel>>>
  getRequestNewTrips() async {
    try {
      final response = await api.get(EndPoint.getNewTrip());

      final newTrips = response as List<dynamic>;

      List<NewTripResponseModel> trips =
          newTrips
              .map(
                (item) =>
                    NewTripResponseModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();

      return right(trips);
    } catch (error) {
      return left(error.toString());
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

  Future<Either<String, List<DriverInfoModel>>> getAllDrivers() async {
    try {
      final response = await api.get(EndPoint.getAllDriver());
      final data = response["data"] as List<dynamic>;
      List<DriverInfoModel> drivers =
          data
              .map(
                (item) =>
                    DriverInfoModel.fromJson(item as Map<String, dynamic>),
              )
              .toList();
      return right(drivers);
    } catch (error) {
      return left(error.toString());
    }
  }

  Future<Either<String, DriverInfoModel>> getDriverById({required String driverId}) async {
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
}
