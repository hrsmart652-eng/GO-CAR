import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/widgets/custom_app_bar.dart';
import '../../../../../core/database/cache/cache_helper.dart';
import '../../../../../core/services/api/end_points.dart';
import '../../../../../core/widgets/custom_elevated_btn.dart';
import '../widgets/client.dart';

class ScheduledRideDetails extends StatelessWidget {
  const ScheduledRideDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(title: "Schedule ride details"),

      body: Stack(
        children: [
          SizedBox(
            height: double.infinity,
            child: Image.asset('assets/images/map.png', fit: BoxFit.fill),
          ),
          Positioned(
            bottom: 0,
            child: Container(
              height: 470.h,
              width: 360.w,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [


                        ClientDetails(
                          index: CacheHelper().getData(key: ApiKeys.index),
                        ),

                        // Row(
                        //   children: [
                        //     ClipOval(
                        //       child: Image.asset(
                        //         'assets/images/Profile.jpg',
                        //         width: 80.w,
                        //         height: 70.h,
                        //         fit: BoxFit.cover,
                        //       ),
                        //     ),
                        //     SizedBox(width: 10.w),
                        //     Column(
                        //       crossAxisAlignment: CrossAxisAlignment.start,
                        //       children: [
                        //         Text(
                        //           'Client Name!',
                        //           style: TextStyle(
                        //             fontSize: 20,
                        //             fontWeight: FontWeight.w600,
                        //           ),
                        //         ),
                        //         Row(
                        //           children: [
                        //             Icon(
                        //               Icons.star,
                        //               color: Color(0xffF0C24D),
                        //               size: 20,
                        //             ),
                        //             Text(
                        //               ' 4.4',
                        //               style: TextStyle(
                        //                 fontSize: 14,
                        //                 fontWeight: FontWeight.w400,
                        //               ),
                        //             ),
                        //             Text(
                        //               ' 8,500 rides',
                        //               style: TextStyle(
                        //                 fontSize: 10,
                        //                 fontWeight: FontWeight.w500,
                        //               ),
                        //             ),
                        //           ],
                        //         ),
                        //       ],
                        //     ),
                        //   ],
                        // ),
                      ],
                    ),

                    SizedBox(height: 10.h),

                    Container(
                      width: 390.w,
                      height: 70.h,
                      padding: EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Color(0xffEAECF0)),
                        color: Color(0xffFCFCFD),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '18 / 7 / 2024',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff0D3244),
                                ),
                              ),
                              Text(
                                '02:25 PM',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff0D3244),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xffEAECF0),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            width: 40.w,
                            height: 40.h,
                            child: Image.asset(
                              'assets/images/car_arrow.png',
                              fit: BoxFit.scaleDown,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),

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
                          SvgPicture.asset("assets/images/from_to_image.svg"),
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
                            SvgPicture.asset("assets/images/noun_distance.svg"),
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
                          children: [
                            SvgPicture.asset("assets/images/noun_time.svg"),
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
                      btnName: 'Book',
                      onPressed: () {
                        Navigator.pushNamed(context, Routes.congrats);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
