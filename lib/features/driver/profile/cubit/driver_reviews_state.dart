import 'package:go_car/features/driver/profile/models/driver_reviews_model.dart';

class DriverReviewsState {}

final class DriverReviewsInitial extends DriverReviewsState {}

final class DriverReviewsLoading extends DriverReviewsState {}

final class DriverReviewsSuccess extends DriverReviewsState {
  final DriverReviewsModel driverReviews;

  DriverReviewsSuccess({required this.driverReviews});
}

final class DriverReviewsFailure extends DriverReviewsState {
  final String errMessage;
  DriverReviewsFailure({required this.errMessage});
}
