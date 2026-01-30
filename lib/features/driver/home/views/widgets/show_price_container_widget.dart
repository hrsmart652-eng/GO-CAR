import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ShowPriceContainerWidget extends StatelessWidget {
  const ShowPriceContainerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return   Stack(children: [
            Positioned(
                left: 0,
                right: 0,
                bottom: 130.5.h,
                child: Container(
                  width: double.infinity,
                  height: 45.h,
                  decoration: BoxDecoration(
                      color: const Color(0xffFEDF89),
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Padding(
                    padding: EdgeInsets.only(top: 5.h, left: 30.w),
                    child: Text(
                      "If there is a traffic jam the estimated price will increase",
                      style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xff121212)),
                    ),
                  ),
                )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  width: double.infinity,
                  height: 151.h,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r)),
                  child: Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: 20.h, horizontal: 15.w),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text("122 EGP",
                                  style: TextStyle(
                                    foreground: Paint()
                                      ..shader = const LinearGradient(
                                        colors: [
                                          Color(0xFF183E91),
                                          Color(0xFF266FFF)
                                        ],
                                        begin: Alignment.bottomLeft,
                                        end: Alignment.topRight,
                                      ).createShader(
                                          const Rect.fromLTWH(0, 0, 200, 70)),
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w600,
                                  )),
                              const Spacer(),
                              Stack(
                                children: [
                                  const Text(
                                    'Cancel',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color(0xffF04438),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 3,
                                    child: Container(
                                      height: 1,
                                      width: 50,
                                      color: Colors.red,
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                          Padding(
                              padding: EdgeInsets.only(top: 0.h),
                              child: Image.asset(
                                "assets/images/car_outline.png",
                                width: 201.w,
                                height: 75.h,
                                fit: BoxFit.cover,
                              ))
                        ],
                      )),
                ))
          ]);
  }
}