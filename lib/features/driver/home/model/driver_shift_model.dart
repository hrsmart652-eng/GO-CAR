final class DriverShiftModel {
  final String id;
  final String carType;
  final String? ShiftId;
  DriverShiftModel({required this.id, required this.carType, this.ShiftId});

  factory DriverShiftModel.fromJson(Map<String, dynamic> json) {
    return DriverShiftModel(
      id: json['id'].toString(),
      carType: json['carType'].toString(),
      ShiftId: json['data']['_id'].toString(),
    );
  }
}
