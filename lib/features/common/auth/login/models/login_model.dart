import 'package:go_car/core/services/api/end_points.dart';

class LoginModel {
  final String token;
  final dynamic user;

  LoginModel({required this.token, required this.user});

  factory LoginModel.fromJson(Map<String, dynamic> JsonData) {
    return LoginModel(
      token: JsonData[ApiKeys.token],
      user: JsonData[ApiKeys.user],
    );
  }
}
