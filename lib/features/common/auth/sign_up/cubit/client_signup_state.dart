part of 'client_signup_cubit.dart';

@immutable
sealed class ClientSignupCubitDartState {}

final class ClientSignupCubitDartInitial extends ClientSignupCubitDartState {}

final class ClientSignupCubitLooding extends ClientSignupCubitDartState {}

final class ClientSignupCubitSuccess extends ClientSignupCubitDartState {}

final class ClientSignupCubitFailure extends ClientSignupCubitDartState {
  final String errMessage;

  ClientSignupCubitFailure({required this.errMessage});
}
