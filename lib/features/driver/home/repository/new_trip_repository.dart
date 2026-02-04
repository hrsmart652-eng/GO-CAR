import 'package:dartz/dartz.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/services/errors/exceptions.dart';
import 'package:go_car/features/driver/home/model/new_trip_model.dart';

class NewTripRepository {
  final ApiConsumer Api;

  NewTripRepository({required this.Api});

  Future<Either<String, List<NewTripModel>>> getNewTrip() async {
    try {
      final response = await Api.get(EndPoint.newTrip);

      // response is a List<dynamic>
      final trips =
          (response as List)
              .map((e) => NewTripModel.fromJson(e as Map<String, dynamic>))
              .toList();

      return right(trips);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  // reviews pic change
}
