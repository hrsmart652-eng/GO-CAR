import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/features/passenger/home/widgets/cancel_card.dart';

class ShowPrice extends StatefulWidget {
  const ShowPrice({super.key});

  @override
  State<ShowPrice> createState() => _ShowPriceState();
}

class _ShowPriceState extends State<ShowPrice> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: const AssetImage("assets/images/map.png"),
            fit: BoxFit.cover,
            width: 375.w,
            height: 685.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 65.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Current location',
                    labelStyle: TextStyle(
                      color: const Color(0xff475467),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.all(5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.circle,
                      color: const Color(0xff5F00FB),
                      size: 8.w,
                    ),
                  ),
                ),
                SizedBox(height: 8.h),

                // Where to   ****************************************
                TextField(
                  decoration: InputDecoration(
                    isDense: true,
                    labelText: 'Where to?',
                    labelStyle: TextStyle(
                      color: const Color(0xff475467),
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    contentPadding: const EdgeInsets.all(5.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.r),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.circle,
                      color: const Color(0xff60BF95),
                      size: 8.w,
                    ),
                  ),
                ),
              ],
            ),
          ),
          // const ShowPriceContainerWidget(),

          /// ✨ Animated Positioned
          NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              final isScrolled = notification.extent > 0.3 + 0.01;

              // adjust threshold
              if (isScrolled != isExpanded) {
                setState(() {
                  isExpanded = isScrolled;
                });
              }
              return true;
            },
            child: DraggableScrollableSheet(
              initialChildSize: isExpanded ? 0.6 : 0.38,
              minChildSize: 0.37,
              maxChildSize: 0.6,
              builder: (context, scrollController) {
                return Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,

                  child: SingleChildScrollView(
                    controller: scrollController,

                    child: SizedBox(
                      height: 420.h,
                      // color: Colors.red,
                      child: Stack(
                        children: [
                          Container(height: 50.h),
                          Positioned(
                            top: 70,
                            left: 0,
                            right: 0,
                            child: Container(
                              height: 370.h,
                              color: Colors.white,
                              child: Stack(
                                children: [
                                  Positioned(
                                    bottom: 316.h,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 25.0.w,
                                        right: 15.0.w,
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            "122 EGP",
                                            style: TextStyle(
                                              foreground:
                                                  Paint()
                                                    ..shader =
                                                        const LinearGradient(
                                                          colors: [
                                                            Color(0xFF183E91),
                                                            Color(0xFF266FFF),
                                                          ],
                                                          begin:
                                                              Alignment
                                                                  .bottomLeft,
                                                          end:
                                                              Alignment
                                                                  .topRight,
                                                        ).createShader(
                                                          const Rect.fromLTWH(
                                                            0,
                                                            0,
                                                            200,
                                                            70,
                                                          ),
                                                        ),
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          const Spacer(),
                                          Container(
                                            // padding: EdgeInsets.all(1.w),
                                            child: Image.asset(
                                              'assets/images/call.png',
                                              width: 50.w,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  //driver name ***********************************************
                                  Positioned(
                                    bottom: 271.h,
                                    left: 0,
                                    right: 0,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        left: 15.0.w,
                                        right: 15.0.w,
                                      ),
                                      child: Column(
                                        children: [
                                          Text(
                                            "Driver Name",
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              fontWeight: FontWeight.w600,
                                              color: Color(0xff121212),
                                            ),
                                          ),
                                          SizedBox(height: 8.h),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.star,
                                                color: Color(0xffFFC107),
                                                size: 14.w,
                                              ),
                                              Text(
                                                " 4.4",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w400,
                                                  color: Color(0xff121212),
                                                  fontSize: 14.sp,
                                                ),
                                              ),
                                              Text(
                                                " 8,500 rides",
                                                style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  color: Color(0xff344054),
                                                  fontSize: 10.sp,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                  // car image ****************************************************
                                  Positioned(
                                    top: 80.h,
                                    left: 3,
                                    child: SvgPicture.asset(
                                      "assets/images/car.svg",
                                    ),
                                  ),

                                  //car name and space and time  ****************************************************
                                  Positioned(
                                    top: 110.h,
                                    right: 35.w,
                                    child: Column(
                                      children: [
                                        Text(
                                          "Nissan juke ب ن م 1232",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w500,
                                            color: Color(0xff344054),
                                            fontSize: 14.sp,
                                          ),
                                        ),
                                        SizedBox(height: 8.h),
                                        Row(
                                          children: [
                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                  "assets/images/noun_distance.svg",
                                                ),
                                                SizedBox(width: 2.w),
                                                Text(
                                                  "40Km",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: const Color(
                                                      0xff121212,
                                                    ),
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                                SizedBox(width: 20.w),
                                                SvgPicture.asset(
                                                  "assets/images/noun_time.svg",
                                                ),
                                                SizedBox(width: 2.w),
                                                Text(
                                                  "32Mins",
                                                  textAlign: TextAlign.start,
                                                  style: TextStyle(
                                                    color: const Color(
                                                      0xff121212,
                                                    ),
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w400,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  //bottom sheet***********************************************************
                                  if (isExpanded)
                                    Positioned(
                                      bottom: 30.h,
                                      left: 0,
                                      right: 0,
                                      child: Column(
                                        children: [
                                          Container(
                                            width: double.infinity,
                                            height: 36.h,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: 16.w,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(8.r),
                                              color: const Color(0xffFCFCFD),
                                            ),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.credit_card_rounded,
                                                  color: Color(0xff183E91),
                                                  size: 20.w,
                                                ),
                                                SizedBox(width: 10.w),
                                                Text(
                                                  "Credit card",
                                                  style: TextStyle(
                                                    color: Color(0xff04034D),
                                                    fontSize: 14.sp,
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: 16.0.w,
                                            ),
                                            child: Divider(
                                              color: Color(0xff344054),
                                              thickness: 0.5.h,
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.of(
                                                context,
                                              ).pushNamed(Routes.rideEnded);
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 36.h,
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                              ),
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                                color: const Color(0xffFCFCFD),
                                              ),
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons.check_circle,
                                                    color: Color(0xff027A48),
                                                    size: 20.w,
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  Text(
                                                    "End Ride",
                                                    style: TextStyle(
                                                      color: Color(0xff027A48),
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (context) => CancelCard(),
                                              );
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              height: 44.h,
                                              margin: EdgeInsets.symmetric(
                                                horizontal: 16.w,
                                              ),
                                              decoration: BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                    width: 0.5.w,
                                                    color: Color(0xffD9D9D9),
                                                  ),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  SvgPicture.asset(
                                                    "assets/images/cancel_ride.svg",
                                                    width: 20.w,
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  Text(
                                                    "Cancel Ride",
                                                    style: TextStyle(
                                                      color: Color(0xffF04438),
                                                      fontSize: 14.sp,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
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
                          ),
                          Positioned(
                            top: 17,
                            left: 0,
                            right: 0,
                            child: CircleAvatar(
                              radius: 45.5.r,
                              backgroundColor: Colors.white,
                              child: Center(
                                child: CircleAvatar(
                                  radius: 41.5.r,
                                  backgroundImage:
                                      Image.asset(
                                        "assets/images/driver_image.png",
                                      ).image,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
