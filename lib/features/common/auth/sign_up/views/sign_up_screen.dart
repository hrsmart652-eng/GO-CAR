import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/widgets/custom_app_bar.dart';
import 'package:go_car/core/widgets/custom_elevated_btn.dart';
import 'package:go_car/core/widgets/custom_text_field.dart';
import 'package:go_car/features/common/auth/sign_up/cubit/client_signup_cubit.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool isPasswordVisible = true;
  bool isConfirmPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientSignupCubit, ClientSignupCubitDartState>(
      listener: (context, state) {
        if (state is ClientSignupCubitSuccess) {
          Navigator.pushNamed(context, Routes.login);
        } else if (state is ClientSignupCubitFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: customAppBar(title: "Personal Info"),
          backgroundColor: Colors.white,
          body: Form(
            key: context.read<ClientSignupCubit>().signUpFormKey,
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  children: [
                    //---------------------  car  ---------------------
                    SizedBox(
                      height: 40.h,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Container(
                            height: 6.h,
                            width: 208.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Color(0xFFEAECF0),
                            ),
                          ),
                          Positioned(
                            left: 0,
                            top: -9.h,
                            child: SvgPicture.asset(
                              'assets/images/car_line.svg',
                            ),
                          ),
                        ],
                      ),
                    ),

                    //---------------------  full name field ---------------
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your full name';
                        }
                        return null;
                      },
                      controller: context.read<ClientSignupCubit>().signUpName,
                      fieldTitle: 'Full Name',
                    ),

                    //---------------------  Email field ---------------
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!value.contains('@')) {
                          return 'Please enter a valid email';
                        }
                        return null;
                      },
                      controller: context.read<ClientSignupCubit>().signUpEmail,
                      fieldTitle: 'Email',
                    ),

                    //------------------ Phone Input Field ------------------
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Phone Number',
                        textAlign: TextAlign.start,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF344054),
                        ),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    SizedBox(
                      height: 60.h,
                      child: IntlPhoneField(
                        // controller:
                        // context.read<ClientSignupCubit>().signUpPhoneNumber,
                        pickerDialogStyle: PickerDialogStyle(
                          countryNameStyle: TextStyle(color: Colors.black),
                          countryCodeStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        dropdownTextStyle: TextStyle(color: Colors.black),
                        dropdownDecoration: BoxDecoration(),
                        style: TextStyle(color: Colors.black),
                        autovalidateMode: AutovalidateMode.disabled,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFD0D5DD),
                              width: 1,
                            ),
                          ),

                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: Color(0xFFD0D5DD),
                              width: 1,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            borderSide: BorderSide(
                              color: Color(0xFFD0D5DD),
                              width: 1,
                            ),
                          ),
                        ),
                        initialCountryCode: 'EG',
                        onChanged: (phone) {
                          context
                              .read<ClientSignupCubit>()
                              .signUpPhoneNumber
                              .text = phone.completeNumber;
                        },
                      ),
                    ),

                    ///---------------------  invitation code field ------------
                    CustomTextField(
                      controller:
                      context
                          .read<ClientSignupCubit>()
                          .signUpInvitationCode,
                      fieldTitle: 'invitation code',
                    ),

                    //---------------------  password field ---------------------
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
                        }
                        if (value.length < 6) {
                          return 'Password must be at least 6 characters';
                        }
                        return null;
                      },
                      controller:
                      context.read<ClientSignupCubit>().signUpPassword,
                      fieldTitle: 'Password',
                      isTextSecure: isPasswordVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isPasswordVisible = !isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0xFF98A2B3),
                        ),
                      ),
                    ),

                    //---------------------  confirm password field --------------
                    CustomTextField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value !=
                            context
                                .read<ClientSignupCubit>()
                                .signUpPassword
                                .text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      controller:
                      context.read<ClientSignupCubit>().confirmPassword,
                      fieldTitle: 'Confirm Password',
                      isTextSecure: isConfirmPasswordVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            isConfirmPasswordVisible =
                            !isConfirmPasswordVisible;
                          });
                        },
                        icon: Icon(
                          isConfirmPasswordVisible
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: const Color(0xFF98A2B3),
                        ),
                      ),
                    ),

                    //---------------------  next button ---------------------
                    SizedBox(height: 36.h),
                    CustomElevatedBtn(
                      onPressed: () {
                        if (context
                            .read<ClientSignupCubit>()
                            .signUpFormKey
                            .currentState!
                            .validate()) {
                          log('Form is valid, proceeding with sign up');
                          context.read<ClientSignupCubit>().signUp();
                          // Navigator.pushNamed(context, Routes.login);

                        } else {
                          log('Form is invalid, please check your inputs');
                          return;
                        }
                        log('Sign Up Successful');
                      },

                      btnName: 'Next',
                    ),

                    SizedBox(height: 36.h),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
