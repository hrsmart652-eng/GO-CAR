import 'package:dartz/dartz.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/passenger/normal_ride/model/normal_ride_model.dart';
import 'package:go_car/features/passenger/schedule_ride/model/scheduled_ride_model.dart';

class ScheduledRideRepository {
  final ApiConsumer api;

  ScheduledRideRepository({required this.api});

  Future<Either<String, ScheduledRideModel>> requestRide({
    required ScheduledRideModel secheduledRideModel
    // required String userId,
    // required String carType,
    // required int passengerNo,
    // required int luggageNo,
    // required Map<String, dynamic> currentLocation,
    // required Map<String, dynamic> destination,
    // required String? scheduledAt,
    // required String paymentMethod,
  }) async {
    try {
      ScheduledRideModel scheduledRideData=ScheduledRideModel.fromJson(secheduledRideModel.toJson());
      final response = await api.post(
        isFormData: false,
        EndPoint.requestTrip,
        data:scheduledRideData.toJson()
      );

      CacheHelper().saveData(
        key: ApiKeys.tripCode,
        value:response['trip']['_id'],
      );
      print('Ride ID saved: ${CacheHelper().getData(key: ApiKeys.tripCode)}');

    //  final normalRideModel = NormalRideModel.fromJson(response);
      // final RideModel = NormalRideModel.fromJson(response);
      return Right(scheduledRideData);
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
