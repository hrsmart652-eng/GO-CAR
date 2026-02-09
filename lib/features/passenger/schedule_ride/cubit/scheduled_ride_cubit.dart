import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/passenger/schedule_ride/cubit/scheduled_ride_state.dart';
import 'package:go_car/features/passenger/schedule_ride/model/scheduled_ride_model.dart';
import 'package:go_car/features/passenger/schedule_ride/repository/scheduled_ride_repo.dart';

class ScheduledRideCubit extends Cubit<ScheduledRideState> {
  ScheduledRideCubit({required this.scheduledRideRepository})
    : super(ScheduledRideInitial());
  String? userId = CacheHelper().getData(key: ApiKeys.id);
  String? selectedCarType = 'Economy';
  int? passengerCount = 1;
  int? luggageCount = 0;
  Map<String, dynamic> currentLocation = {};
  Map<String, dynamic> destination = {};
  String? scheduledAt;
  String paymentMethod = '';
  String? rideType="";
  double? price=0.0;
  String?driverShift="";
  String? _id;

  ScheduledRideRepository scheduledRideRepository;
  // ScheduledRideModel scheduledRideModel = ScheduledRideModel(
  //   userId: userId,
  //   carType:selectedCarType,
  //   passengerNo: passengerNo,
  //   luggageNo: luggageNo,
  //   currentLocation: currentLocation,
  //   destination: destination,
  //   scheduledAt: scheduledAt,
  //   paymentMethod: paymentMethod,
  //   rideType: rideType,
  //   price: price,
  //   driverShift: driverShift,
  // );

  requestRide() async {
    emit(ScheduledRideLoading());
    try {
      final result = await scheduledRideRepository.requestRide(
        secheduledRideModel: ScheduledRideModel(
          userId: userId,
          carType:selectedCarType,
          passengerNo:passengerCount,
          luggageNo:luggageCount,
          currentLocation:currentLocation,
          destination: destination,
          scheduledAt: scheduledAt,
          paymentMethod: paymentMethod,
          rideType: rideType,
          price: price,
          driverShift: driverShift,
        ),
      );
      result.fold(
        (error) {
          emit(ScheduledRideFailure(errMessage: error));
        },
        (scheduledRideModel){
          debugPrint("================ScheduleRide Model ${scheduledRideModel.toJson()}====================");
        //  print('Ride requested successfully: ${normalRideModel.trip}');
          emit(ScheduledRideSuccess());

          // Navigate to home or other screen
        },
      );
    } catch (e) {
      emit(ScheduledRideFailure(errMessage: 'An error occurred: $e'));
      print('Login error: $e');
    }
  }

  cancelRide(String tripId) async {
    emit(ScheduledRideLoading());
    final response = await scheduledRideRepository.cancelTrip;

    response.fold(
      (errorMessage) => emit(ScheduledRideFailure(errMessage: errorMessage)),
      (DriverRideModel) => emit(ScheduledRideSuccess()),
    );
  }
}
