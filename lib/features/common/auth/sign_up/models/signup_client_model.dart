import 'package:go_car/core/services/api/end_points.dart';

class SignupClientModel {
    final String message;

  SignupClientModel({required this.message});

  factory SignupClientModel.fromJson(Map<String, dynamic> JsonData) {
    return SignupClientModel(message: JsonData[ApiKeys.message]);
  }
}

