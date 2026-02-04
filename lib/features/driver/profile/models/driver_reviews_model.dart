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
      reviews:
          (json['reviews'] as List)
              .map((item) => Review.fromJson(item))
              .toList(),
    );
  }
}

class Review {
  final String tripCode;
  final int rating;
  final String review;
  final DateTime date;

  Review({
    required this.tripCode,
    required this.rating,
    required this.review,
    required this.date,
  });

  factory Review.fromJson(Map<String, dynamic> json) {
    return Review(
      tripCode: json['tripCode'],
      rating: json['rating'],
      review: json['review'],
      date: DateTime.parse(json['date']),
    );
  }
}
