import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/common/auth/login/models/user_model.dart';

class UserLoginModel {
  final String token;
  final UserModel user;

  UserLoginModel({required this.token, required this.user});

  factory UserLoginModel.fromJson(Map<String, dynamic> JsonData) {
    return UserLoginModel(
      token: JsonData[ApiKeys.token],
      user: UserModel.fromJson(JsonData[ApiKeys.user]),
    );
  }
}
