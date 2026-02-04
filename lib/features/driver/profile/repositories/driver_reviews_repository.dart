import 'package:dartz/dartz.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/services/errors/exceptions.dart';
import 'package:go_car/features/driver/profile/models/driver_reviews_model.dart';

class DriverReviewsRepository {
  final ApiConsumer Api;

  DriverReviewsRepository({required this.Api});

  Future<Either<String, DriverReviewsModel>> getDriverReviews() async {
    try {
      final response = await Api.get(
        EndPoint.DriverReviews(CacheHelper().getData(key: ApiKeys.id)),
      );

      return right(DriverReviewsModel.fromJson(response));
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }

  // reviews pic change
}
