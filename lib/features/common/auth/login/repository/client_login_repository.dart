import 'package:dartz/dartz.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/dio_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/common/auth/login/models/client_login_model.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ClientLoginRepository {
  final ApiConsumer api;

  ClientLoginRepository(DioConsumer dioConsumer, {required this.api});
  Future<Either<String, ClientLoginModel>> loginIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.post(
        isFormData: false,
        EndPoint.signIn,
        data: {ApiKeys.email: email, ApiKeys.password: password},
      );
      final clientLoginModel = ClientLoginModel.fromJson(response);
      final decodedToken = JwtDecoder.decode(clientLoginModel.token);
      print('my Id is ${decodedToken['id']}');
      CacheHelper().saveData(key: ApiKeys.token, value: clientLoginModel.token);
      CacheHelper().saveData(key: ApiKeys.id, value: decodedToken[ApiKeys.id]);
      return Right(clientLoginModel);
    } catch (error) {
      return Left(error.toString());
    }
  }
}
