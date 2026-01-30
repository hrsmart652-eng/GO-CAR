import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';

class RideEnded extends StatelessWidget {
  const RideEnded({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Ride Ended"),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'thank you for using YESCAB\n',
              style: TextStyle(
                color: Color(0xff475467),
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),

            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    child: Image.asset(
                      'assets/images/rectangle.png',
                      width: double.infinity,
                      fit: BoxFit.fill,
                    ),
                  ),

                  Positioned(
                    bottom: 0,
                    child: Container(
                      width: 410,
                      color: Colors.white,
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          SizedBox(height: 10.h),
                          Row(
                            children: [
                              Row(
                                children: [
                                  ClipOval(
                                    child: Image.asset(
                                      'assets/images/Profile.jpg',
                                      width: 70.w,
                                      height: 60.h,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  SizedBox(width: 10.w),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Driver Name',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Color(0xffF0C24D),
                                            size: 16,
                                          ),
                                          Text(
                                            ' 4.4',
                                            style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w400,
                                            ),
                                          ),
                                          Text(
                                            ' 8,500 rides',
                                            style: TextStyle(
                                              fontSize: 10,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Text(
                                        'Nissan juke ب ن م 1232',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff344054),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                children: [
                                  Text(
                                    'Today',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff266FFF),
                                    ),
                                  ),
                                  Text(
                                    '9:05 AM',
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: Color(0xff266FFF),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            width: 343.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 4,
                                  offset: Offset(0, 2),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                SizedBox(width: 10.w),
                                SvgPicture.asset(
                                  "assets/images/from_to_image.svg",
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: 10.h),
                                    Text(
                                      "Pick up",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: const Color(0xff475467),
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "Alexandria, Egypt",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: const Color(0xff121212),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 20.h),
                                    Text(
                                      "Destination",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: const Color(0xff475467),
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      "Cairo, Egypt",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: const Color(0xff121212),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(height: 10.h),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/noun_distance.svg",
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "Distance 40Km",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: const Color(0xff121212),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: 40.w),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  SvgPicture.asset(
                                    "assets/images/noun_time.svg",
                                  ),
                                  SizedBox(width: 4.w),
                                  Text(
                                    "Time 32Mins",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: const Color(0xff121212),
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            width: 343.w,
                            height: 2.h,
                            color: Color(0xffEAECF0),
                          ),
                          SizedBox(height: 20.h),
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Total fare: ',
                                      style: TextStyle(
                                        color: Color(0xff344054),

                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      '122 SEK',
                                      style: TextStyle(
                                        color: Color(0xff027A48),

                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Image.asset(
                                      'assets/images/credit_card.png',
                                      width: 25.w,
                                      height: 25.h,
                                    ),
                                    SizedBox(width: 10.w),
                                    Text(
                                      'Credit card',
                                      style: TextStyle(
                                        color: Color(0xff266FFF),

                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 20.h),
                          CustomElevatedBtn(
                            btnName: 'Rating',
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.rating);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
