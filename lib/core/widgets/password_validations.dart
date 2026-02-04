import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PasswordValidations extends StatelessWidget {
  const PasswordValidations({
    super.key,
    required this.hasMinLength,
    required this.hasUppercase,
    required this.hasNumber,
  });

  final bool hasMinLength;
  final bool hasUppercase;
  final bool hasNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow("Between 8 and 20 characters", hasMinLength),
        SizedBox(height: 2.h),
        buildValidationRow("At least 1 uppercase letter", hasUppercase),
        SizedBox(height: 2.h),
        buildValidationRow("1 or more numbers", hasNumber),
        SizedBox(height: 2.h),
      ],
    );
  }
}

Widget buildValidationRow(String text, bool haseValidated) {
  return Row(
    children: [
      Icon(
        Icons.check_circle,
        size: 16,
        color: haseValidated ? Color(0xFF040404) : Color(0xFF475467),
      ),

      SizedBox(width: 6.w),
      Text(
        text,
        style: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: haseValidated ? Color(0xFF040404) : Color(0xFF475467),
        ),
      ),
    ],
  );
}

class AppRegex {
  static bool isPasswordValid(String password) {
    return RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$',
    ).hasMatch(password);
  }

  static bool hasUppercase(String password) {
    return RegExp(r'^(?=.*[A-Z])').hasMatch(password);
  }

  static bool hasNumber(String password) {
    return RegExp(r'^(?=.*?[0-9])').hasMatch(password);
  }

  static bool hasMinLength(String password) {
    return RegExp(r'^(?=.{8})').hasMatch(password);
  }
}
