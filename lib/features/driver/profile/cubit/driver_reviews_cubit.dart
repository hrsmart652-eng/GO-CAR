import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/features/driver/profile/repositories/driver_reviews_repository.dart';
import 'driver_reviews_state.dart';

class DriverReviewsCubit extends Cubit<DriverReviewsState> {
  DriverReviewsCubit(this.reviewsRepository) : super(DriverReviewsInitial());
  final DriverReviewsRepository reviewsRepository;

  getDriverReviews() async {
    emit(DriverReviewsLoading());
    final response = await reviewsRepository.getDriverReviews();
    response.fold(
      (errorMessage) => emit(DriverReviewsFailure(errMessage: errorMessage)),
      (reviewsModel) => emit(DriverReviewsSuccess(driverReviews: reviewsModel)),
    );
  }
}
