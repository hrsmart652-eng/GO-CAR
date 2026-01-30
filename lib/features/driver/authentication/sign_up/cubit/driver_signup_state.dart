class DriverSignUpState {}

final class DriverSignUpInitial extends DriverSignUpState {}

final class UploadLicense extends DriverSignUpState {}

final class DriverSignUpLoading extends DriverSignUpState {}

final class DriverSignUpSuccess extends DriverSignUpState {
  final String message;
  DriverSignUpSuccess({required this.message});
}

final class DriverSignUpFailure extends DriverSignUpState {
  final String errMessage;
  DriverSignUpFailure({required this.errMessage});
}
