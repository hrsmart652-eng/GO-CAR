class DriverModel {
  final String id;
  final String fullName;
  final String password;
  final String phoneNumber;
  final String email;
  final String licenseImage;
  final dynamic image;
  final bool acceptCash;
  final List<TripModel> trips; // ✅ strongly typed

  DriverModel({
    this.image,
    required this.id,
    required this.fullName,
    required this.password,
    required this.phoneNumber,
    required this.email,
    required this.licenseImage,
    required this.acceptCash,
    required this.trips,
  });

  factory DriverModel.fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['_id'].toString(),
      fullName: json['fullName'].toString(),
      password: json['password']?.toString() ?? '',
      phoneNumber: json['phoneNumber']?.toString() ?? '',
      email: json['email']?.toString() ?? '',
      licenseImage: json['licenseImage']?.toString() ?? '',
      acceptCash: json['acceptCash'] ?? false,
      trips:
          (json['trips'] as List? ?? [])
              .map((trip) => TripModel.fromJson(trip as Map<String, dynamic>))
              .toList(),
      image: json['image'],
    );
  }
}

class TripModel {
  final String method;
  final String status;
  final String paymentStatus;
  final String price;
  final String time;

  TripModel({
    required this.method,
    required this.status,
    required this.paymentStatus,
    required this.price,
    required this.time,
  });

  factory TripModel.fromJson(Map<String, dynamic> json) {
    return TripModel(
      method: json['paymentInfo']?['method']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      paymentStatus: json['paymentInfo']?['status']?.toString() ?? '',
      price: json['price']?.toString() ?? '',
      time: json['createdAt']?.toString() ?? '',
    );
  }
}
