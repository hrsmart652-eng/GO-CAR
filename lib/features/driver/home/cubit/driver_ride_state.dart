class DriverRideState {}

final class DriverRideInitial extends DriverRideState {}

final class DriverRideLoading extends DriverRideState {}

final class DriverRideSuccess extends DriverRideState {}

final class DriverRideFailure extends DriverRideState {
  final String errMessage;
  DriverRideFailure({required this.errMessage});
}
