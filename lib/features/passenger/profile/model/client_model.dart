class ReviewModel {
  final String id;
  final String? driver;
  final int? rating;
  final String? comment;

  ReviewModel({
    required this.id,
    required this.driver,
    required this.rating,
    this.comment,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id: json['_id']??"",
      driver: json['driver']??"",
      rating: json['rating']??0,
      comment: json['comment']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'driver': driver,
      'rating': rating,
      'comment': comment,
    };
  }
}


class ClientModel {
  final String id;
  final String? fullName;
  final String? phoneNumber;
  final String? email;
  final String? role;
  final String? invitationCode;
  final bool isActive;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<ReviewModel> reviews;
  final String? image;

  ClientModel({
    required this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.email,
    required this.role,
    required this.invitationCode,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    required this.reviews,
    required this.image,
  });

  factory ClientModel.fromJson(Map<String, dynamic> json) {
    return ClientModel(
      id: json['_id']??"",
      fullName: json['fullName']??"",
      phoneNumber: json['phoneNumber']??"",
      email: json['email']??"",
      role: json['role']??"",
      invitationCode: json['invitationCode']??"",
      isActive: json['isActive']??false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),

      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : DateTime.now(),

      reviews: (json['reviews'] as List<dynamic>? ?? [])
          .map((e) => ReviewModel.fromJson(e))
          .toList(),
      image: json['image']??"",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'email': email,
      'role': role,
      'invitationCode': invitationCode,
      'isActive': isActive,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'reviews': reviews.map((e) => e.toJson()).toList(),
      'image': image??"",
    };
  }
}