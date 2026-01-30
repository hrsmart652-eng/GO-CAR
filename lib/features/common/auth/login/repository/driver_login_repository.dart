import 'package:dartz/dartz.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/services/errors/exceptions.dart';
import 'package:go_car/features/common/auth/login/models/login_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class DriverLoginRepository {
  final ApiConsumer api;

  DriverLoginRepository(this.api);

  Future<Either<String, LoginModel>> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        EndPoint.signIn,
        data: {ApiKeys.email: email, ApiKeys.password: password},
      );
      CacheHelper().saveData(key: ApiKeys.password, value: password);

      final driver = LoginModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(driver.token);
      print('my Id is ${decodedToken['id']}');
      print('my password is ${CacheHelper().getData(key: ApiKeys.password)}');

      CacheHelper().saveData(key: ApiKeys.token, value: driver.token);
      CacheHelper().saveData(key: ApiKeys.id, value: decodedToken[ApiKeys.id]);

      return right(driver);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }
}
