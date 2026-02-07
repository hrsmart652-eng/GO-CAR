

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../cubit/client_profile_cubit.dart';

class CustomEditProfilePhone extends StatelessWidget {
  const CustomEditProfilePhone({
    super.key,
    required this.clientProfileCubit,
  });

  final ClientProfileCubit clientProfileCubit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70.h,
      child: IntlPhoneField(
        controller: clientProfileCubit.phoneController,
        pickerDialogStyle: PickerDialogStyle(
          countryNameStyle: const TextStyle(
            color: Colors.black,
          ),
          countryCodeStyle: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        dropdownTextStyle: const TextStyle(color: Colors.black),
        dropdownDecoration: const BoxDecoration(),
        style: const TextStyle(color: Colors.black),
        autovalidateMode: AutovalidateMode.disabled,
        decoration: InputDecoration(
          fillColor: Colors.white,
          filled: true,
          labelText: 'Phone Number',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: Color(0xFFD0D5DD),
              width: 1,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: Color(0xFFD0D5DD),
              width: 1,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.r),
            borderSide: const BorderSide(
              color: Color(0xFF266FFF),
              width: 1.5,
            ),
          ),
        ),
        initialCountryCode: 'EG',
        onChanged: (phone) {
          clientProfileCubit.phoneController.text =
              phone.number;
        },
      ),
    );
  }
}
