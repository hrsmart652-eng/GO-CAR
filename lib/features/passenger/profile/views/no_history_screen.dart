import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class NoHistoryScreen extends StatelessWidget {
  const NoHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFCFD),

      appBar: customAppBar(title: 'History'),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/nohistory.png',
                width: 100.w,
                height: 100.h,
              ),

              SizedBox(height: 30.h),
              Text(
                'No data found,',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff475467),
                ),
              ),
              Text(
                'Go home and Complete your first',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff475467),
                ),
              ),
              Text(
                'ride',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff475467),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
