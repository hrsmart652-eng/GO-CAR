import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/passenger/schedule_ride/views/passenger_schedule_ride.dart';

import '../../../../core/widgets/custom_elevated_btn.dart';


class RequestSentScreen extends StatelessWidget {
  const RequestSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          children: [
            SizedBox(height: 150.h),
            Image.asset("assets/images/request_sent.png"),

            Text(
              "Request successfully sent!!",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xff0D3244),
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Your scheduled ride will be sent for you once one of our team calls you to confirm your request and to guarantee you saw the confirmation will notify you too",
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.grey,
              ),
            ),
            SizedBox(height: 50),
            CustomElevatedBtn(
              btnName: 'OK',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PassengerScheduleRide(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
