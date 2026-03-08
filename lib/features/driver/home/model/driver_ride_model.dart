import '../../../passenger/normal_ride/model/ride_accepted_model.dart';

final class DriverRideModel {
  PaymentInfo? paymentInfo;
  final String? id;
  final String? client;
  final String? carType;
  final int? passengerNo;
  final int? luggageNo;
  dynamic scheduledAt;
  final String? tripCode;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? driverId;
  final int? rating;
  final String? review;

  DriverRideModel({
    required this.paymentInfo,
    required this.id,
    required this.client,
    required this.carType,
    required this.passengerNo,
    required this.luggageNo,
    required this.scheduledAt,
    required this.tripCode,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.driverId,
    required this.rating,
    required this.review,
  });

  factory DriverRideModel.fromJson(Map<String, dynamic> json) {
    return DriverRideModel(
      id: json['_id'].toString(),
      driverId: json['driverId'].toString(),
      status: json['status'].toString(),
      scheduledAt: json['scheduledAt'].toString(),
      updatedAt: json['updatedAt'].toString(),
      createdAt: json['createdAt'].toString(),
      tripCode: json['tripCode'].toString(),
      carType: json['carType'].toString(),
      client: json['client'].toString(),
      luggageNo: json['luggageNo'],
      passengerNo: json['passengerNo'],
      paymentInfo:
          json['paymentInfo'] != null
              ? PaymentInfo.fromJson(json['paymentInfo'])
              : null,
      rating: json['rating'],
      review: json['review'].toString(),
      v: json['__v'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (paymentInfo != null) {
      data['paymentInfo'] = paymentInfo!.toJson();
    }
    data['_id'] = id;
    data['client'] = client;
    data['carType'] = carType;
    data['passengerNo'] = passengerNo;
    data['luggageNo'] = luggageNo;
    data['scheduledAt'] = scheduledAt;
    data['tripCode'] = tripCode;
    data['status'] = status;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = v;
    data['driverId'] = driverId;
    data['rating'] = rating;
    data['review'] = review;
    return data;
  }
}
