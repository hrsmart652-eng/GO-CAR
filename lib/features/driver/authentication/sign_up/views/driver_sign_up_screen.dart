import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/features/driver/authentication/sign_up/cubit/driver_signup_cubit.dart';
import 'package:go_car/features/driver/authentication/sign_up/cubit/driver_signup_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_elevated_btn.dart';
import '../../../../../core/widgets/custom_text_field.dart';

class DriverSignUpScreen extends StatefulWidget {
  const DriverSignUpScreen({super.key});

  @override
  State<DriverSignUpScreen> createState() => _DriverSignUpScreenState();
}

class _DriverSignUpScreenState extends State<DriverSignUpScreen> {
  bool isPasswordVisible = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverSignUpCubit, DriverSignUpState>(
      listener: (context, state) {
        if (state is DriverSignUpSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        } else if (state is DriverSignUpFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder:
          (context, state) => Scaffold(
            appBar: customAppBar(title: "Personal Info"),
            backgroundColor: Colors.white,
            body: Form(
              key: context.read<DriverSignUpCubit>().signUpFormKey,
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: 40.0.w,
                    right: 16.w,
                    left: 16.w,
                  ),

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
                        controller:
                            context.read<DriverSignUpCubit>().signUpName,
                        fieldTitle: 'Full Name',
                      ),

                      //---------------------  Email field ---------------
                      CustomTextField(
                        controller:
                            context.read<DriverSignUpCubit>().signUpEmail,
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
                          //     context
                          //         .read<DriverSignUpCubit>()
                          //         .signUpPhoneNumber,
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
                                .read<DriverSignUpCubit>()
                                .signUpPhoneNumber
                                .text = phone.completeNumber;
                          },
                        ),
                      ),

                      //---------------------  company number button ---------------------
                      CustomTextField(
                        fieldTitle: 'Company number',
                        controller:
                            context
                                .read<DriverSignUpCubit>()
                                .signUpCompanyNumber,
                      ),
                      //---------------------  invitation code button ---------------------
                      CustomTextField(
                        fieldTitle: 'Invitation code',
                        controller:
                            context
                                .read<DriverSignUpCubit>()
                                .signUpInvitationCode,
                      ),

                      //---------------------  password field ---------------------
                      CustomTextField(
                        controller:
                            context.read<DriverSignUpCubit>().signUpPassword,
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
                        controller:
                            context.read<DriverSignUpCubit>().confirmPassword,
                        fieldTitle: 'Confirm Password',
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

                      //---------------------  upload photo button ---------------------
                      SizedBox(height: 10.h),

                      Row(
                        children: [
                          Text(
                            'Upload Photos',
                            style: TextStyle(
                              color: Color(0xFF121212),
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            '“Supported formats: Png , Jpeg”',
                            style: TextStyle(
                              color: Color(0xFF121212),
                              fontSize: 12,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: DottedBorder(
                          color: Color(0xffD0D5DD),
                          dashPattern: [4, 4],
                          strokeWidth: 1,
                          child: Container(
                            padding: EdgeInsets.all(8),
                            width: 343.w,
                            height: 100.h,
                            child:
                                context.read<DriverSignUpCubit>().license ==
                                        null
                                    ? Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Upload Driver’s license from your Gallery',
                                          style: TextStyle(
                                            color: Color(0xFF121212),
                                            fontSize: 14,
                                            fontWeight: FontWeight.w300,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () async {
                                            await ImagePicker()
                                                .pickImage(
                                                  source: ImageSource.gallery,
                                                )
                                                .then(
                                                  (value) => context
                                                      .read<DriverSignUpCubit>()
                                                      .uploadLicense(value!),
                                                );
                                          },
                                          // uploadLicense,
                                          style: ButtonStyle(
                                            backgroundColor:
                                                WidgetStateProperty.all(
                                                  Color(0xff266FFF),
                                                ),
                                            shape: WidgetStateProperty.all(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.0),
                                              ),
                                            ),
                                          ),
                                          icon: Icon(
                                            Icons.add,
                                            size: 30,
                                            weight: 20,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                    : Container(
                                      child: Image.file(
                                        File(
                                          context
                                              .read<DriverSignUpCubit>()
                                              .license!
                                              .path,
                                        ),
                                      ),
                                    ),
                          ),
                        ),
                      ),

                      //---------------------  next button ---------------------
                      SizedBox(height: 20.h),

                      state is DriverSignUpLoading
                          ? CircularProgressIndicator()
                          : CustomElevatedBtn(
                            onPressed: () {
                              context.read<DriverSignUpCubit>().signUp().then((
                                _,
                              ) {
                                Navigator.pushReplacementNamed(
                                  context,
                                  Routes.login,
                                );
                              });
                              // Navigator.pushNamed(
                              //   context,
                              //   Routes.phoneNumberOtp,
                              // );
                            },
                            btnName: 'Next',
                          ),

                      SizedBox(height: 36.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
