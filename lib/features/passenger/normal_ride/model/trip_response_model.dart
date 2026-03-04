
import 'package:go_car/features/passenger/normal_ride/model/ride_accepted_model.dart';

import '../../profile/model/client_model.dart';

class TripResponseModel {
  final PaymentInfo paymentInfo;
  final String id;
  final ClientModel client;
  final String carType;
  final int passengerNo;
  final int luggageNo;
  final String? scheduledAt;
  final double price;
  final String tripCode;
  final String status;
  final String createdAt;
  final String updatedAt;
  final int v;
  final TripDriverModel driver;

  TripResponseModel({
    required this.paymentInfo,
    required this.id,
    required this.client,
    required this.carType,
    required this.passengerNo,
    required this.luggageNo,
    required this.scheduledAt,
    required this.price,
    required this.tripCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.driver,
  });

  factory TripResponseModel.fromJson(Map<String, dynamic> json) {
    return TripResponseModel(
      paymentInfo: PaymentInfo.fromJson(json['paymentInfo']),
      id: json['_id'],
      client: ClientModel.fromJson(json['client']),
      carType: json['carType'],
      passengerNo: json['passengerNo'],
      luggageNo: json['luggageNo'],
      scheduledAt: json['scheduledAt'],
      price: (json['price'] as num).toDouble(),
      tripCode: json['tripCode'],
      status: json['status'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      driver: TripDriverModel.fromJson(json['driverId']),
    );
  }
}

class TripDriverModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String email;
  final String password;
  final String role;
  final String companyNumber;
  final String invitationCode;
  final String licenseImage;
  final String status;
  final bool acceptCash;
  final List<dynamic> trips;
  final String isApproved;
  final String createdAt;
  final String updatedAt;
  final int v;
  final String image;

  TripDriverModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.password,
    required this.role,
    required this.companyNumber,
    required this.invitationCode,
    required this.licenseImage,
    required this.status,
    required this.acceptCash,
    required this.trips,
    required this.isApproved,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.image,
  });

  factory TripDriverModel.fromJson(Map<String, dynamic> json) {
    return TripDriverModel(
      id: json['_id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'],
      email: json['email'],
      password: json['password'],
      role: json['role'],
      companyNumber: json['companyNumber'],
      invitationCode: json['invitationCode'],
      licenseImage: json['licenseImage'],
      status: json['status'],
      acceptCash: json['acceptCash'],
      trips: json['trips'] ?? [],
      isApproved: json['isApproved'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      image: json['image'],
    );
  }
}