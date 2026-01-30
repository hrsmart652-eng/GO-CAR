import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';
import 'package:go_car/features/passenger/normal_ride/repository/normal_ride_repo.dart';

class RequestRideCubit extends Cubit<RequestRideState> {
  RequestRideCubit({required this.requestRideRepository})
    : super(RequestRideInitial());
  RequestRideRepository requestRideRepository;

  String userId = CacheHelper().getData(key: ApiKeys.id);
  String selectedCarType = 'Economy';
  int passengerCount = 1;
  int luggageCount = 0;
  Map<String, dynamic> currentLocation = {};
  Map<String, dynamic> destination = {};
  String? scheduledAt;
  String paymentMethod = '';
  String? _id;

  requestRide() async {
    emit(RequestRideLoading());
    try {
      final result = await requestRideRepository.requestRide(
        userId: userId,
        carType: selectedCarType,
        passengerNo: passengerCount,
        luggageNo: luggageCount,
        currentLocation: currentLocation,
        destination: destination,
        scheduledAt: scheduledAt,
        paymentMethod: paymentMethod,
      );

      result.fold(
        (error) {
          emit(RequestRideFailure(errMessage: error));
        },
        (normalRideModel) {
          print('Ride requested successfully: ${normalRideModel.trip}');
          emit(RequestRideSuccess());

          // Navigate to home or other screen
        },
      );
    } catch (e) {
      emit(RequestRideFailure(errMessage: 'An error occurred: $e'));
      print('Login error: $e');
    }
  }

  cancelRide(String tripId) async {
    emit(RequestRideLoading());
    final response = await requestRideRepository.cancelTrip;

    response.fold(
      (errorMessage) => emit(RequestRideFailure(errMessage: errorMessage)),
      (DriverRideModel) => emit(RequestRideSuccess()),
    );
  }
}
