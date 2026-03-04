


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SchduleTripTransaction extends StatelessWidget {
  final Image image;
  final String title;
  final String content;
  final VoidCallback onTap;

  const SchduleTripTransaction({
    super.key,
    required this.image,
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.h,
        width: 332.w,
        decoration: BoxDecoration(color: Color(0xfff3f6fb)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              image,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Text(
                      content,
                      style: TextStyle(
                        color: Color(0xff475467),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}