import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Future<dynamic> buildAboutDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.r),
        ),
        backgroundColor: Colors.white,
        content: Padding(
          padding:  EdgeInsets.symmetric(vertical: 40.h , horizontal: 5.w ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Powered by Smart Software Empire ',
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Color(0xff1B1B1B),
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 20.h),
              buildAboutItem(version: 'iOS Version :', versionValue: '1.1'),
              SizedBox(height: 10.h),
          
              buildAboutItem(version: 'Android Version :', versionValue: '1.1'),
              SizedBox(height: 10.h),
          
              buildAboutItem(version: 'Released On :', versionValue: '29-5-2025'),
              SizedBox(height: 10.h),
          
              buildAboutItem(version: 'Copyright :', versionValue: 'Smart@2025'),
            ],
          ),
        ),
      );
    },
  );
}

Row buildAboutItem({required String version, required String versionValue}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        version,
        style: TextStyle(
          fontSize: 14.sp,
          color: Color(0xff1B1B1B),
          fontWeight: FontWeight.w400,
        ),
      ),
      // SizedBox(width: 70.h),
      Text(
        versionValue,
        style: TextStyle(
          fontSize: 14.sp,
          color: Color(0xff1B1B1B),
          fontWeight: FontWeight.w400,
        ),
      ),
    ],
  );
}
