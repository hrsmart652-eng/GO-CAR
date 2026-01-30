import 'package:dartz/dartz.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/services/errors/exceptions.dart';
import 'package:go_car/features/driver/authentication/sign_up/functions/upload_image_to_api.dart';
import 'package:go_car/features/driver/authentication/sign_up/models/signup_model.dart';
import 'package:image_picker/image_picker.dart';

class DriverSignupRepository {
  final ApiConsumer Api;

  DriverSignupRepository({required this.Api});

  Future<Either<String, SignUpModel>> signUp(
    String name,
    String phone,
    String email,
    String password,
    String companyNumber,
    // String role,
    String invitationCode,
    XFile? license,
  ) async {
    try {
      final response = await Api.post(
        EndPoint.signUpDriver,
        isFormData: true,
        data: {
          ApiKeys.name: name,
          ApiKeys.phoneNumber: phone,
          ApiKeys.companyNumber: companyNumber,
          ApiKeys.invitationCode: invitationCode,
          // ApiKeys.role: 'driver',
          ApiKeys.password: password,
          ApiKeys.email: email,

          ApiKeys.license: await UploadImageToApi(license!),
        },
      );

      final signUpModel = SignUpModel.fromJson(response!);
      return right(signUpModel);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }
}
