import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/passenger/normal_ride/model/normal_ride_model.dart';

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
          "client": userId,
          "carType": carType,
          "passengerNo": passengerNo,
          "luggageNo": luggageNo,
          "currentLocation": currentLocation,
          "destination": destination,
          "scheduledAt": scheduledAt,
          "paymentMethod": paymentMethod,
        },
      );
      final tripResponse=response["trip"];
   //  ************************ // Save trip code*******************************
      final tripCode = response['trip']['tripCode'].toString();
      final tripId = response['trip']['_id'].toString();
      final rideMsg=response["message"].toString();
      await CacheHelper().saveData(
        key: EndPoint.requestTrip,
        value: tripId,
      );
      await CacheHelper().saveData(
        key:ApiKeys.tripId,
        value: tripId,
      );
      await CacheHelper().saveData(
        key: ApiKeys.message,
        value:rideMsg,
      );
      //************************************************************************
      debugPrint('Trip Code saved: ${tripCode}');
      debugPrint('Trip Response: ${tripResponse}');

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
    final tripId =CacheHelper().getData(key:ApiKeys.tripId);
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
}
