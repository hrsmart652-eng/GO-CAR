import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PreferredSizeWidget customAppBar({ required String title,bool isBack=false}) => AppBar(
    automaticallyImplyLeading:isBack,
  backgroundColor: Color(0xffFCFCFD),
  centerTitle: true,
  title: Text(
    title,
    style: TextStyle(
      fontSize: 20.sp,
      color: Color(0xff0D3244),
      fontWeight: FontWeight.w600,
    ),
  ),
);
