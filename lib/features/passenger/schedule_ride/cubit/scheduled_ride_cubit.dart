import 'dart:async';

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

class ScheduledRideCubit extends Cubit<ScheduledRideState>
    implements RatingCubitInterface {
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
  String moreLess = "See more";
  bool isSeeMore = false;
  bool isSchdule = false;

  @override
  double sliderValue = 2;

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
      id: 0,
      name: "Aareal Bank AG",
      number: "XXXXXXXXX236",
      image: "assets/images/visa.png",
    ),
    BankCardModel(
      id: 1,
      name: "BIGBANK AS Sverige Filial",
      number: "XXXXXXXXX843",
      image: "assets/images/visa1.png",
    ),
    BankCardModel(
      id:2,
      name: "HSBC Continental Europe Bank",
      number: "XXXXXXXXX198",
      image: "assets/images/visa2.png",
    ),
    BankCardModel(
      id:3,
      name: "Barclays Bank Ireland PLC",
      number: "XXXXXXXXX821",
      image: "assets/images/visa3.png",
    ),
    BankCardModel(
      id: 4,
      name: "BNP Paribas S.A., Bankfilial Sverige",
      number: "XXXXXXXXX465",
      image: "assets/images/visa4.png",
    ),
  ];

  Timer? tripsTimer;
  Timer? tripStatusTimer;

  List<Map<String, dynamic>> carsAndNames = [
    {'image': 'assets/images/economy_car.svg', 'type': "Economy"},
    {'image': 'assets/images/large_car.svg', 'type': 'Large'},
    {'image': 'assets/images/vip_car.svg', 'type': 'VIP'},
    {'image': 'assets/images/pet_car.svg', 'type': 'Pet'},
  ];

  @override
  final List<String> ratingTexts = ['Worst', 'Bad', 'Okay', 'Good', 'Awesome'];

  @override
  final List<String> ratingDescriptions = [
    'Worst Experience',
    'Bad Experience',
    'Okay Experience',
    'Good Experience',
    'Awesome Experience',
  ];

  @override
  final List<String> emojiAssets = [
    'assets/images/worst.png',
    'assets/images/bad.png',
    'assets/images/okay.png',
    'assets/images/good.png',
    'assets/images/awesome.png',
  ];

  @override
  final List<int> colors = [
    0xffEBEFFF,
    0xffFEF0C7,
    0xffC7F1FE,
    0xffFAD1E0,
    0xffD1FADF,
  ];

  List<TripStatusModel> allTrips = [];
  List<TripStatusModel> allNewTrips = [];
  DateTime? pickupDateTime;
  TimeOfDay? returnTime;

  RideType? returnRideType = RideType.returnRide;

  final DateFormat dateFormat = DateFormat('dd / MM / yyyy HH:mm');

  RideType selectedRideType = RideType.oneWay;

  requestRide() async {
    emit(ScheduledRideLoading());
    try {
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
        currentLocation: currentLocation,
        destination: destination,
        scheduledAt: "now",
        paymentMethod: paymentMethod,
        rideType: rideOfType ?? "normal",
        price: price ?? 0.0,
        driverShift: driverShift ?? "",
      );

      result.fold(
            (error) => emit(ScheduledRideFailure(errMessage: error)),
            (scheduledRide) {
          scheduledRideResponse = scheduledRide;
          CacheHelper().saveData(
            key: ApiKeys.tripId,
            value: scheduledRide.trip?.tripId.toString(),
          );
          CacheHelper().saveData(
            key: ApiKeys.clientId,
            value: scheduledRide.trip?.userId.toString(),
          );
          debugPrint(
            "================ScheduleRide Cubit ${scheduledRideResponse?.toJson()}====================",
          );
          emit(
            ScheduledRideSuccess(scheduledRideResponse: scheduledRideResponse),
          );
        },
      );
    } catch (e) {
      emit(ScheduledRideFailure(errMessage: 'An error occurred: $e'));
      debugPrint('Login error: $e');
    }
  }

  getAllTripsByDriverId() async {
    final driverId = CacheHelper().getData(key: ApiKeys.driverId);
    final response = await scheduledRideRepository.getALLTripStatus(
      id: driverId,
    );

    response.fold(
          (error) => emit(SchduledAllTripFailureState(errorMsg: error.toString())),
          (trips) {
        allNewTrips = trips;
        emit(SchduledAllTripSuccessState(allTrip: allNewTrips));
      },
    );
  }

  getDriverInfo() async {
    final driverId = CacheHelper().getData(key: ApiKeys.driverId);
    final response = await scheduledRideRepository.getDriverById(
      driverId: driverId,
    );

    response.fold(
          (error) => emit(ScheduledRideFailure(errMessage: error.toString())),
          (driver) {
        driverInfoModel = driver;
        debugPrint("Name :${driver.fullName}");
        emit(DriverInfoLoadedState(driverInfo: driver));
      },
    );
  }

  getDriverReviews() async {
    final response = await DriverReviewsRepository(
      api: DioConsumer(dio: Dio()),
    ).getDriverReviews();

    response.fold(
          (error) {},
          (reviews) {
        driverReviewsModel = reviews;
      },
    );
  }

  void startListeningAllTrips() {
    tripsTimer?.cancel();
    tripsTimer = Timer.periodic(const Duration(seconds: 20), (_) {
      getAllTripsByDriverId();
    });
  }

  void stopListeningAllTrips() {
    tripsTimer?.cancel();
  }

  void toggleSeeMoreLess() {
    isSeeMore = !isSeeMore;
    emit(SeeLessMoreState());
  }

  Future<NewTripResponseModel?> getRequestNewTrip() async {
    final clientId = CacheHelper().getData(key: ApiKeys.clientId);
    final tripId = CacheHelper().getData(key: ApiKeys.tripId);
    if (clientId == null) {
      emit(ScheduledRideFailure(errMessage: "UserId is null"));
      return null;
    }

    final response = await scheduledRideRepository.getRequestNewTrips();

    response.fold(
          (error) => emit(ScheduledRideFailure(errMessage: error.toString())),
          (trips) {
        for (var trip in trips) {
          if (trip.id == tripId) {
            foundNewTrip = trip;
            debugPrint("Found Trip: $foundNewTrip");
            break;
          }
        }
        isSchdule=true;
        emit(GetNewTripsSuccessState(newTrip: foundNewTrip));
      },
    );
    return foundNewTrip;
  }

  getAcceptNewTrip() async {
    final response = await scheduledRideRepository.getTripStatus();

    response.fold(
          (error) => emit(SchduledAllTripFailureState(errorMsg: error.toString())),
          (trip) {
        tripAcceptModel = trip;
        CacheHelper().saveData(key: ApiKeys.driverId, value: trip.driverId);
        if (trip.status?.toLowerCase() == "accepted" ||
            trip.status?.toLowerCase() == "completed") {
          debugPrint(
            "***********Trip Status: ${trip.status} : Driver ID ${trip.driverId}*****************",
          );
          emit(SchduledTripSuccessState(tripAccepted: trip));
          stopListeningTripAccept();
        }
      },
    );
  }

  void startListeningTripAccept() {
    tripStatusTimer?.cancel();
    tripStatusTimer = Timer.periodic(const Duration(seconds: 20), (_) {
      getAcceptNewTrip();
    });
  }

  void stopListeningTripAccept() {
    tripStatusTimer?.cancel();
  }

  fetchDriverData() async {
    await getDriverReviews();
    await getAllTripsByDriverId();
    await getDriverInfo();
  }

  cancelRide({required String tripId}) async {
    emit(ScheduledRideLoading());
    if (tripId.isEmpty) {
      emit(ScheduledRideFailure(errMessage: "No trip Cancelled"));
      return;
    }
    final response = await scheduledRideRepository.cancelTrip(tripId: tripId);
    response.fold(
          (errorMessage) => emit(ScheduledRideFailure(errMessage: errorMessage)),
          (schduledRide) {
        resetTrip();
        emit(
          CancelScheduledRideSuccess(
            tripId: scheduledRideResponse?.trip?.tripId,
          ),
        );
      },
    );
  }

  void changeRideType(RideType rideType) {
    selectedRideType = rideType;
    if (rideType == RideType.oneWay) {
      rideOfType = "normal";
      CacheHelper().saveData(key: ApiKeys.rideType, value: "normal");
    } else {
      rideOfType = "return";
      CacheHelper().saveData(key: ApiKeys.rideType, value: "return");
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

  double getEstimatedTime(double? distanceKm) {
    const double avgSpeed = 40;
    if (distanceKm == null || distanceKm == 0) return 0.0;
    return (distanceKm / avgSpeed) * 60;
  }

  choosePaymentMethod({required String paymentMethod}) {
    this.paymentMethod = paymentMethod;
    emit(ChoosePaymentMethodSchduleState());
  }

  clearLocation() {
    currentLocationCon.clear();
    destinationCon.clear();
    emit(SchduleClearLocation());
  }

  selectVisaBank({required int index}) {
    if (index < 0 || index >= visaCards.length) return;
    selectedVisaIndex = index;
    selectedVisaCard = visaCards[index];
    emit(SchduleSelectedVisaIndex());
  }

  saveVisaBankCards({required BankCardModel card}) {
    final alreadyExists = savedVisaCards.any((c) => c.id == card.id);
    if (!alreadyExists) {
      savedVisaCards.add(card);
    }
    emit(SchduleSavedVisaState(cards: savedVisaCards));
  }

  @override
  void resetTrip() {
    foundNewTrip = null;
    tripAcceptModel = null;
    currentLocationCon.clear();
    destinationCon.clear();
    currentCarIndex = 0;
    currentLuggageIndex = 0;
    returnTime = null;
    pickupDateTime = null;
    selectedRideType = RideType.oneWay;
    selectedCarType = carsAndNames[0]["type"];
    currentPassengersIndex = 1;
    paymentMethod = "";
    CacheHelper().clearData(key: ApiKeys.rideType);
    CacheHelper().clearData(key: ApiKeys.tripId);
    emit(SchduleResetTripState());
  }

  @override
  Future<void> sendTripReview({
    required int rating,
    required String review,
  }) async {
    emit(ScheduledRideLoading());
    final tripId = tripAcceptModel?.id.toString();
    final response = await scheduledRideRepository.sendTripRating(
      tripId: tripId,
      rating: rating,
      review: review,
    );
    response.fold(
          (errorMsg) => emit(ScheduledRideFailure(errMessage: errorMsg.toString())),
          (rate) => emit(SchduleReviewSuccessState(rateModel: rate)),
    );
  }
}