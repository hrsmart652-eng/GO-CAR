import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class CustomTextFieldValidator extends StatelessWidget {
 final  Function(String)? validator;
  final TextEditingController controller;
  final String fieldTitle;
  final IconButton? suffixIcon;
  final bool isTextScure;

  const CustomTextFieldValidator({
    this.validator,
    super.key,
    required this.controller,
    required this.fieldTitle,
    this.suffixIcon,
    this.isTextScure = false,}
     
  );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.0.h),
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
      
          TextField(
            controller: controller,
            obscureText: isTextScure,
           onSubmitted: (value) {
        return validator!(value); 
      },
            decoration: InputDecoration(
              fillColor: Colors.white,
              filled: true,
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