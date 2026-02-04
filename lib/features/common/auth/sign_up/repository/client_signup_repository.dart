import 'package:dartz/dartz.dart';
import 'package:go_car/core/services/api/api_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/services/errors/exceptions.dart';
import 'package:go_car/features/common/auth/sign_up/models/signup_client_model.dart';
class ClientSignupRepository {
  final ApiConsumer api;

  ClientSignupRepository({required this.api});

  Future<Either<String, SignupClientModel>> signUp({
    required String fullName,
    required String email,
    required String phoneNumber,
    required String password,
    required String invitationCode,
    required String confirmationPassword,
  }) async {
    // Simulate a network call
    await Future.delayed(const Duration(seconds: 2));

    try {
      final response = await api.post(
        isFormData: false,
        EndPoint.signUpClient,
        data: {
          ApiKeys.name: fullName,
          ApiKeys.phoneNumber: phoneNumber,
          ApiKeys.invitationCode: invitationCode,
          ApiKeys.role: 'client',
          ApiKeys.email: email,
          ApiKeys.password: password,
          ApiKeys.confirmPassword: confirmationPassword,
        },
      );
      final signUpClientModel = SignupClientModel.fromJson(response!);

      return right(signUpClientModel);
    } on ServerException catch (e) {
      return left(e.errorModel.errorMessage);
    }
  }
  // Future<Either<String, String>> verifyEmail(String email) async {
  //   // Simulate a network call
  //   await Future.delayed(const Duration(seconds: 1));

  //   // Here you would typically make an API call to verify the email
  //   // For now, we return a dummy response
  //   return Right("Email verification successful for $email");

  // }
}
