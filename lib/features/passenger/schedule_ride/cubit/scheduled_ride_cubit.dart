import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/profile/models/driver_reviews_model.dart';
import 'package:go_car/features/passenger/schedule_ride/cubit/scheduled_ride_state.dart';
import 'package:go_car/features/passenger/schedule_ride/model/scheduled_ride_model.dart';
import 'package:go_car/features/passenger/schedule_ride/repository/scheduled_ride_repo.dart';
import 'package:intl/intl.dart';

import '../../../../config/environment.dart';
import '../../../../core/services/api/dio_consumer.dart';
import '../../../driver/profile/repositories/driver_reviews_repository.dart';
import '../../normal_ride/model/driver_info_model.dart';
import '../../normal_ride/model/ride_accepted_model.dart';
import '../../normal_ride/model/trip_response_model.dart';
import '../../normal_ride/model/visa_bank_model.dart';
import '../../normal_ride/repository/normal_ride_repo.dart';
import '../model/new_trip_response_model.dart';

class ScheduledRideCubit extends Cubit<ScheduledRideState> {
  ScheduledRideCubit({required this.scheduledRideRepository})
    : super(ScheduledRideInitial());

  static ScheduledRideCubit get(context) =>
      BlocProvider.of<ScheduledRideCubit>(context);

  String userId = CacheHelper().getData(key: ApiKeys.clientId);
  String? selectedCarType = 'Economy';
  int? passengerCount = 1;
  int? luggageCount = 0;
  Map<String, dynamic> currentLocation = {
    "type": "Point",
    "coordinates": [31.2357, 30.0444],
  };
  Map<String, dynamic> destination = {
    "type": "Point",
    "coordinates": [31.2595, 30.0456],
  };
  String? scheduledAt;
  String paymentMethod = '';
  String? rideOfType = "normal";
  double? price = 0.0;
  String? driverShift = "";
  TripStatusModel? tripAcceptModel;
  int currentCarIndex = 0;
  int currentPassengersIndex = 1;
  int currentLuggageIndex = 0;
  BankCardModel? selectedVisaCard;
  int selectedVisaIndex = 0;
  final ScheduledRideRepository scheduledRideRepository;
  RequestRideRepository? requestRideRepository;
  DriverReviewsRepository? driverReviewsRepository;
  ScheduledRideResponse? scheduledRideResponse;
  DriverReviewsModel? driverReviewsModel;
  DriverInfoModel? driverInfoModel;
  NewTripResponseModel? foundNewTrip;
  List<TripResponseModel> allDriversTrips = [];
  TextEditingController currentLocationCon = TextEditingController();
  TextEditingController destinationCon = TextEditingController();
  bool isAcNewTrip = false;
  List<BankCardModel> savedVisaCards = [];
  List<BankCardModel> visaCards = [
    BankCardModel(
      id: 1,
      name: "Aareal Bank AG",
      number: "XXXXXXXXX236",
      image: "assets/images/visa.png",
    ),
    BankCardModel(
      id: 2,
      name: "BIGBANK AS Sverige Filial",
      number: "XXXXXXXXX843",
      image: "assets/images/visa1.png",
    ),
    BankCardModel(
      id: 3,
      name: "HSBC Continental Europe Bank",
      number: "XXXXXXXXX198",
      image: "assets/images/visa2.png",
    ),
    BankCardModel(
      id: 4,
      name: "Barclays Bank Ireland PLC",
      number: "XXXXXXXXX821",
      image: "assets/images/visa3.png",
    ),
    BankCardModel(
      id: 5,
      name: "BNP Paribas S.A., Bankfilial Sverige",
      number: "XXXXXXXXX465",
      image: "assets/images/visa4.png",
    ),
  ];

  Timer? tripTimer;
  Timer? tripStatusTimer;

  List<Map<String, dynamic>> carsAndNames = [
    {'image': 'assets/images/economy_car.svg', 'type': "Economy"},
    {'image': 'assets/images/large_car.svg', 'type': 'Large'},
    {'image': 'assets/images/vip_car.svg', 'type': 'VIP'},
    {'image': 'assets/images/pet_car.svg', 'type': 'Pet'},
  ];

  List<TripStatusModel> allTrips = [];
  List<TripStatusModel> allNewTrips = [];
  DateTime? pickupDateTime;
  TimeOfDay? returnTime;

  RideType? returnRideType = RideType.returnRide;

  final DateFormat dateFormat = DateFormat('dd / MM / yyyy HH:mm');

  RideType selectedRideType = RideType.oneWay;
  final clientId = CacheHelper().getData(key: ApiKeys.clientId);

  requestRide() async {
    emit(ScheduledRideLoading());
    try {
      // final userId = CacheHelper().getData(key: ApiKeys.clientId);
      // scheduledRideResponse?.trip?.userId = userId;
      currentLocation = {
        "type": "Point",
        "coordinates": [31.2357, 30.0444],
      };
      destination = {
        "type": "Point",
        "coordinates": [31.2595, 30.0456],
      };

      final result = await scheduledRideRepository.requestRide(
        userId: userId,
        carType: selectedCarType,
        passengerNo: currentPassengersIndex,
        luggageNo: currentLuggageIndex,
        currentLocation: currentLocation ?? {},
        destination: destination ?? {},
        scheduledAt: "now",
        // pickupDateTime?.toIso8601String() ??
        // DateTime.now().toIso8601String(),
        paymentMethod: paymentMethod,
        rideType: rideOfType ?? "normal",
        price: price ?? 0.0,
        driverShift: driverShift ?? "",
      );

      result.fold(
        (error) {
          emit(ScheduledRideFailure(errMessage: error));
        },
        (scheduledRide) {
          scheduledRideResponse = scheduledRide;
          CacheHelper().saveData(
            key: ApiKeys.tripId,
            value: scheduledRide.trip?.tripId.toString(),
          );
          debugPrint(
            "================ScheduleRide Cubit ${scheduledRideResponse?.toJson()}====================",
          );
          //  print('Ride requested successfully: ${normalRideModel.trip}');
          emit(
            ScheduledRideSuccess(scheduledRideResponse: scheduledRideResponse),
          );

          // Navigate to home or other screen
        },
      );
    } catch (e) {
      emit(ScheduledRideFailure(errMessage: 'An error occurred: $e'));
      print('Login error: $e');
    }
  }

  Future<List<TripStatusModel>> getAllTripsByClientId() async {
     final clientId = CacheHelper().getData(key: ApiKeys.clientId);
    final response = await scheduledRideRepository.getALLTripStatus(id: clientId);
    response.fold(
      (error) => emit(SchduledAllTripFailureState(errorMsg: error.toString())),
      (trips) async {
        allTrips = trips;
        // emit(SchduledAllTripSuccessState(allTrip: allTrips));
        // get all drivers to check if driver is approved of not ...
        final driverResponse = await scheduledRideRepository.getAllDrivers();
        driverResponse.fold(
              (error) => emit(ScheduledRideFailure(errMessage: error.toString())),
              (drivers) {
            for (var trip in allTrips) {
              for (var driver in drivers) {
                if (trip.driverId == driver.id) {
                  allNewTrips.add(trip);
                }else if(trip.status?.toLowerCase()=="requested"){
                  allNewTrips.add(trip);
                }
                break;
              }
            }
            emit(SchduledAllTripSuccessState(allTrip: allNewTrips));
          },
        );
      },
    );
    return allTrips;
  }

  getDriverInfo() async {
    final driverId = CacheHelper().getData(key: ApiKeys.driverId);
    //************************* get driver data **************************
    final response = await scheduledRideRepository.getDriverById(
      driverId: driverId,
    );

    response.fold(
      (error) => emit(ScheduledRideFailure(errMessage: error.toString())),
      (driver) {
        driverInfoModel = driver;
        print("Name :${driver.fullName}");
        // emit(DriverInfoLoadedState(driverInfo:driver));
      },
    );
  }

  Future<void> getDriverReviews() async {
    // emit(ScheduledRideLoading());
    final response =
        await DriverReviewsRepository(
          api: DioConsumer(dio: Dio()),
        ).getDriverReviews();

    response.fold((error) {}, (reviews) {
      driverReviewsModel = reviews;
      // emit(TripsReviewsLoaded());
    });
  }

  // to get  request new trip in home screen
  Future<NewTripResponseModel?> getRequestNewTrip() async {
    final clientId = CacheHelper().getData(key: ApiKeys.clientId);
    final tripId = CacheHelper().getData(key: ApiKeys.tripId);
    if (clientId == null) {
      emit(ScheduledRideFailure(errMessage: "UserId is null"));
      return null;
    }

    final response = await scheduledRideRepository.getRequestNewTrips();

    response.fold(
      (error) {
        emit(ScheduledRideFailure(errMessage: error.toString()));
      },
      (trips) {
        for (var trip in trips) {
          if (trip.id == tripId) {
            foundNewTrip = trip;
            debugPrint("Found Trip: $foundNewTrip");
            break;
          }
        }
        emit(GetNewTripsSuccessState(newTrip: foundNewTrip));
      },
    );
    return foundNewTrip;
  }

  getAcceptNewTrip() async {
    emit(ScheduledRideLoading());
    final response = await scheduledRideRepository.getTripStatus();

    response.fold(
      (error) => emit(SchduledAllTripFailureState(errorMsg: error.toString())),
      (trip) {
        tripAcceptModel = trip;
        if (trip.status?.toLowerCase() == "accepted") {
          CacheHelper().saveData(key: ApiKeys.driverId, value: trip.driverId);
          // getDriverInfo(driverId: trip.driverId!);
          // fetchData();
          emit(SchduledTripSuccessState(tripAccepted: trip));
          stopListeningTripAccept();
        }
        emit(SchduledTripSuccessState(tripAccepted: trip));
      },
    );
  }

  // Future<Either<String, List<TripStatusModel>>> getAllNewTrips() async {
  //   final clientId = CacheHelper().getData(key: ApiKeys.clientId);
  //   Future<List<TripStatusModel>> clientTripRes = getAllTripsById(id: clientId);
  //   clientTripRes.fold(
  //     (error) => emit(ScheduledRideFailure(errMessage: error.toString())),
  //     (trips) async {
  //
  //     },
  //   );
  // }

  //*******************Trip Status Listing *****************
  void startListeningTripAccept() {
    tripStatusTimer?.cancel();

    tripStatusTimer = Timer.periodic(const Duration(seconds: 10), (_) {
      getAcceptNewTrip();
    });
  }

  void stopListeningTripAccept() {
    tripStatusTimer?.cancel();
  }

  // // fetchData() async {
  // //   await getRequestNewTrips();
  // //   await getTripStatus();
  // // }
  // changeNewTripAccepted() async {
  //   if (foundNewTrip == null) {
  //     await getRequestNewTrip();
  //     return;
  //   }
  //   final status = foundNewTrip!.status?.toLowerCase();
  //
  //   if (status == "accepted") {
  //     await getAcceptNewTrip();
  //   } else {
  //     await getRequestNewTrips();
  //   }
  // }

  fetchData() async {
    final driverId = CacheHelper().getData(key: ApiKeys.driverId);
    await getDriverReviews(); // driver reviews
    await getAllTripsByClientId(); //all trips related to driver
    await getDriverInfo(); // get driver data
  }

  // void startCheckingTripStatus() {
  //   //  emit(SchduledTripLoadingState());
  //
  //   tripTimer?.cancel();
  //
  //   tripTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
  //     final response = await scheduledRideRepository.getALLTripStatus(
  //       id: clientId,
  //     );
  //
  //     response.fold(
  //       (failure) {
  //         emit(SchduledAllTripFailureState(errorMsg: failure));
  //       },
  //       (trips) {
  //         allTrips = trips;
  //
  //         emit(SchduledAllTripSuccessState(allTrip: List.from(allTrips)));
  //       },
  //     );
  //   });
  // }
  //
  // void stopCheckingTripStatus() {
  //   tripTimer?.cancel();
  // }

  cancelRide({required String tripId}) async {
    emit(ScheduledRideLoading());
    if (tripId.isEmpty) {
      emit(ScheduledRideFailure(errMessage: "No trip Cancelled"));
      return;
    }
    final response = await scheduledRideRepository.cancelTrip(tripId: tripId);
    response.fold(
      (errorMessage) => emit(ScheduledRideFailure(errMessage: errorMessage)),
      (schduledRide) => emit(
        CancelScheduledRideSuccess(tripId: scheduledRideResponse?.trip?.tripId),
      ),
    );
  }

  void changeRideType(RideType rideType) {
    selectedRideType = rideType;

    if (rideType == RideType.oneWay) {
      rideOfType = "normal";
    } else {
      rideOfType = "return";
    }

    emit(ChangeRideTypeState());
  }

  changeCarTypeIndex({required int index}) {
    currentCarIndex = index;
    selectedCarType = carsAndNames[index]["type"];
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

  Future<void> selectPickupDateTime(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: pickupDateTime ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date != null) {
      final TimeOfDay? time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );

      if (time != null) {
        if (time.hour >= 6 && time.hour < 12) {
          driverShift = "morning";
        } else if (time.hour >= 12 && time.hour < 18) {
          driverShift = "afternoon";
        } else {
          driverShift = "evening";
        }
        pickupDateTime = DateTime(
          date.year,
          date.month,
          date.day,
          time.hour,
          time.minute,
        );
      }
    }
    emit(SelectPickedTimeState());
  }

  Future<void> selectReturnTime(BuildContext context) async {
    final TimeOfDay? time = await showTimePicker(
      context: context,
      initialTime: returnTime ?? TimeOfDay.now(),
    );

    if (time != null) {
      returnTime = time;
    }
    emit(ReturnTime());
  }

  // return extimated time
  double getEstimatedTime(double? distanceKm) {
    const double avgSpeed = 40;
    if (distanceKm == null || distanceKm == 0) return 0.0;

    return (distanceKm / avgSpeed) * 60;
  }

  choosePaymentMethod({required String paymentMethod}) {
    // this.paymentMethod = paymentMethod ?? "";
    this.paymentMethod = paymentMethod;
    emit(ChoosePaymentMethodSchduleState());
  }

  clearLocation() {
    currentLocationCon.clear();
    destinationCon.clear();
    emit(SchduleClearLocation());
  }

  selectVisaBank({required int index}) {
    selectedVisaIndex = index;
    emit(SchduleSelectedVisaIndex());
  }

  saveVisaBankCards({required BankCardModel card}) {
    if (savedVisaCards.contains(card)) {
      return;
    } else {
      savedVisaCards.add(card);
    }
    emit(SchduleSavedVisaState(cards: visaCards));
  }

  resetTrip() {
    // currentLocationCon.clear();
    // destinationCon.clear();
    currentCarIndex = 0;
    currentLuggageIndex = 0;
    currentPassengersIndex = 1;
    paymentMethod = "";
    emit(SchduleResetTripState());
  }
}
