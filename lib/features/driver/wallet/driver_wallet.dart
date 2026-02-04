import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/driver/home/views/widgets/driver_bottom_navigation_bar.dart';

class DriverWallet extends StatelessWidget {
  const DriverWallet({super.key});

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
                top: 120,
                right: 40,
                left: 40,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        //--------------------------   رصيده كام--------------------------
                        Row(
                          children: [
                            Icon(Icons.stars_rounded, color: Colors.amber),
                            SizedBox(width: 5.w),
                            Text(
                              '640',
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
              ),
            ],
          ),
          SizedBox(height: 24.h),

          //-------------------------------- add a card -----------------
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 343.w,
                  height: 60.h,

                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Color(0xffEAECF0)),
                    borderRadius: BorderRadius.circular(12),
                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset('assets/images/withdraw.png', width: 25),
                      SizedBox(width: 10.w),
                      Text(
                        'Withdraw Money',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff121212),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24.h),

              Text(
                'Withdraw History',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff121212),
                ),
              ),
              SizedBox(height: 15.h),

              Container(
                width: 345.w,
                height: 50.h,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xffC3D3F4),
                  border: Border.all(color: Color(0xffC3D3F4)),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/check_box.png', width: 17),
                        SizedBox(width: 10.w),
                        Text(
                          '16 Feb 2024',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0D3244),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          '12:00 PM',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff475467),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '4000 ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff121212),
                          ),
                        ),

                        Text(
                          'SEK',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff121212),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 15.h),

              Container(
                width: 345.w,
                height: 50.h,
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Color(0xffC3D3F4),
                  border: Border.all(color: Color(0xffC3D3F4)),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Image.asset('assets/images/check_box.png', width: 17),
                        SizedBox(width: 10.w),
                        Text(
                          '16 Feb 2024',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0D3244),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          '12:00 PM',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff475467),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '640 ',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff121212),
                          ),
                        ),

                        Text(
                          'SEK',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff121212),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),

      bottomNavigationBar: DriverNavigationBarWidget(currentIndex: 1),
    );
  }
}
