import 'package:dartz/dartz.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/services/errors/exceptions.dart';
import 'package:go_car/features/driver/profile/models/driver_reviews_model.dart';

class DriverReviewsRepository{
  final ApiConsumer api;

  DriverReviewsRepository({required this.api});

  Future<Either<String, DriverReviewsModel>> getDriverReviews() async {
    try {
  String driverId=CacheHelper().getData(key: ApiKeys.driverId);
      final response = await api.get(
        EndPoint.DriverReviews(driverId));

  DriverReviewsModel review=DriverReviewsModel.fromJson(response);
      return right(review);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }catch(err){
      return left(err.toString());
    }
  }

  // reviews pic change
}
