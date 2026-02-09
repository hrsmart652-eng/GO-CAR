

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomProfileText extends StatelessWidget {
  const CustomProfileText({
    super.key,required this.text,
    this.color
  });
  final String text;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Text(
      text ??"",
      style: TextStyle(
        fontSize: 18.sp,
        fontWeight: FontWeight.w700,
        color:color??const Color(0xffFFFFFF),
      ),
    );
  }
}