import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/common/auth/login/cubit/driver_login_cubit.dart';
import 'package:go_car/features/driver/profile/models/driver_model.dart';
import 'package:go_car/features/driver/profile/repositories/driver_profile_repository.dart';
import 'package:go_car/features/driver/profile/views/driver_profile.dart';
import 'package:image_picker/image_picker.dart';

import 'driver_profile_state.dart';

class DriverProfileCubit extends Cubit<DriverProfileState> {
  //Sign in email
  TextEditingController nameController = TextEditingController();
  //Sign in password
  TextEditingController phoneNumberController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  DriverModel? driverModel;
  DriverProfileCubit(this.profileRepository) : super(DriverProfileInitial());
  final DriverProfileRepository profileRepository;

  static DriverProfileCubit get(context) =>
      BlocProvider.of<DriverProfileCubit>(context);

  getDriverProfile() async {
    emit(DriverProfileLoading());
    final response = await profileRepository.getDriverProfile();

    response.fold(
      (errorMessage) => emit(DriverProfileFailure(errMessage: errorMessage)),
      (profileModel){
        driverModel =profileModel;
        emit(DriverProfileSuccess(driverProfile: profileModel));
        },
    );
  }

  getDriverTrips() async {
    emit(DriverProfileLoading());
    final response = await profileRepository.getDriverTrips();

    response.fold(
      (errorMessage) => emit(DriverProfileFailure(errMessage: errorMessage)),
      (profileModel) => emit(DriverProfileSuccess(driverProfile: profileModel)),
    );
  }

  deleteDriver() async {
    emit(DriverProfileLoading());
    final response = await profileRepository.deleteDriver();
    response.fold(
      (errorMessage) => emit(DriverProfileFailure(errMessage: errorMessage)),
      (profileModel) => emit(DriverProfileSuccess(driverProfile: profileModel)),
    );
  }

  setProfilePic(XFile image) async {
    emit(DriverProfileLoading());
    final response = await profileRepository.setProfilePic(profilepic: image);
    response.fold(
      (errorMessage) => emit(DriverProfileFailure(errMessage: errorMessage)),
      (profileModel) => emit(DriverProfileSuccess(driverProfile: profileModel)),
    );
  }

  DriverUpdate(String? name, String? phoneNumber, String? password) async {
    emit(DriverProfileLoading());
    final response = await profileRepository.driverUpdate(
      name: nameController.text,
      phoneNumber: phoneNumberController.text,
      password: passwordController.text,
    );
    response.fold(
      (errorMessage) => emit(DriverProfileFailure(errMessage: errorMessage)),
      (profileModel) => emit(DriverProfileSuccess(driverProfile: profileModel)),
    );
  }

  Future<void> DriverLogout(BuildContext context) async {
    // clear token + id
    await CacheHelper.sharedPreferences.remove(ApiKeys.token);
    await CacheHelper.sharedPreferences.remove(ApiKeys.id);

    final loginCubit = context.read<DriverLoginCubit>();
    loginCubit.signInEmail.clear();
    loginCubit.signInPassword.clear();

    Navigator.pushNamed(context, Routes.login);
  }
}
