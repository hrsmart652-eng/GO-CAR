class NormalRideModel {
  final bool success;
  final String message;
  final double price;
  final double distanceKm;
  final Map<String, dynamic> trip;
  final String id;

  NormalRideModel({
    required this.success,
    required this.message,
    required this.price,
    required this.distanceKm,
    required this.trip,
    required this.id,
  });

  factory NormalRideModel.fromJson(Map<String, dynamic> jsonData) {
    return NormalRideModel(
      success: jsonData['success'],
      message: jsonData['message'],
      price: jsonData['price'],
      distanceKm: jsonData['distanceKm'],
      trip: jsonData['trip'],
      id: jsonData['_id'],
    );
  }
}
