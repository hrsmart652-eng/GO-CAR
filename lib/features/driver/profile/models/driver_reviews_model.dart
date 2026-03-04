class DriverReviewsModel {
  final int totalReviews;
  final String averageRating;
  final List<Review> reviews;

  DriverReviewsModel({
    required this.totalReviews,
    required this.averageRating,
    required this.reviews,
  });

  factory DriverReviewsModel.fromJson(Map<String, dynamic> json) {
    return DriverReviewsModel(
      totalReviews: json['totalReviews'],
      averageRating: json['averageRating'],
      reviews: (json['reviews'] as List)
          .map((e) => Review.fromJson(e))
          .toList(),
    );
  }
}

class Review {
  final String clientName;
  final String tripCode;
  final int rating;
  final String review;
  final DateTime date;

  Review({
    required this.clientName,
    required this.tripCode,
    required this.rating,
    required this.review,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      clientName: json['clientName'],
      tripCode: json['tripCode'],
      rating: json['rating'],
      review: json['review'],
      date: DateTime.parse(json['date']),
    );
  }
}
