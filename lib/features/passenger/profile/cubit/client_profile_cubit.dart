import 'dart:convert';

import 'package:dartz/dartz.dart';
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
 // variables
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final ClientProfileRepository profileRepository;
  // instance from Client Cubit
  static ClientProfileCubit of(context)=>BlocProvider.of(context);


  ClientProfileCubit({required this.profileRepository})
    : super(ClientProfileInitial()){
    getClientProfile();
  }
  ClientModel? clientModel;

  Future<void> getClientProfile() async {
    emit(ClientProfileLoading());
    final response = await profileRepository.getClientProfile();
    debugPrint("====================Response Cubit: $response==========================");

    response.fold(
          (errorMessage) {
        debugPrint(" Error: $errorMessage");
        emit(ClientProfileFailure(errMessage: errorMessage));
      },(profileModel) async {
        clientModel = profileModel;
        nameController.text = profileModel.fullName ?? "";
        phoneController.text = profileModel.phoneNumber ?? "";

        try {
          await CacheHelper.sharedPreferences.setString(
            'cached_profile',
            jsonEncode(profileModel.toJson()),
          );
          debugPrint("Profile saved to cache");
        } catch (e) {
          debugPrint(" Error saving to cache: $e");
        }

        debugPrint("=====================Profile Data: ${profileModel.toJson()}==========================");
        emit(ClientProfileSuccess(clientModel: profileModel));
      },
    );
  }

  // Future<void> logout() async {
  //   user = null;
  //   await CacheHelper.sharedPreferences.clear();
  //   emit(ClientProfileInitial());
  // }

  Future<void> clientLogout(BuildContext context) async {
    // clear token + id
    await CacheHelper.sharedPreferences.remove(ApiKeys.token);
    await CacheHelper.sharedPreferences.remove(ApiKeys.id);
    // final loginCubit = context.read<DriverLoginCubit>();
    nameController.clear();
    phoneController.clear();
    // loginCubit.signInEmail.clear();
    // loginCubit.signInPassword.clear();


  }

  clientProfileUpdate(String? name, String? phoneNumber) async {
    emit(ClientProfileLoading());
    final response = await profileRepository.clientProfileUpdate(
      name: nameController.text,
      phoneNumber: phoneController.text,
    );
    response.fold(
      (errorMessage) => emit(ClientProfileFailure(errMessage: errorMessage)),
      (profileModel) {
        clientModel = profileModel;
        nameController.text = profileModel.fullName ?? '';
        phoneController.text = profileModel.phoneNumber ?? '';
        CacheHelper.sharedPreferences.setString('cached_profile',jsonEncode(profileModel.toJson()),);
        emit(ClientProfileSuccess(clientModel: profileModel));
      }
    );
  }

  Future<void> setProfilePic(XFile image) async {
    emit(ClientProfileLoading());

    final result = await profileRepository.changeProfilePic(
      profilePicture: image,
    );

    result.fold(
          (error) {
        emit(ClientProfileFailure(errMessage: error.toString()));
      },
          (client) {
            clientModel= client;
        emit(ClientProfileSuccess(clientModel: client));
      },
    );
  }

}
