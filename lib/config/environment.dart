enum Environment {
  driver,
  passenger,
}
enum RideType { oneWay, returnRide }

// rating_cubit_interface.dart
// rating_cubit_interface.dart
abstract class RatingCubitInterface {
  double get sliderValue;
  set sliderValue(double value);

  // بدل getters، خليها fields عادية
  List<int> get colors;
  List<String> get ratingDescriptions;
  List<String> get emojiAssets;
  List<String> get ratingTexts;

  Future<void> sendTripReview({required int rating, required String review});
  void resetTrip();
}