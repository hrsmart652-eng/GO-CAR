import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFCFCFD),

        appBar: customAppBar(title: 'Support'),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 30.h),

              Image.asset(
                'assets/images/Group 76093.png',
                width: 93.w,
                height: 82.h,
              ),

              SizedBox(height: 30.h),
              SizedBox(
                width: 168.w,
                child: Center(
                  child: Text(
                    'Hello, how can we help you?',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20.sp,

                      fontWeight: FontWeight.w700,
                      color: Color(0xff0D3244),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30.h),

              buildSupportWayItem(
                supportWayName: 'Call',
                supportWayIcon: FontAwesomeIcons.phoneVolume,
                supportWayDescription:
                    'Select if you would like to talk to a representative.',
              ),

               buildSupportWayItem(
                supportWayName: 'Email',
                supportWayIcon: FontAwesomeIcons.at,
                supportWayDescription:
                   "Send us an email if you have any complaints.",
              ),

            ],
          ),
        ),
      ),
    );
  }

  Container buildSupportWayItem({
    required String supportWayName,
    required String supportWayDescription,
    required IconData supportWayIcon,
  }) {
    return Container(
      width: 343.w,
      margin: EdgeInsets.only(bottom: 16.h),
      padding: EdgeInsets.symmetric(vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Color(0xffEAECF0), width: 1.w),
        borderRadius: BorderRadius.circular(4.r),
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),
            child: Row(
              children: [
                Icon(supportWayIcon, size: 20.w, color: Color(0xff183E91)),
                SizedBox(width: 10.w),
                Text(
                  supportWayName,
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff183E91),
                  ),
                ),
                Spacer(flex: 1),
                Icon(Icons.arrow_forward, size: 20.w, color: Color(0xff183E91)),
              ],
            ),
          ),
          Divider(color: Color(0xffEAECF0), thickness: 1, height: 10.h),
          SizedBox(height: 10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w),

            child: Text(
              supportWayDescription,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff475467),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
