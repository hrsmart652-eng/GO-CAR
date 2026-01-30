class DriverLoginState {}

final class DriverLoginInitial extends DriverLoginState {}

final class DriverSignInLoading extends DriverLoginState {}

final class DriverSignInSuccess extends DriverLoginState {}

final class DriverSignInFailure extends DriverLoginState {
  final String errMessage;
  DriverSignInFailure({required this.errMessage});
}
