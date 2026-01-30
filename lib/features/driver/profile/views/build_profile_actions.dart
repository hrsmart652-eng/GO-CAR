import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildProfileAction extends StatelessWidget {
  const BuildProfileAction({
    super.key,
    required this.actionName,
    required this.onTap,
  });

  final String actionName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 343.w,
        margin: EdgeInsets.only(right: 16.w, bottom: 10.h, left: 16.w),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffEAECF0), width: 1.w),
          borderRadius: BorderRadiusDirectional.circular(4.r),
        ),
        child: Text(
          actionName,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
