import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    this.controller,
    this.hint,
    required this.fieldTitle,
    this.suffixIcon,
    this.isTextSecure = false,
    this.padding,
    this.validator,
  });

  final TextEditingController? controller;
  final String fieldTitle;
  final String? hint;
  final double? padding;
  final IconButton? suffixIcon;
  final bool isTextSecure;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: padding ?? 10.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Text(
            fieldTitle,
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF344054),
            ),
          ),
          SizedBox(height: 8.h),

          TextFormField(
            validator: validator,
            controller: controller,
            obscureText: isTextSecure,
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
              hintText: hint,
              hintStyle: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF121212),
              ),
              // labelText: fieldTitle,
              suffixIcon: suffixIcon,

              border: OutlineInputBorder(
                borderSide: BorderSide(color: Color(0xFFD0D5DD), width: 1),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Color(0xFFD0D5DD), width: 1),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide(color: Color(0xFFD0D5DD), width: 1),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
