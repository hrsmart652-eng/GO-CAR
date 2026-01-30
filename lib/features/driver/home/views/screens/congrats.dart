import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Congrats extends StatefulWidget {
  const Congrats({super.key});

  @override
  State<Congrats> createState() => _CongratsState();
}

class _CongratsState extends State<Congrats> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 7), () {
      if (mounted) Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFCFD),
      body: Center(
        child: SizedBox(
          width: 330.w,
          height: 290.h,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.asset('assets/images/congrats_msg.png'),
              Column(
                children: [
                  Text(
                    'Congratulations Maged!!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xff0D3244),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    'The ride has been booked for you. You will receive a notification before the scheduled time of the ride to go to the passenger at the appointed time.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff475467),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
