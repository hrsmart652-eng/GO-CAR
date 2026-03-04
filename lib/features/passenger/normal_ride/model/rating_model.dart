import 'package:go_car/features/passenger/normal_ride/model/ride_accepted_model.dart';

class RatingModel {
  final String? message;
  final TripStatusModel? trip;

  RatingModel({
    this.message,
    this.trip,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) {
    return RatingModel(
      message: json['message']?.toString(),
      trip: json['trip'] != null && json['trip'] is Map<String, dynamic>
          ? TripStatusModel.fromJson(json['trip'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'trip': trip?.toJson(),
    };
  }
}
