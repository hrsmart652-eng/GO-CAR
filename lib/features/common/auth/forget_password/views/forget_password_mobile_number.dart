import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/custom_elevated_btn.dart';

class ForgetPasswordMobileNumber extends StatelessWidget {
  const ForgetPasswordMobileNumber({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController phoneController = TextEditingController();

    return Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: SingleChildScrollView(
              child: Column(
                  children: [
                    SizedBox(height: 70.h),
                    Text(
                      "Forget Password",
                      style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff0D3244)),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Please enter your mobile number to send you a \nvarication code",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xff121212)),
                    ),
                    SizedBox(height: 30.h),

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
                        showCountryFlag: true,
                        controller: phoneController,
                        pickerDialogStyle: PickerDialogStyle(
                          countryNameStyle: TextStyle(color: Colors.black),
                        ),
                        dropdownTextStyle: TextStyle(color: Colors.black),
                        dropdownDecoration: BoxDecoration(),
                        style: TextStyle(color: Colors.black),
                        autovalidateMode: AutovalidateMode.disabled,
                        decoration: InputDecoration(
                          suffix: CircleAvatar(
                            radius: 8.r,
                            backgroundColor: Color(0xFF027A48),
                            child: SvgPicture.asset("assets/images/check.svg"),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                          // labelText: 'Phone Number',
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
                          print(phone.completeNumber);
                        },

                      ),
                    ),

                    SizedBox(height: 320.h),
                    CustomElevatedBtn(btnName: "Send", onPressed: (){
                      Navigator.pushNamed(context, Routes.otpPassword);
                    }),
                  ]),
            )));

  }
}