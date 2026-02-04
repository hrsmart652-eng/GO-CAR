import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/common/auth/login/models/user_model.dart';

class ClientLoginModel {
  final String token;
  final User user;

  ClientLoginModel({required this.token, required this.user});

  factory ClientLoginModel.fromJson(Map<String, dynamic> JsonData) {
    return ClientLoginModel(
      token: JsonData[ApiKeys.token],
      user: User.fromJson(JsonData[ApiKeys.user]),
    );
  }
}
