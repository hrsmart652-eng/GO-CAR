import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomElevatedBtn extends StatelessWidget {
  const CustomElevatedBtn({
    super.key,
    this.onPressed,
    required this.btnName,
    this.btnSize,
    this.btnColor,
    this.btnTextColor,
  });

  final VoidCallback? onPressed;
  final Size? btnSize;
  final Color? btnColor;
  final Color? btnTextColor;
  final String btnName;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: btnColor ?? const Color(0xFF266FFF),
        minimumSize: btnSize ?? Size(343.w, 48.h),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      ),
      child: Text(
        btnName,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: btnTextColor ?? Colors.white,
        ),
      ),
    );
  }
}
