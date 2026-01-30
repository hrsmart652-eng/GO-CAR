// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/features/passenger/home/widgets/bottom_navigation_bar.dart';

import '../../../core/routing/routes.dart';

class NoSavedCardScreen extends StatelessWidget {
  const NoSavedCardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFCFD),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                'assets/images/wallet_background.png',
                width: double.infinity,
                fit: BoxFit.cover,
                // height: 220.h,
              ),
              Positioned(
                // top: 10,
                left: 20.w,
                right: 20.w,
                bottom: -20.h,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //--------------------------   رصيده كام--------------------------
                            Row(
                              children: [
                                Icon(
                                  Icons.stars_rounded,
                                  color: Colors.amber,
                                ),
                                SizedBox(width: 5.w),
                                Text(
                                  '620',
                                  style: TextStyle(
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),

                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              'Your coins balance is 640 SEK',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),

                        Image.asset(
                          'assets/images/Group.png',
                          width: 64,
                          height: 64,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 16.h,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 10.r,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/Group.svg'),
                          SizedBox(width: 12.w),
                          Text(
                            'Bank account',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 32.h),

          //-------------------------------- add a card -----------------
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, Routes.customerCardsScreen);
              // Routes.customerCardsScreen
              // print('taped');
            },
            child: Padding(
              padding:  EdgeInsets.symmetric( vertical: 8.0.h, horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.add, size: 24.w, color: Color(0xff266FFF)),
                  SizedBox(width: 10.w),
                  Text(
                    'Add new card',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff266FFF),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

    bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 2, ),


    );
  
  }
}
