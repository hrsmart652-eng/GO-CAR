final class NewTripModel {
  final String id;
  final String carType;
  final int? price;
  final int passengerNo;
  final int luggageNo;
  final String status;
  final String method;
  final String paymentStatus;
  final List<Client>? client;

  NewTripModel({
    required this.id,
    required this.carType,
    required this.price,
    required this.passengerNo,
    required this.luggageNo,
    required this.status,
    required this.method,
    required this.paymentStatus,
    required this.client,
  });

  factory NewTripModel.fromJson(Map<String, dynamic> json) {
    return NewTripModel(
      id: json['_id'].toString(),
      carType: json['carType'].toString(),
      price: json['price'] == null ? 2 : json['price'].toInt(),
      passengerNo: json['passengerNo'].toInt(),
      luggageNo: json['luggageNo'].toInt(),
      status: json['status'].toString(),
      paymentStatus: json['paymentInfo']['status'].toString(),
      method: json['paymentInfo']['method'].toString(),
      client:
          json['client'] == null
              ? []
              : (json['client'] is List
                  ? (json['client'] as List)
                      .map((item) => Client.fromJson(item))
                      .toList()
                  : [Client.fromJson(json['client'])]),
    );
  }
}

class Client {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? image;

  Client({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.image,
  });

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'].toString(),
      name: json['fullName'].toString(),
      email: json['email'].toString(),
      phone: json['phoneNumber'].toString(),
      image: json['image'] as String?,
    );
  }
}
