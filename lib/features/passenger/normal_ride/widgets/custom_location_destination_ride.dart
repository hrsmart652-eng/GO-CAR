

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomLocationAndDestinationRide extends StatelessWidget {
  const CustomLocationAndDestinationRide({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 65.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Current location',
              labelStyle: TextStyle(
                color: const Color(0xff475467),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: const EdgeInsets.all(5.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.circle,
                color: const Color(0xff5F00FB),
                size: 8.w,
              ),
            ),
          ),
          SizedBox(height: 8.h),

          // Where to   ****************************************
          TextField(
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Where to?',
              labelStyle: TextStyle(
                color: const Color(0xff475467),
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
              ),
              contentPadding: const EdgeInsets.all(5.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.r),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              prefixIcon: Icon(
                Icons.circle,
                color: const Color(0xff60BF95),
                size: 8.w,
              ),
            ),
          ),
        ],
      ),
    );
  }
}