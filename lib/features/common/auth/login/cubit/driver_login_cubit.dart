import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/common/auth/login/models/login_model.dart';
import 'package:go_car/features/common/auth/login/repository/driver_login_repository.dart';

import 'driver_login_state.dart';

 class DriverLoginCubit extends Cubit<DriverLoginState> {
 DriverLoginCubit(this.loginRepository) : super(DriverLoginInitial());
  final DriverLoginRepository loginRepository;
  //Sign in Form key
  GlobalKey<FormState> signInFormKey = GlobalKey();
  //Sign in email
  TextEditingController signInEmail = TextEditingController();
  //Sign in password
  TextEditingController signInPassword = TextEditingController();

  LoginModel? driver;
  signIn() async {
    emit(DriverSignInLoading());
    final response = await loginRepository.signIn(
      email: signInEmail.text,
      password: signInPassword.text,
    );

    response.fold(
      (errorMessage) => emit(DriverSignInFailure(errMessage: errorMessage)),
      (SignInModel){
        CacheHelper().saveData(key:ApiKeys.id, value:SignInModel.user.id);
        emit(DriverSignInSuccess());
      }
    );
  }
}
