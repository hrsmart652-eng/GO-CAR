import 'package:dartz/dartz.dart';
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
    required String? scheduledAt,
    required String paymentMethod,
  }) async {
    try {
      final response = await api.post(
        isFormData: false,
        EndPoint.requestTrip,
        data: {
          "userId": userId,
          "carType": carType,
          "passengerNo": passengerNo,
          "luggageNo": luggageNo,
          "currentLocation": {
            "type": "Point",
            "coordinates": [31.2357, 30.0444],
          },
          "destination": {
            "type": "Point",
            "coordinates": [32.2500, 31.0500],
          },
          "scheduledAt": scheduledAt,
          "paymentMethod": paymentMethod,
        },
      );

      CacheHelper().saveData(
        key: ApiKeys.tripCode,
        value: response['trip']['_id'],
      );
      print('Ride ID saved: ${CacheHelper().getData(key: ApiKeys.tripCode)}');

      final normalRideModel = NormalRideModel.fromJson(response);

      return Right(normalRideModel);
    } catch (error) {
      return Left(error.toString());
    }
  }

  Future<Either<String, void>> get cancelTrip async {
    try {
      final response = await api.patch(
        isFormData: false,
        EndPoint.cancelTrip(CacheHelper().getData(key: ApiKeys.tripCode)),
      );

      return Right(response);
    } catch (error) {
      return Left(error.toString());
    }
  }
}
