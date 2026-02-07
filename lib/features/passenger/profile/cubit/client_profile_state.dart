import '../model/client_model.dart';

class ClientProfileState {}

final class ClientProfileInitial extends ClientProfileState {}
final class ClientProfileLoading extends ClientProfileState {}

final class ClientProfileSuccess extends ClientProfileState {
  final ClientModel clientModel;

  ClientProfileSuccess({required this.clientModel});
}

final class ClientProfileFailure extends ClientProfileState {
  final String errMessage;
  ClientProfileFailure({required this.errMessage});
}

class ClientProfileImageLoading extends ClientProfileState {}

class ClientProfileImageSuccess extends ClientProfileState {
  final ClientModel client;

  ClientProfileImageSuccess({required this.client});
}

class ClientProfileImageFailure extends ClientProfileState {
  final String message;

  ClientProfileImageFailure({required this.message});
}

