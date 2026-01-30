import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/home/views/widgets/client.dart';

class ScheduledDetails extends StatelessWidget {
  final ScrollController? scrollController;
  const ScheduledDetails({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Color(0xffEAECF0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '18/7/2024, ',
                        style: TextStyle(
                          color: Color(0xff266FFF),

                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        '02:25 AM',
                        style: TextStyle(
                          color: Color(0xff266FFF),

                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
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
            ),

            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                    ),
                    child: Row(
                      children: [
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
                          ],
                        ),
                      ],
                    ),
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

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
                  SizedBox(width: 60.w),
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
            ),

            SizedBox(height: 10.h),

            Container(height: 1.h, color: Color(0xffEAECF0)),

            SizedBox(height: 10.h),

            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, Routes.scheduled);
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ClientDetails(
                      index: CacheHelper().getData(key: ApiKeys.index),
                      // name: 'John Doe',
                      // imageUrl: 'https://example.com/image.jpg',
                    ),
                    Icon(Icons.chevron_right_sharp, color: Color(0xff266FFF)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
