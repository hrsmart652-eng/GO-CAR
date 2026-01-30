import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildHorizontalListItem extends StatelessWidget {
  const BuildHorizontalListItem({
    super.key,
    required this.itemImg,
    required this.itemName,
    required this.onTap,
  });

  final String itemImg;
  final String itemName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 79.67.w,
        height: 80.h,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Color(0xffEAECF0), width: 1.w),
          borderRadius: BorderRadiusDirectional.circular(4.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(itemImg, width: 24.w, height: 24.h),
            SizedBox(height: 8.h),
            Text(
              itemName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
