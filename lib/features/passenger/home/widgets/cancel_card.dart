import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';

class CancelCard extends StatelessWidget {
  const CancelCard({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: SizedBox(
        height: 240.h,
        width: 330.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Image.asset(
              "assets/images/cancel_delete.png",
              width: 80,
              height: 80,
            ),
            Text(
              'Are you sure!',
              style: TextStyle(
                color: Color(0xff0D3244),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
            Text(
              'You will not be able to change your mind after this message.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color(0xff475467),
                fontSize: 16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFF9FAFB),
                    minimumSize: Size(115.w, 48.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'No',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff183E91),
                    ),
                  ),
                ),

                ElevatedButton(
                  onPressed: () {
                    // Navigator.pushNamed(context, Routes.home);
                    Navigator.pushNamed(context, Routes.findDriver);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFD90F00),
                    minimumSize: Size(115.w, 48.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    'Yes',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
}
