import 'package:go_car/features/common/auth/login/models/user_model.dart';

class ScheduledRideModel {
  final String userId;
  final String carType;
  final int passengerNo;
  final int luggageNo;
  final Map<String, dynamic> currentLocation;
  final Map<String, dynamic> destination;
  final String scheduledAt;
  final String paymentMethod;
  final String rideType;
  final double price;
  final String driverShift;

  ScheduledRideModel({
    required this.userId,
    required this.carType,
    required this.passengerNo,
    required this.luggageNo,
    required this.currentLocation,
    required this.destination,
    required this.scheduledAt,
    required this.paymentMethod,
    required this.rideType,
    required this.price,
    required this.driverShift,
  });

  factory ScheduledRideModel.fromJson(Map<String, dynamic> jsonData) {
    return ScheduledRideModel(
      userId: jsonData['userId'],
      carType: jsonData['carType'],
      passengerNo: jsonData['passengerNo'],
      luggageNo: jsonData['luggageNo'],
      currentLocation: jsonData['currentLocation'],
      destination: jsonData['destination'],
      scheduledAt: jsonData['scheduledAt'],
      paymentMethod: jsonData['paymentMethod'],
      rideType: jsonData['rideType'],
      price: jsonData['price'].toDouble(),
      driverShift: jsonData['driverShift'],
    );
  }
}
