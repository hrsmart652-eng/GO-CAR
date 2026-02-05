import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/common/auth/login/cubit/driver_login_cubit.dart';
import 'package:go_car/features/common/auth/login/models/client_login_model.dart';
import 'package:go_car/features/passenger/profile/model/client_model.dart';
import 'package:go_car/features/passenger/profile/repository/client_profile_repository.dart';
import 'package:image_picker/image_picker.dart';

import 'client_profile_state.dart';

class ClientProfileCubit extends Cubit<ClientProfileState> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  // instance of cubit client
  static ClientProfileCubit of(context) =>
      BlocProvider.of<ClientProfileCubit>(context);

  final ClientProfileRepository profileRepository;

  ClientProfileCubit({required this.profileRepository})
    : super(ClientProfileInitial()) {
    nameController.text = clientModel?.fullName ?? "";
    nameController.text = clientModel?.phoneNumber ?? "";
    getClientProfile();
  }

  ClientModel? clientModel;
  ClientLoginModel? user;

  void loadCachedProfile() {
    final cached = CacheHelper.sharedPreferences.getString('cached_profile');
    if (cached != null) {
      final model = ClientModel.fromJson(jsonDecode(cached));
      emit(ClientProfileSuccess(clientModel: model));
    }
  }


  getClientProfile() async {
    // retrun cached data
    loadCachedProfile();
    emit(ClientProfileLoading());
    final response = await profileRepository.getClientProfile();
    response.fold(
      (errorMessage) => emit(ClientProfileFailure(errMessage: errorMessage)),
      (profileModel) {
        //  clientModel = profileModel;
        CacheHelper.sharedPreferences.setString('cached_profile',jsonEncode(profileModel.toJson()));
        emit(ClientProfileSuccess(clientModel: profileModel));
      },
    );
  }

  // dispose(){
  //   nameController.dispose();
  //   phoneController.dispose();
  // }
  // Future<void> logout() async {
  //   user = null;
  //   await CacheHelper.sharedPreferences.clear();
  //   emit(ClientProfileInitial());
  // }

  Future<void> logout(BuildContext context) async {
    // clear token + id
    await CacheHelper.sharedPreferences.remove(ApiKeys.token);
    await CacheHelper.sharedPreferences.remove(ApiKeys.id);

    final loginCubit = context.read<DriverLoginCubit>();
    loginCubit.signInEmail.clear();
    loginCubit.signInPassword.clear();

    Navigator.pushNamed(context, Routes.login);
  }

  clientProfileUpdate(String? name, String? phoneNumber) async {
    emit(ClientProfileLoading());
    final response = await profileRepository.clientProfileUpdate(
      name: nameController.text,
      phoneNumber: phoneController.text,
    );
    response.fold(
      (errorMessage) => emit(ClientProfileFailure(errMessage: errorMessage)),
      (profileModel) => emit(ClientProfileSuccess(clientModel: profileModel)),
    );
  }

  setProfilePic(XFile image) async {
    emit(ClientProfileLoading());
    final response = await profileRepository.changeProfilePic(
      profilePicture: image,
    );
    response.fold(
      (errorMessage) => emit(ClientProfileFailure(errMessage: errorMessage)),
      (profileModel) => emit(ClientProfileSuccess(clientModel: profileModel)),
    );
  }
}
