import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:go_car/features/common/auth/sign_up/models/signup_client_model.dart';
import 'package:go_car/features/common/auth/sign_up/repository/client_signup_repository.dart';
import 'package:image_picker/image_picker.dart';

part 'client_signup_state.dart';

class ClientSignupCubit extends Cubit<ClientSignupCubitDartState> {
  ClientSignupRepository clientSignupRepository;
  ClientSignupCubit({required this.clientSignupRepository})
    : super(ClientSignupCubitDartInitial());

  //Sign Up Form key
  GlobalKey<FormState> signUpFormKey = GlobalKey();
  //license
  XFile? license;
  //Sign up name
  TextEditingController signUpName = TextEditingController();
  //Sign up email
  TextEditingController signUpEmail = TextEditingController();
  //Sign up phone number
  TextEditingController signUpPhoneNumber = TextEditingController();
  //Sign up phone number
  TextEditingController signUpInvitationCode = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();
  late SignupClientModel signInModel;
  void signUp() async {
    emit(ClientSignupCubitLooding());
    final response = await clientSignupRepository.signUp(
      fullName: signUpName.text,
      email: signUpEmail.text,
      phoneNumber: signUpPhoneNumber.text,
      password: signUpPassword.text,
      invitationCode: signUpInvitationCode.text,
      confirmationPassword: confirmPassword.text,
    );
    Future.delayed(const Duration(seconds: 2), () {
      // Here you would typically call the repository to perform the sign-up
      // For now, we simulate success
      emit(ClientSignupCubitSuccess());
    });

    response.fold(
      (errorMessage) =>
          emit(ClientSignupCubitFailure(errMessage: errorMessage)),
      (SignUpClientModel) => emit(ClientSignupCubitSuccess()),
    );
  }
}
