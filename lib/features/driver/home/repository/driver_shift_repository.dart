import 'package:dartz/dartz.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/services/errors/exceptions.dart';
import 'package:go_car/features/driver/home/model/driver_shift_model.dart';

class DriverShiftRepository {
  final ApiConsumer api;

  DriverShiftRepository({required this.api});

  Future<Either<String, DriverShiftModel>> startShift({
    required String id,
    required String carType,
  }) async {
    try {
      final response = await api.post(
        EndPoint.driverStartShift,
        data: {
          "driver": id, // correct key
          "carType": carType,
        },
      );
      final driver = DriverShiftModel.fromJson(response);
      CacheHelper().saveData(key: ApiKeys.shiftId, value: driver.ShiftId);
      print(driver.ShiftId);
      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverShiftModel>> endShift({
    required String id,
  }) async {
    try {
      final response = await api.patch(
        EndPoint.driverEndShift(id),
        // data: {
        //   "_id": id, // correct key
        // },
      );
      final driver = DriverShiftModel.fromJson(response);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverShiftModel>> driverBeOnline({
    required String id,
  }) async {
    try {
      final response = await api.patch(EndPoint.driverBeOnline(id));
      final driver = DriverShiftModel.fromJson(response);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverShiftModel>> driverBeOffline({
    required String id,
  }) async {
    try {
      final response = await api.patch(EndPoint.driverBeOffline(id));
      final driver = DriverShiftModel.fromJson(response);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverShiftModel>> driverAcceptCash({
    required String id,
  }) async {
    try {
      final response = await api.patch(EndPoint.driverAcceptCash(id));
      final driver = DriverShiftModel.fromJson(response);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  Future<Either<String, DriverShiftModel>> driverRefuseCash({
    required String id,
  }) async {
    try {
      final response = await api.patch(EndPoint.driverRefuseCash(id));
      final driver = DriverShiftModel.fromJson(response);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }
}
