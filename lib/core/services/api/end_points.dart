class EndPoint {
  // Common EndPoints

  static String baseUrl = "https://backendapi-9wqv.onrender.com/api/";
  static String signIn = "auth/login";
  static String uploadImage = "client/upload/image";

  // Driver Api Endpoints

  static String signUpDriver = "driver/register";
  static String newTrip = "driverTrip/newtrips";

  static String getDriver(id) {
    return "driver/getDriver/$id";
  }

  static String getDriverTrips(id) {
    return "trip?userId=$id&role=driver";
  }

  static String deleteDriver(id) {
    return "driver/delete/$id";
  }

  static String driverUpdate(id) {
    return "driver/update/$id";
  }

  static String clientProfileUpdate(id) {
    return "client/update/$id";
  }

  static String driverStartShift = "driverShift/start";
  static String driverEndShift(id) {
    return "driverShift/end/$id";
  }

  static String driverBeOnline(id) {
    return "driver/beOnline/$id";
  }

  static String driverBeOffline(id) {
    return "driver/beOffline/$id";
  }

  static String driverAcceptCash(id) {
    return "driver/acceptCash/$id";
  }

  static String driverRefuseCash(id) {
    return "driver/refuseCash/$id";
  }

  static String driverAcceptTrip(TripId) {
    return "drivertrip/accept/$TripId";
  }

  static String driverInLocationTrip(TripId) {
    return "driverTrip/arrived/$TripId";
  }

  static String driverStartTrip(TripId) {
    return "driverTrip/start/$TripId";
  }

  static String driverEndTrip(TripId) {
    return "driverTrip/end/$TripId";
  }

  static String driverRejectTrip(TripId) {
    return "driverTrip/reject/$TripId";
  }

  static String driverReview(TripId) {
    return "review/add/$TripId";
  }
  static String getAllDriver() {
    return "driver/getAll";
  }

  static String DriverReviews(id) {
    return "review/reviews/driver/$id";
  }
  static String DriverRate(tripId) {
    return "trip/$tripId/rate";
  }
  // Client Api Endpoints

  static String signUpClient = "client/register";

  static String requestTrip = "trip";

  static String cancelTrip(id) {
    return "trip/$id/cancel";
  }

  static String getClient(id) {
    return "client/getClient/$id";
  }

  static String getAllTrips() {
    return "driverTrip/allTrips";
  }

  static String getTrip(userId) {
    return "trip?userId=${userId}&role=driver";
  }

  static String getNewTrip() {
    return "driverTrip/newtrips";
  }
}

class ApiKeys {
  static String status = "success";
  static String message = "message";
  static String token = "token";
  static dynamic user = 'user';
  static dynamic driver = 'data';
  static String name = 'fullName';
  static String password = "password";
  static String confirmPassword = "confirmPassword";
  static String email = "email";
  static String phoneNumber = "phoneNumber";
  static String id = "id";
  static String clientId = "clientId";
  static String driverId = "driverId";
  static String shiftId = "_id";
  static String rating = "rating";
  static String comment = "comment";
  static String role = "role";
  static String license = "licenseImage";
  static String profilePhoto = "image";
  static String companyNumber = "companyNumber";
  static String invitationCode = "invitationCode";
  static String rememberMe = "rememberMe";
  static String index = "index";
  static String carType = "carType";
  static String totalReviews = "totalReviews";
  static String averageRating = "averageRating";
  static String tripCode = "tripCode";
  static String tripId = "_id";
  static String review = "review";
  static String currentLocation = "currentLocation";
  static String destination = "destination";
  static String carTypeImg = "carTypeImg";
  static String date = "date";
  static String allTSchdulerips = "allScheduleTrips";
}
