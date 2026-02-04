final class DriverRideModel {
  final String id;
  final String carType;
  final String driverId;
  final String passengerId;
  final String status;
  final String createdAt;
  final String updatedAt;

  DriverRideModel({
    required this.id,
    required this.carType,
    required this.status,
    required this.driverId,
    required this.passengerId,

    required this.createdAt,
    required this.updatedAt,
  });

  factory DriverRideModel.fromJson(Map<String, dynamic> json) {
    return DriverRideModel(
      id: json['id'].toString(),
      carType: json['carType'].toString(),
      driverId: json['driverId'].toString(),
      passengerId: json['passengerId'].toString(),
      status: json['status'].toString(),
      createdAt: json['createdAt'].toString(),
      updatedAt: json['updatedAt'].toString(),
    );
  }
}
