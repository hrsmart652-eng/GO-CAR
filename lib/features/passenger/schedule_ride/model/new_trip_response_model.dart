import '../../../driver/home/model/new_trip_model.dart';
import '../../normal_ride/model/ride_accepted_model.dart';

class NewTripResponseModel {
  final PaymentInfo? paymentInfo;
  final Client? client;
  final String? id;
  final String? carType;
  final int? passengerNo;
  final int? luggageNo;
  final double? price;
  final String? tripCode;
  final String? status;

  final DateTime? createdAt;
  final DateTime? updatedAt;

  NewTripResponseModel({
    this.paymentInfo,
    this.client,
    this.id,
    this.carType,
    this.passengerNo,
    this.luggageNo,
    this.price,
    this.tripCode,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory NewTripResponseModel.fromJson(
      Map<String, dynamic> json) {
    return NewTripResponseModel(
      id: json['_id'],
      paymentInfo: json['paymentInfo'] != null
          ? PaymentInfo.fromJson(json['paymentInfo'])
          : null,
      client: json['client'] != null
          ? Client.fromJson(json['client'])
          : null,
      carType: json['carType'],
      passengerNo: json['passengerNo'],
      luggageNo: json['luggageNo'],
      price: (json['price'] as num?)?.toDouble(),
      tripCode: json['tripCode']?.toString(),
      status: json['status'],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "paymentInfo": paymentInfo?.toJson(),
      "client": client?.toJson(),
      "carType": carType,
      "passengerNo": passengerNo,
      "luggageNo": luggageNo,
      "price": price,
      "tripCode": tripCode,
      "status": status,
      "createdAt": createdAt?.toIso8601String(),
      "updatedAt": updatedAt?.toIso8601String(),
    };
  }
}