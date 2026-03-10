import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/core/services/api/dio_consumer.dart';
import 'package:go_car/features/driver/profile/repositories/driver_reviews_repository.dart';
import 'package:go_car/features/passenger/normal_ride/model/driver_info_model.dart';
import 'package:go_car/features/passenger/normal_ride/model/trip_response_model.dart';
import 'package:go_car/features/passenger/profile/model/client_model.dart';

import '../../../../config/environment.dart';
import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/services/api/end_points.dart';
import '../../../driver/profile/models/driver_reviews_model.dart';
import '../model/normal_ride_model.dart';
import '../model/ride_accepted_model.dart';
import '../model/visa_bank_model.dart';
import '../repository/normal_ride_repo.dart';
import 'normal_ride_state.dart';

class NormalRideCubit extends Cubit<RequestRideState>  implements RatingCubitInterface {
  NormalRideCubit({required this.requestRideRepository})
    : super(RequestRideInitial()) {
    fetchData();
  }

  RequestRideRepository requestRideRepository;
  TripStatusModel? tripStatusModel;
  DriverInfoModel? driverInfo;

  static NormalRideCubit get(context) =>
      BlocProvider.of<NormalRideCubit>(context);
  int currentPassengersIndex = 1;
  int currentLuggageIndex = 0;
  int currentCarIndex = 0;
  BankCardModel? selectedVisaCard;
  BankCardModel? savedVisa;
  int selectedVisaIndex = 0;
  ClientModel? clientModel;
  TripResponseModel? tripResponseModel;
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
  List<Map<String, dynamic>> carsAndNames = [
    {'image': 'assets/images/economy_car.svg', 'type': "Economy"},
    {'image': 'assets/images/large_car.svg', 'type': 'Large'},
    {'image': 'assets/images/vip_car.svg', 'type': 'VIP'},
    {'image': 'assets/images/pet_car.svg', 'type': 'Pet'},
  ];

  final TextEditingController currentLocationCon = TextEditingController();
  final TextEditingController destinationCon = TextEditingController();
  NormalRideModel? normalRide;

  // String userId = CacheHelper().getData(key: ApiKeys.id);
  String selectedCarType = 'Economy';
  int passengerCount = 1;
  int luggageCount = 0;
  Map<String, dynamic> currentLocation = {};
  Map<String, dynamic> destination = {};
  String? scheduledAt = "now";
  String paymentMethod = '';
  String? tripId;
  List<TripStatusModel> driverTrips = [];
  Map<String, dynamic> locationData = {};
  Map<String, dynamic> destinationData = {};
  DriverReviewsModel? driverReviews;
  final ratingTexts = ['Worst', 'Bad', 'Okay', 'Good', 'Awesome'];

  final ratingDescriptions = [
    'Worst Experience',
    'Bad Experience',
    'Okay Experience',
    'Good Experience',
    'Awesome Experience',
  ];

  final emojiAssets = [
    'assets/images/worst.png',
    'assets/images/bad.png',
    'assets/images/okay.png',
    'assets/images/good.png',
    'assets/images/awesome.png',
  ];

  final colors = [0xffEBEFFF, 0xffFEF0C7, 0xffC7F1FE, 0xffFAD1E0, 0xffD1FADF];

  double sliderValue = 2;

  Timer? tripTimer;

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
      // CacheHelper().saveData(
      //   key: ApiKeys.driverId,
      //   value: "68a4176698c08494803ccb55",
      // );
      final clientId = CacheHelper().getData(key: ApiKeys.clientId);
      final result = await requestRideRepository.requestRide(
        userId: clientId,
        carType: normalRide?.trip.carType ?? selectedCarType,
        passengerNo: normalRide?.trip.passengerNo ?? currentPassengersIndex,
        luggageNo: normalRide?.trip.luggageNo ?? currentLuggageIndex,
        currentLocation: locationData,
        destination: destinationData,
        scheduledAt: scheduledAt,
        paymentMethod: normalRide?.trip.paymentInfo.method ?? paymentMethod,
      );
      print(
        '*******************Ride response =${result}***************************',
      );
      result.fold(
        (error) {
          emit(RequestRideFailure(errMessage: error));
        },
        (normalRideModel) {
          normalRide = normalRideModel;
          CacheHelper().saveData(
            key: ApiKeys.tripId,
            value: normalRideModel.trip.id,
          );
          print(
            'Ride requested successfully: ${normalRideModel.trip.toJson()}',
          );
          print('Cache Trip Id: ${CacheHelper().getData(key: ApiKeys.tripId)}');
          // return meassage to check about trip status

          emit(RequestRideSuccess());
        },
      );
    } catch (e) {
      emit(RequestRideFailure(errMessage: 'An error occurred: $e'));
      print('Login error: $e');
    }
  }

  clearLocation({required TextEditingController constroller}) {
    constroller.clear();
    emit(ClearLocationState());
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
      (normalRideModel) {
        emit(RequestRideSuccess());
      },
    );
  }

  String formatTime(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.isEmpty) return '';

    try {
      final dt = DateTime.parse(dateTimeStr).toLocal();
      final hour =
          dt.hour > 12
              ? dt.hour - 12
              : dt.hour == 0
              ? 12
              : dt.hour;
      final minute = dt.minute.toString().padLeft(2, '0');
      final period = dt.hour >= 12 ? 'PM' : 'AM';
      return '$hour:$minute $period';
    } catch (e) {
      return '';
    }
  }

  // return extimated time
  num getEstimatedTime(double? distanceKm) {
    const double avgSpeed = 40; // km/h
    if (distanceKm == null || distanceKm == 0) return 0;
    int res = ((distanceKm / avgSpeed) * 60).round();
    final result = num.parse(res.toStringAsFixed(2));
    return result;
  }

  changeCarTypeIndex({required int index}) {
    CacheHelper().saveData(key:ApiKeys.carTypeImg, value:carsAndNames[index]["image"]);
    currentCarIndex = index;
    selectedCarType = carsAndNames[currentCarIndex]["type"];
    normalRide?.trip.carType != selectedCarType;
    emit(ChangeCarTypeIndexState());
  }

  void startCheckingTripStatus() {
    tripTimer?.cancel();

    tripTimer = Timer.periodic(const Duration(minutes:1), (_) async {
      final driverId = CacheHelper().getData(key: ApiKeys.driverId);

      final tripResponse =
          await requestRideRepository.getTripAcceptedAndCompleted();

      tripResponse.fold(
        (error) {
          debugPrint(error);
        },
        (trip) async {
          final status = trip.status?.toLowerCase();

          if (trip.driverId?.isEmpty ?? true) {
            debugPrint("Driver ID is NULL");
            return;
          }

          final driverResponse = await requestRideRepository.getDriverById(
            driverId: trip.driverId ?? driverId ?? "",
          );

          driverResponse.fold(
            (error) {
              debugPrint("Driver Error $error");
            },
            (driver) async {
              driverInfo = driver;

              final driverTripsRes =
                  await requestRideRepository.getAllDriverTrips();

              driverTripsRes.fold(
                (error) {
                  debugPrint(error);
                },
                (trips) {
                  driverTrips = trips;

                  if (status == "accepted") {
                    emit(
                      AllTripsSuccessState(
                        trip: trip,
                        driverInfo: driver,
                        driverTrips: trips,
                      ),
                    );
                    stopCheckingTripStatus();
                  } else if (status == "completed") {
                    emit(
                      AllTripsSuccessState(
                        trip: trip,
                        driverInfo: driver,
                        driverTrips: trips,
                      ),
                    );
                    stopCheckingTripStatus();
                  }
                },
              );
            },
          );
          stopCheckingTripStatus();
        },

      );
    });
  }

  void stopCheckingTripStatus() {
    tripTimer?.cancel();
  }

  changePassengerIndex({required int index}) {
    currentPassengersIndex = index;
    normalRide?.trip.passengerNo != index;
    emit(ChangePassengerIndexState());
  }

  changeLuggageIndex({required int index}) {
    currentLuggageIndex = index;
    normalRide?.trip.luggageNo != index;
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

  choosePaymentMethod({required String? paymentMethod}) {
    this.paymentMethod = paymentMethod ?? "";
    tripStatusModel?.paymentInfo?.method != paymentMethod;
    emit(ChoosePaymentMethodState());
  }

  selectVisaBank({required int index}) {
    if (index < 0 || index >= visaCards.length) return;
    selectedVisaIndex = index;
    selectedVisaCard = visaCards[index];
    emit(SelectedVisaIndexdState());
  }

  saveVisaBankCards({required BankCardModel card}) {
    final alreadyExists = savedVisaCards.any((c) => c.id == card.id);
    if (!alreadyExists) {
      savedVisaCards.add(card);
    }
    emit(VisaBankAddedState(cards: savedVisaCards));
  }

  removeVisaBankCard({required int id}) {
    visaCards.removeWhere((visa) => visa.id == id);

    if (selectedVisaIndex == id) {
      selectedVisaIndex =
          (visaCards.isNotEmpty ? visaCards.first.id : null) ?? 0;
    }
    emit(VisaBankAddedState(cards: visaCards));
  }

  sendTripReview({required int? rating, required String? review}) async {
    emit(RequestRideLoading());
    final tripId = normalRide?.trip.id.toString();
    final response = await requestRideRepository.sendTripRating(
      tripId: tripId,
      rating: rating,
      review: review,
    );
    response.fold(
      (errorMsg) {
        emit(RequestRideFailure(errMessage: errorMsg.toString()));
      },
      (rate) {
        emit(ReviewSuccessState(rateModel: rate));
      },
    );
  }

  Future<void> getDriverReviews() async {
    emit(RequestRideLoading());
    final response =
        await DriverReviewsRepository(
          api: DioConsumer(dio: Dio()),
        ).getDriverReviews();

    response.fold(
      (error) {
        /// emit(RequestRideFailure(errMessage: error));
      },
      (reviews) {
        driverReviews = reviews;
        // emit(TripsReviewsLoaded());
      },
    );
  }

  getAllDriversTrips() async {
    emit(RequestRideLoading());

    final response = await requestRideRepository.getAllDriverTrips();

    response.fold(
      (error) {
        print("error:${error}");
      },
      (trips) {
        driverTrips = trips;
        emit(DriverRidesLoadedState(driverTrips: driverTrips));
      },
    );
  }

  resetTrip() {
    normalRide = null;
    currentLocationCon.clear();
    destinationCon.clear();
    currentCarIndex = 0;
    currentLuggageIndex = 0;
    currentPassengersIndex = 1;
    paymentMethod = "";
    CacheHelper().clearData(key:ApiKeys.rideType);
    emit(ResetTripState());
  }

  fetchData() async {
    await getDriverReviews();
    await getAllDriversTrips();
    startCheckingTripStatus();
  }
}
