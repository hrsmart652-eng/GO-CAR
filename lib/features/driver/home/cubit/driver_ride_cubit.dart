import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/home/model/driver_ride_model.dart';
import 'package:go_car/features/driver/home/repository/driver_ride_repository.dart';
import 'driver_ride_state.dart';

class DriverRideCubit extends Cubit<DriverRideState> {
  DriverRideCubit(this.rideRepository) : super(DriverRideInitial());
  final DriverRideRepository rideRepository;
  static DriverRideCubit get(context)=>BlocProvider.of<DriverRideCubit>(context);


  acceptRide(String tripId) async {
    emit(DriverRideLoading());
    final response = await rideRepository.acceptTrip(
      TripId: tripId,
      Id: CacheHelper.sharedPreferences.get(ApiKeys.id).toString(),
    );

    response.fold(
      (errorMessage) => emit(DriverRideFailure(errMessage: errorMessage)),
      (driverRideModel){
        CacheHelper().saveData(
          key: ApiKeys.driverId,
          value:driverRideModel.driverId
        );
        CacheHelper().saveData(
            key: ApiKeys.tripId,
            value:driverRideModel.id
        );

        print("**************************Driver Id :${driverRideModel.driverId}**********************");
        emit(DriverRideSuccess());},
    );
  }

  rejectRide(String tripId) async {
    emit(DriverRideLoading());
    final response = await rideRepository.rejectTrip(TripId: tripId);

    response.fold(
      (errorMessage) => emit(DriverRideFailure(errMessage: errorMessage)),
      (driverRideModel) {
        CacheHelper().saveData(
            key: ApiKeys.tripId,
            value:driverRideModel.id
        );
        emit(DriverRideSuccess());
      }
    );
  }

  startRide() async {
    emit(DriverRideLoading());
    final tripId=CacheHelper().getData(key: ApiKeys.tripId,);
    final response = await rideRepository.startTrip(TripId: tripId);

    response.fold(
      (errorMessage) => emit(DriverRideFailure(errMessage: errorMessage)),
      (DriverRideModel) => emit(DriverRideSuccess()),
    );
  }

  inLocation() async {
    emit(DriverRideLoading());
    final tripId=CacheHelper().getData(key: ApiKeys.tripId,);
    final response = await rideRepository.inLocation(TripId: tripId);
    response.fold(
      (errorMessage) => emit(DriverRideFailure(errMessage: errorMessage)),
      (DriverRideModel) => emit(DriverRideSuccess()),
    );
  }

  endRide() async {
    emit(DriverRideLoading());
    final tripId=CacheHelper().getData(key: ApiKeys.tripId,);
    final response = await rideRepository.endRide(TripId: tripId);
    response.fold(
      (errorMessage) => emit(DriverRideFailure(errMessage: errorMessage)),
      (DriverRideModel) => emit(DriverRideSuccess()),
    );
  }

  reviewRide(String tripId, String rating) async {
    emit(DriverRideLoading());
    final response = await rideRepository.reviewPassenger(
      TripId: tripId,
      rating: rating,
      comment: ApiKeys.comment,
    );
    response.fold(
      (errorMessage) => emit(DriverRideFailure(errMessage: errorMessage)),
      (DriverRideModel) => emit(DriverRideSuccess()),
    );
  }
}
