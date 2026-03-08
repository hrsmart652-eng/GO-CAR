import 'package:dartz/dartz.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/services/errors/exceptions.dart';
import 'package:go_car/features/driver/home/model/driver_ride_model.dart';
import 'package:go_car/features/passenger/normal_ride/model/driver_info_model.dart';

class DriverRideRepository {
  final ApiConsumer api;

  DriverRideRepository({required this.api});

  Future<Either<String, DriverRideModel>> acceptTrip({
    required String TripId,
    required String Id,
  }) async {
    try {
      final response = await api.patch(
        EndPoint.driverAcceptTrip(TripId),
        data: {
          "driverId": Id, // correct key
        },
      );
      final driver = DriverRideModel.fromJson(response);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverRideModel>> rejectTrip({
    required String TripId,
    // required String Id,
  }) async {
    try {
      final response = await api.patch(
        EndPoint.driverRejectTrip(TripId),
        // data: {
        //   "driverId": Id, // correct key
        // },
      );
      final driver = DriverRideModel.fromJson(response);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverRideModel>> startTrip({
    required String TripId,
  }) async {
    try {
      final response = await api.patch(
        EndPoint.driverStartTrip(TripId),
        // data: {
        //   "driver": id, // correct key
        // },
      );
      final driver = DriverRideModel.fromJson(response);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverRideModel>> inLocation({
    required String TripId,
  }) async {
    try {
      final response = await api.patch(
        EndPoint.driverInLocationTrip(TripId),
        // data: {
        //   "driver": id, // correct key
        // },
      );
      final driver = DriverRideModel.fromJson(response);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverRideModel>> endRide({
    required String TripId,
  }) async {
    try {
      final response = await api.patch(
        EndPoint.driverEndTrip(TripId),
        // data: {
        //   "driver": TripId, // correct key
        // },
      );
      final driver = DriverRideModel.fromJson(response);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverRideModel>> reviewPassenger({
    required String TripId,
    required String rating,
    required String comment,
  }) async {
    try {
      final response = await api.post(
        EndPoint.driverReview(TripId),
        data: {"rating": rating, "comment": comment},
      );
      final driver = DriverRideModel.fromJson(response);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  // reviews pic change
}
