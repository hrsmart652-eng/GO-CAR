class DriverUpdateModel {
  final String id;
  final String fullName;
  final String phoneNumber;
  final String password;
  final image;

  DriverUpdateModel({
    this.image,
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.password,
  });

  factory DriverUpdateModel.fromJson(Map<String, dynamic> json) {
    return DriverUpdateModel(
      id: json['_id'],
      fullName: json['fullName'],
      phoneNumber: json['phoneNumber'] as String,
      password: json['password'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    '_id': id,
    'fullName': fullName,
    'phoneNumber': phoneNumber,
    'password': password,
  };
}
