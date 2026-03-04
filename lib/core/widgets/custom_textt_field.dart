import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextFieldValidator extends StatelessWidget {
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  final TextEditingController controller;
  final String fieldTitle;
  final IconButton? suffixIcon;
  final bool isTextScure;
  final bool isPrefixIcon;
  final String? labelText;
  final bool enableBorder;
  final bool facusBorder;
  final bool enableAddress;
  final bool isCurrentLocation;
  final enableTextField;
  final bool readOnly;
 final String? initValue;
  const CustomTextFieldValidator({
    this.validator,
    super.key,
    required this.controller,
    this.fieldTitle = "",
    this.suffixIcon,
    this.enableTextField = true,
    this.onChanged,
    this.enableBorder = false,
    this.isTextScure = false,
    this.isPrefixIcon = false,
    this.facusBorder = false,
    this.labelText,
    this.isCurrentLocation=true,
    this.enableAddress = true,
    this.readOnly=false,
    this.initValue
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical:enableAddress? 10.0.h:0.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,

        children: [
          Text(
            enableAddress ? fieldTitle : "",
            textAlign: TextAlign.start,
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF344054),
            ),
          ),
          enableAddress ? SizedBox(height: 8.h) : SizedBox(height: 0, width: 0),

          TextFormField(
            initialValue:initValue,
            readOnly:readOnly ,
            enabled: enableTextField,
            controller: controller,
            validator: validator,
            obscureText: isTextScure,
            onChanged: onChanged,
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(
                color: const Color(0xff475467),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              isDense: true,
              fillColor: Colors.white,
              filled: true,
              // labelText: fieldTitle,
              suffixIcon: suffixIcon,
              prefixIcon:
                  isCurrentLocation == true
                      ? Icon(
                        Icons.circle,
                        color: const Color(0xff5F00FB),
                        size: 8.w,
                      )
                      : Icon(
                        Icons.circle,
                        color: const Color(0xff60BF95),
                        size: 8.w,
                      ),

              border:
                  enableBorder == true
                      ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide.none,
                      )
                      : OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Color(0xFFD0D5DD),
                          width: 1,
                        ),
                      ),
              enabledBorder:
                  enableBorder == true
                      ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Color(0xFFD0D5DD),
                          width: 1,
                        ),
                      )
                      : null,
              focusedBorder:
                  facusBorder == true
                      ? OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.r),
                        borderSide: BorderSide(
                          color: Color(0xFFD0D5DD),
                          width: 1,
                        ),
                      )
                      : null,
            ),
          ),

          // TextFormField(
          //   controller: normalCubit.destinationCon,
          //   onChanged: (location) {
          //     normalCubit.setDestination(toLocation: location);
          //   },
          //   decoration: InputDecoration(
          //     isDense: true,
          //     labelText: 'Where to?',
          //     labelStyle: TextStyle(
          //       color: const Color(0xff475467),
          //       fontSize: 14.sp,
          //       fontWeight: FontWeight.w400,
          //     ),
          //     contentPadding: const EdgeInsets.all(5.0),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8.r),
          //       borderSide: BorderSide.none,
          //     ),
          //     filled: true,
          //     fillColor: Colors.white,
          //     prefixIcon: Icon(
          //       Icons.circle,
          //       color: const Color(0xff60BF95),
          //       size: 8.w,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
