import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import '../../../../core/services/api/end_points.dart';
import '../model/normal_ride_model.dart';
import '../repository/normal_ride_repo.dart';
import 'normal_ride_state.dart';

class NormalRideCubit extends Cubit<RequestRideState> {
  NormalRideCubit({required this.requestRideRepository})
    : super(RequestRideInitial());
  RequestRideRepository requestRideRepository;

  static NormalRideCubit get(context) =>
      BlocProvider.of<NormalRideCubit>(context);
  int currentPassengersIndex = 1;
  int currentLuggageIndex = 0;
  int currentCarIndex = 0;

  List<Map<String, dynamic>> carsAndNames = [
    {'image': 'assets/images/economy_car.svg', 'type': "Economy"},
    {'image': 'assets/images/large_car.svg', 'type': 'Large'},
    {'image': 'assets/images/vip_car.svg', 'type': 'VIP'},
    {'image': 'assets/images/pet_car.svg', 'type': 'Pet'},
  ];

  final TextEditingController currentLocationCon = TextEditingController();
  final TextEditingController destinationCon = TextEditingController();
  NormalRideModel? normalRide;
  String userId = CacheHelper().getData(key: ApiKeys.id);
  String selectedCarType = 'Economy';
  int passengerCount = 1;
  int luggageCount = 0;
  Map<String, dynamic> currentLocation = {};
  Map<String, dynamic> destination = {};
  String? scheduledAt = "now";
  String paymentMethod = '';
  String? tripId;
  Map<String, dynamic> locationData = {};
  Map<String, dynamic> destinationData = {};

   requestRide() async {
    emit(RequestRideLoading());
    try {
      locationData = {
        // "fromPlace": currentLocationCon.text,
        "type": "Point",
        "coordinates": [31.2357.toString(), 30.0444.toString()],
      };
      destinationData = {
        //  "toPlace": destinationCon.text,<{
        "type": "Point",
        "coordinates": [32.2500.toString(), 31.0500.toString()],
      };

      final result = await requestRideRepository.requestRide(
        userId: userId,
        carType: selectedCarType,
        passengerNo: currentPassengersIndex,
        luggageNo: currentLuggageIndex,
        currentLocation: locationData,
        destination: destinationData,
        scheduledAt: scheduledAt,
        paymentMethod: paymentMethod,
      );
      print('*******************Ride response =${result}***************************');
      result.fold(
        (error) {
          emit(RequestRideFailure(errMessage: error));
        },
        (normalRideModel) {
          normalRide = normalRideModel;
          print(
            'Ride requested successfully: ${normalRideModel.trip.toJson()}',
          );
          // return meassage to check about trip status

            emit(RequestRideSuccess());

        });
    } catch (e) {
      emit(RequestRideFailure(errMessage: 'An error occurred: $e'));
      print('Login error: $e');
    }
  }

  cancelRide(String tripId) async {
    if (tripId.isEmpty) {
      emit(RequestRideFailure(errMessage: "No trip Cancelled"));
      return;
    }
    emit(RequestRideLoading());
    final response = await requestRideRepository.cancelTrip(tripId: tripId);

    response.fold(
      (errorMessage) => emit(RequestRideFailure(errMessage: errorMessage)),
      (normalRideModel){
        emit(RequestRideSuccess());
      },
    );
  }
  // return extimated time
  num getEstimatedTime(double? distanceKm) {
    const double avgSpeed = 40; // km/h
    if (distanceKm == null || distanceKm == 0) return 0;
    int res = ((distanceKm / avgSpeed) * 60).round();
    num result = num.parse(res.toStringAsFixed(2));
    return result;
  }

  changeCarTypeIndex({required int index}) {
    currentCarIndex = index;
    selectedCarType = carsAndNames[currentCarIndex]["type"];
    emit(ChangeCarTypeIndexState());
  }

  changePassengerIndex({required int index}) {
    currentPassengersIndex = index;
    emit(ChangePassengerIndexState());
  }

  changeLuggageIndex({required int index}) {
    currentLuggageIndex = index;
    emit(ChangeLuggageIndexState());
  }

  setCurrentLocation({required String fromLocation}) {
    currentLocationCon.text = fromLocation;
    emit(SetCurrentLocationState());
  }

  setDestination({required String toLocation}) {
    destinationCon.text = toLocation;
    emit(SetDestinationState());
  }
}
