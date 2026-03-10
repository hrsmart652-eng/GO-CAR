import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/features/passenger/schedule_ride/cubit/scheduled_ride_state.dart';

import '../../../../core/widgets/custom_elevated_btn.dart';
import '../cubit/scheduled_ride_cubit.dart';

class RequestSentScreen extends StatefulWidget {
  const RequestSentScreen({super.key});

  @override
  State<RequestSentScreen> createState() => _RequestSentScreenState();
}

class _RequestSentScreenState extends State<RequestSentScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ScheduledRideCubit, ScheduledRideState>(
      builder: (context, state) {
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
                SizedBox(
                  width: double.infinity,
                  height: 50.h,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff266FFF),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                    ),
                    onPressed:isLoading
                        ? null
                        : () async {
                      setState(() => isLoading = true);

                      await Future.delayed(
                        const Duration(seconds: 2),
                      );

                      if (context.mounted) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Routes.schduleHome,
                              (route) => false,
                        );
                      }
                    },
                    child:isLoading
                        ? const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                        : Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}