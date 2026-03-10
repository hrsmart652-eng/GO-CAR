import 'package:go_car/features/passenger/normal_ride/model/driver_info_model.dart';
import 'package:go_car/features/passenger/normal_ride/model/ride_accepted_model.dart';
import 'package:go_car/features/passenger/normal_ride/model/visa_bank_model.dart';
import 'package:go_car/features/passenger/schedule_ride/model/new_trip_response_model.dart';

import '../../normal_ride/model/rating_model.dart';
import '../model/scheduled_ride_model.dart';

class ScheduledRideState {}

final class ScheduledRideInitial extends ScheduledRideState {}

final class ScheduledRideLoading extends ScheduledRideState {}

final class ScheduledRideSuccess extends ScheduledRideState {
 final  ScheduledRideResponse? scheduledRideResponse;
 ScheduledRideSuccess({required this.scheduledRideResponse});
}
final class CancelScheduledRideSuccess extends ScheduledRideState {
  final  String? tripId;
  CancelScheduledRideSuccess({required this.tripId});
}

final class ChangeRideTypeState extends ScheduledRideState {}

final class ScheduledRideFailure extends ScheduledRideState {
  final String errMessage;

  ScheduledRideFailure({required this.errMessage});
}

final class ChangeCarTypeIndexState extends ScheduledRideState {}

final class ChangePassengerIndexState extends ScheduledRideState {}

final class ChangeLuggageIndexState extends ScheduledRideState {}

final class SetCurrentLocationState extends ScheduledRideState {}

final class SetDestinationState extends ScheduledRideState {}

final class SelectPickedTimeState extends ScheduledRideState {}

final class ReturnTime extends ScheduledRideState {}

final class ChoosePaymentMethodSchduleState extends ScheduledRideState {}

final class SchduleClearLocation extends ScheduledRideState {}

final class SchduledTripLoadingState extends ScheduledRideState {}

final class SchduleSelectedVisaIndex extends ScheduledRideState {}

final class SchduledAllTripFailureState extends ScheduledRideState {
  final String errorMsg;

  SchduledAllTripFailureState({required this.errorMsg});
}

final class SchduledTripSuccessState extends ScheduledRideState {
  TripStatusModel tripAccepted;

  SchduledTripSuccessState({required this.tripAccepted});
}

final class SchduledAllTripSuccessState extends ScheduledRideState {
  List<TripStatusModel> allTrip;

  SchduledAllTripSuccessState({required this.allTrip});
}
final class SchduledAcceptedTripSuccessState extends ScheduledRideState {
  TripStatusModel tripAccept;
  DriverInfoModel driverInfo;
  SchduledAcceptedTripSuccessState({required this.tripAccept,required this.driverInfo});
}

final class GetNewTripsSuccessState extends ScheduledRideState {
  NewTripResponseModel? newTrip;

  GetNewTripsSuccessState({required this.newTrip});
}

final class SeeLessMoreState extends ScheduledRideState {}


final class SchduleSavedVisaState extends ScheduledRideState {
  List<BankCardModel> cards = [];

  SchduleSavedVisaState({required this.cards});
}

final class SchduleResetTripState extends ScheduledRideState {}

final class DriverInfoLoadedState extends ScheduledRideState {
  DriverInfoModel driverInfo;
  DriverInfoLoadedState({required this.driverInfo});
}
final class SchduleReviewSuccessState extends ScheduledRideState {
  RatingModel rateModel;
  SchduleReviewSuccessState({required this.rateModel});

}


