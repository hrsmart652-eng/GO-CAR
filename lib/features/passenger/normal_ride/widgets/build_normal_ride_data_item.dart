


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

Widget BuildNormalRideDataItem(String asset, String text) {
  return Row(
    children: [
      SvgPicture.asset(asset),
      SizedBox(width: 2.w),
      Text(
        text,
        style: TextStyle(
          color: const Color(0xff121212),
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}
