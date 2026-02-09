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


