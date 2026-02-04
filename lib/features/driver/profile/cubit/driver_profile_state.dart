import 'package:go_car/features/driver/profile/models/driver_model.dart';

class DriverProfileState {}

final class DriverProfileInitial extends DriverProfileState {}

final class DriverProfileLoading extends DriverProfileState {}

final class DriverProfileSuccess extends DriverProfileState {
  final DriverModel driverProfile;

  DriverProfileSuccess({required this.driverProfile});
}

final class DriverProfileFailure extends DriverProfileState {
  final String errMessage;
  DriverProfileFailure({required this.errMessage});
}
