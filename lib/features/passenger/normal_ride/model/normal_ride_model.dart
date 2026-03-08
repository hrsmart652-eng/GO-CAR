import 'package:go_car/features/driver/profile/models/driver_model.dart';
import 'package:go_car/features/passenger/normal_ride/model/ride_accepted_model.dart';
import 'package:go_car/features/passenger/profile/model/client_model.dart';

class NormalRideModel {
  final bool? success;
  final String? message;
  final double? price;
  final double? distanceKm;
  final TripModel trip; // trip model


  NormalRideModel({
    required this.success,
    required this.message,
    required this.price,
    required this.distanceKm,
    required this.trip,
  });

  factory NormalRideModel.fromJson(Map<String, dynamic> jsonData) {
    return NormalRideModel(
      success: jsonData['success']??false,
      message: jsonData['message']??"",
      price: jsonData['price']??0.0,
      distanceKm: jsonData['distanceKm']??0.0,
      trip:TripModel.fromJson(jsonData['trip']),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'price': price,
      'distanceKm': distanceKm,
      'trip': trip.toJson(),

    };
  }
}

class TripModel {
  final String? id;
  final String? client;
  final String? carType;
  final int? passengerNo;
  final int? luggageNo;
  final String? scheduledAt;
  final double? price;
  final PaymentInfo paymentInfo;
  final String? tripCode;
  final String? status;
  final DateTime createdAt;
  final DateTime updatedAt;

  TripModel({
    required this.id,
    required this.client,
    required this.carType,
    required this.passengerNo,
    required this.luggageNo,
    this.scheduledAt,
    required this.price,
    required this.paymentInfo,
    required this.tripCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      id: json['_id']??"",
      client: json['client']??"",
      carType: json['carType']??"",
      passengerNo: json['passengerNo']??1,
      luggageNo: json['luggageNo']??0,
      scheduledAt: json['scheduledAt']??"",
      price: (json['price'] as num).toDouble()??0.0,
         paymentInfo: PaymentInfo.fromJson(json['paymentInfo']),
      tripCode: json['tripCode']??"",
      status: json['status']??"",
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'client': client,
      'carType': carType,
      'passengerNo': passengerNo,
      'luggageNo': luggageNo,
      'scheduledAt': scheduledAt,
      'price': price,
      'paymentInfo': paymentInfo.toJson(),
      'tripCode': tripCode,
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
