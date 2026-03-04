import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';

import '../../normal_ride/model/ride_accepted_model.dart';

class ScheduledRideResponse {
  final bool? success;
  final String? message;
  final double? price;
  final double? distanceKm;
  final ScheduledRideModel? trip;

  ScheduledRideResponse({
    this.success,
    this.message,
    this.price,
    this.distanceKm,
    this.trip,
  });

  factory ScheduledRideResponse.fromJson(Map<String, dynamic> json) {
    return ScheduledRideResponse(
      success: json["success"],
      message: json["message"],
      price: (json["price"] ?? 0).toDouble(),
      distanceKm: (json["distanceKm"] ?? 0).toDouble(),
      trip:
          json["trip"] != null
              ? ScheduledRideModel.fromJson(json["trip"])
              : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "success": success,
      "message": message,
      "price": price,
      "distanceKm": distanceKm,
      "trip": trip?.toJson(),
    };
  }
}

class ScheduledRideModel {
  String? userId;
  String? carType;
  int? passengerNo;
  int? luggageNo;
  Map<String, dynamic> currentLocation;
  Map<String, dynamic> destination;
  String? scheduledAt;
  String? paymentMethod;
  String? tripCode;
  String? status;
  double? price;
  String? driverShift;
  String? tripId;

  ScheduledRideModel({
    required this.userId,
    required this.carType,
    required this.passengerNo,
    required this.luggageNo,
    required this.currentLocation,
    required this.destination,
    required this.scheduledAt,
    required this.paymentMethod,
    required this.price,
    required this.tripCode,
    required this.status,
    required this.driverShift,
    required this.tripId,
  });

  factory ScheduledRideModel.fromJson(Map<String, dynamic> jsonData) {
    return ScheduledRideModel(
      userId: jsonData['client'] ?? "",
      carType: jsonData['carType'] ?? "Economy",
      passengerNo: jsonData['passengerNo'] ?? 1,
      luggageNo: jsonData['luggageNo'] ?? 0,
      currentLocation: jsonData['currentLocation'] ?? {},
      destination: jsonData['destination'] ?? {},
      tripCode:jsonData['tripCode']??"",
      scheduledAt: jsonData['scheduledAt']?.toString(),
      paymentMethod: jsonData['paymentInfo']?['method'] ?? "",
      status: jsonData['status'] ?? "",
      price: (jsonData['price'] ?? 0).toDouble(),
      driverShift: jsonData["driverShift"] ?? "",
      tripId: jsonData['_id'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "client": userId,
      "carType": carType,
      "passengerNo": passengerNo,
      "luggageNo": luggageNo,
      "currentLocation": {
        "type": "Point",
        "coordinates": currentLocation["coordinates"],
      },

      "destination": {
        "type": "Point",
        "coordinates": destination["coordinates"],
      },

      "scheduledAt": scheduledAt,
      "paymentMethod": paymentMethod,
      "price": price,
      'tripCode':tripCode,
      "status": status,
      "driverShift": driverShift,
      "_id": tripId,
    };
  }

  // mapper from schduleModel to TripStatusModel
  TripStatusModel toTripStatusModel() {
    return TripStatusModel(
      id: tripId,
      status: status,
      price: price,
      carType: carType,
      luggageNo: luggageNo,
      passengerNo: passengerNo,
      client: userId,
      v: 0,
      createdAt: DateTime.now(),
      scheduledAt: DateTime.now(),
      updatedAt: DateTime.now(),
      tripCode: CacheHelper().getData(key: ApiKeys.tripCode),
      driverId: CacheHelper().getData(key: ApiKeys.clientId),
      paymentInfo:
          paymentMethod == "cash"
              ? PaymentInfo(method: "cash", status: "pending")
              : PaymentInfo(method: "credit", status: "pending"),
    );
  }
}
