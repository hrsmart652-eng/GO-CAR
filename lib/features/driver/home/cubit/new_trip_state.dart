import 'package:go_car/features/driver/home/model/new_trip_model.dart';

abstract class NewTripState {}

class NewTripInitial extends NewTripState {}

class NewTripLoading extends NewTripState {}

class NewTripFailure extends NewTripState {
  final String errMessage;
  NewTripFailure({required this.errMessage});
}

class NewTripSuccess extends NewTripState {
  final List<NewTripModel> trips;
  NewTripSuccess({required this.trips});
}
