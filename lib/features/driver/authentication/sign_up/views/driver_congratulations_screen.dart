import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DriverCongratulationsScreen extends StatelessWidget {
  const DriverCongratulationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          SizedBox(height: 20.h),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/images/driver_congrats.png',
                  width: 295,
                  height: 200,
                ),
                SizedBox(height: 30.h),
                Text(
                  'Congratulations Yousef!!',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF0D3244),
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  'Your response has been submitted, Please wait until we check your data ',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF475467),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          Text(
            'if there is any questions contact us on +201015463987',
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff121212),
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
