
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';

class CheckStatusEndedTripBtn extends StatelessWidget {
  const CheckStatusEndedTripBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.rideEnded);
      },
      child: Container(
        width: double.infinity,
        height: 36.h,
        margin: EdgeInsets.symmetric(horizontal:5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xffFCFCFD),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: const Color(0xff027A48),
              size: 20.w,
            ),
            SizedBox(width: 10.w),
            Text(
              "End Ride",
              style: TextStyle(
                color: const Color(0xff027A48),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
