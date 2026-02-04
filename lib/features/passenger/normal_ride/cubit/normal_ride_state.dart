class RequestRideState {}

final class RequestRideInitial extends RequestRideState {}

final class RequestRideLoading extends RequestRideState {}

final class RequestRideSuccess extends RequestRideState {}

final class RequestRideFailure extends RequestRideState {
  final String errMessage;

  RequestRideFailure({required this.errMessage});
}
