class TripStatusModel {
  final String? id; //
  final String? client;
  final String? carType; //
  final int? passengerNo; //
  final int? luggageNo;
  final DateTime? scheduledAt;
  final String? tripCode;
  final String? status;
  final double? price;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final int? v;
  final String? driverId;
  final int? rating;
  final String? review;
  final PaymentInfo? paymentInfo;

  TripStatusModel({
    this.id,
    this.client,
    this.carType,
    this.passengerNo,
    this.luggageNo,
    this.scheduledAt,
    this.tripCode,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.price,
    this.driverId,
    this.rating,
    this.review,
    this.paymentInfo,
  });

  // From JSON
  factory TripStatusModel.fromJson(Map<String, dynamic> json) {
    return TripStatusModel(
      id: json['_id']??"",
      client: json['client']??"",
      carType: json['carType']??"",
      passengerNo: json['passengerNo']??1,
      luggageNo: json['luggageNo']??0,
      scheduledAt: json['scheduledAt'] != null
          ? DateTime.tryParse(json['scheduledAt'])
          : null,
      tripCode: json['tripCode']??"",
      status: json['status']??"",
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      v: json['__v'],
      driverId: json['driverId']??"",
      rating: json['rating']??0,
      review: json['review']??"",
      price: json['price']??"",
      paymentInfo: json['paymentInfo'] != null &&
          json['paymentInfo'] is Map<String, dynamic>
          ? PaymentInfo.fromJson(json['paymentInfo'])
          : null,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'client': client,
      'carType': carType,
      'passengerNo': passengerNo,
      'luggageNo': luggageNo,
      'scheduledAt': scheduledAt?.toIso8601String(),
      'tripCode': tripCode,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      '__v': v,
      'price':price,
      'driverId': driverId,
      'rating': rating,
      'review': review,
      'paymentInfo': paymentInfo?.toJson(),
    };
  }
}

class PaymentInfo {
  final String? method;
  final String? status;

  PaymentInfo({
    this.method,
    this.status,
  });

  factory PaymentInfo.fromJson(Map<String, dynamic> json) {
    return PaymentInfo(
      method: json['method']??"",
      status: json['status']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'method': method,
      'status': status,
    };
  }
}
