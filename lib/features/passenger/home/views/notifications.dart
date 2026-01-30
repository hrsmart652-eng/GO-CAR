import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class ClientNotifications extends StatelessWidget {
  const ClientNotifications({super.key});

  @override
  Widget build(BuildContext context) {
    bool isRead = false;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(
          title: 'Notifications',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(
                height: 605.h,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //today notifications /*********************************************************************************** */
                      Text(
                        "Today",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff0D3244),
                          fontSize: 14.sp,
                        ),
                      ),
                      notification(false),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                        child: Divider(
                          height: 0.h,
                          thickness: 1.w,
                          color: const Color(0xffEAECF0),
                        ),
                      ),
                      notification(false),
                      //  yasterday notifications ***************************************************************
                      SizedBox(height: 8.h),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "Yesterday",
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            color: const Color(0xff0D3244),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      notification(false),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Divider(
                          thickness: 1.w,
                          height: 0.h,
                          color: const Color(0xffEAECF0),
                        ),
                      ),
                      notification(true),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  deleteCard(BuildContext context) {
    return showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.r),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/images/cancel_delete.png',
                  height: 80.h,
                  width: 80.w,
                ),
                SizedBox(height: 16.h),
                Text(
                  'Are you sure!',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Color(0xff0D3244),
                  ),
                ),
                SizedBox(height: 8.h),
                Text(
                  'Once you delete this card it will be gone forever.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Color(0xff475467),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 24.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: const Color(0xffF9FAFB),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                            side: BorderSide(
                              color: Color(0xffD0D5DD),
                              width: 1.w,
                            ),
                          ),
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                        child: Text(
                          'No',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: const Color(0xff183E91),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xffD92D20),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                        ),
                        onPressed: () {
                          // Add your delete logic here
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Yes',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
    );
  }

  Widget notification(isRead) {
    return Container(
      padding:
          isRead ? EdgeInsets.zero : EdgeInsets.symmetric(horizontal: 16.w),
      color: isRead ? Color(0xffF5F9FF) : Colors.white,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: RichText(
              text: TextSpan(
                style: TextStyle(height: 1.8.h),
                children: [
                  TextSpan(
                    text: "There is moou can choose. ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff121212),
                      fontSize: 18.sp,
                    ),
                  ),
                  TextSpan(
                    text:
                        " There are many variations of passages of Lorem Ipsum available, but \nth",
                    style: TextStyle(
                      letterSpacing: -0.41,

                      fontWeight: FontWeight.w400,
                      color: const Color(0xff475467),
                      fontSize: 15.sp,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 8.h),

          Padding(
            padding: EdgeInsets.only(left: 240.0.w, top: 7.0.h),
            child: Text(
              "4/4/2004 , 4:44 PM",
              style: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
                color: const Color(0xff344054),
                letterSpacing: -0.41,
              ),
            ),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
