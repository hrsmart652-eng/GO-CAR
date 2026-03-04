import 'package:go_car/entrypoints/main_driver.dart';
import 'package:go_car/features/passenger/normal_ride/model/driver_info_model.dart';
import 'package:go_car/features/passenger/normal_ride/model/rating_model.dart';
import 'package:go_car/features/passenger/normal_ride/model/ride_accepted_model.dart';
import 'package:go_car/features/passenger/normal_ride/model/trip_response_model.dart';

import '../../../driver/profile/models/driver_model.dart';
import '../../../driver/profile/models/driver_reviews_model.dart';
import '../model/visa_bank_model.dart';

class RequestRideState {}

final class RequestRideInitial extends RequestRideState {}

final class RequestRideLoading extends RequestRideState {}

final class RequestRideSuccess extends RequestRideState {}

final class WalletRideSuccess extends RequestRideState {}

final class RequestRideFailure extends RequestRideState {
  final String errMessage;

  RequestRideFailure({required this.errMessage});
}

final class ChangeCarTypeIndexState extends RequestRideState {}

final class ChangePassengerIndexState extends RequestRideState {}

final class ChangeLuggageIndexState extends RequestRideState {}

final class SetCurrentLocationState extends RequestRideState {}

final class SetDestinationState extends RequestRideState {}

final class ClearLocationState extends RequestRideState {}

final class ChoosePaymentMethodState extends RequestRideState {}

final class SelectedVisaIndexdState extends RequestRideState {}

final class ReviewSuccessState extends RequestRideState {
  RatingModel rateModel;
  ReviewSuccessState({required this.rateModel});
}

final class VisaBankAddedState extends RequestRideState {
  List<BankCardModel> cards = [];

  VisaBankAddedState({required this.cards});
}
final class AcceptedDriverInfoState extends RequestRideState {
  DriverModel driverModel;
  TripStatusModel tripStatusModel;
  AcceptedDriverInfoState({required this.tripStatusModel,required this.driverModel});
}

final class ResetTripState extends RequestRideState {
}
final class AllTripsLoadingState extends RequestRideState {}

final class AllTripsSuccessState extends RequestRideState {
  TripStatusModel  trip;
  DriverInfoModel driverInfo;
  AllTripsSuccessState({required this.trip,required this.driverInfo});
}
final class AllTripsFailureState extends RequestRideState {
  String errorMsg;
  AllTripsFailureState({required this.errorMsg});
}
final class DriverInfoSuccessState extends RequestRideState {
  DriverInfoModel driverInfoModel;
  DriverInfoSuccessState({required this.driverInfoModel});
}

class TripsReviewsLoaded extends RequestRideState {

  TripsReviewsLoaded();
}
// final class GetAllDriverTripsState extends RequestRideState {
//   List<TripStatusModel> driverTrips=[];
//   GetAllDriverTripsState({required this.driverTrips});
// }