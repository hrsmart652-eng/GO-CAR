import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/features/driver/authentication/sign_up/repositories/driver_signup_repository.dart';
import 'package:image_picker/image_picker.dart';

import 'driver_signup_state.dart';

class DriverSignUpCubit extends Cubit<DriverSignUpState> {
  DriverSignUpCubit(this.signupRepository) : super(DriverSignUpInitial());
  final DriverSignupRepository signupRepository;

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
  TextEditingController signUpCompanyNumber = TextEditingController();
  //Sign up phone number
  TextEditingController signUpInvitationCode = TextEditingController();
  //Sign up password
  TextEditingController signUpPassword = TextEditingController();
  //Sign up confirm password
  TextEditingController confirmPassword = TextEditingController();

  uploadLicense(XFile image) {
    license = image;
    emit(UploadLicense());
  }

  @override
  Future<void> close() {
    signUpName.dispose();
    signUpEmail.dispose();
    signUpPhoneNumber.dispose();
    signUpCompanyNumber.dispose();
    signUpInvitationCode.dispose();
    signUpPassword.dispose();
    confirmPassword.dispose();
    return super.close();
  }

  signUp() async {
    emit(DriverSignUpLoading());
    final response = await signupRepository.signUp(
      signUpName.text,
      signUpPhoneNumber.text,
      signUpEmail.text,
      signUpPassword.text,
      signUpCompanyNumber.text,
      signUpInvitationCode.text,
      license!,
    );

    // print(license);
    print("license image");
    response.fold(
      (errorMessage) => emit(DriverSignUpFailure(errMessage: errorMessage)),
      (SignUpModel) => emit(DriverSignUpSuccess(message: SignUpModel.message)),
    );
  }
}
