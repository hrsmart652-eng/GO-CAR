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
