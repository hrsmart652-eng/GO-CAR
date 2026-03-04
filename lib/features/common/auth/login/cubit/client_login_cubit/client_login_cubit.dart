import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/common/auth/login/models/client_login_model.dart';
import 'package:go_car/features/common/auth/login/repository/client_login_repository.dart';

part 'client_login_state.dart';

class ClientLoginCubit extends Cubit<ClientLoginState> {
  ClientLoginCubit({required this.clientLoginRepository})
    : super(ClientLoginInitial());
  ClientLoginRepository clientLoginRepository;

  GlobalKey<FormState> loginInFormKey = GlobalKey();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  UserLoginModel? user;

  logIn() async {
    emit(ClientLoginLoading());
    try {
      final result = await clientLoginRepository.loginIn(
        email: emailController.text,
        password: passwordController.text,
      );
      result.fold(
        (error) {
          user = null;
          emit(ClientLoginFailure(errMessage: 'Login failed: $error'));
        },
        (clientLoginModel) {
          print('Login successful: ${clientLoginModel.token}');

          user = clientLoginModel;
         CacheHelper().saveData(key:ApiKeys.clientId, value:clientLoginModel.user.id);
          // CacheHelper().saveData(
          //   key: ApiKeys.id,
          //   value: clientLoginModel.user.id,
          // );
          emit(ClientLoginSuccess());
          // Navigate to home or other screen
        },
      );
    } catch (e) {
      print('Login User Id: ${user?.user.id}');
      emit(ClientLoginFailure(errMessage: 'An error occurred: $e'));
      print('Login error: $e');
    }
  }

  getClientProfile() {}

  // void logout() async {
  //   user = null;
  //   await CacheHelper.sharedPreferences.clear();
  //   await sl.reset();
  //   init();
  //   emit(ClientLoginInitial());
  // }
}
