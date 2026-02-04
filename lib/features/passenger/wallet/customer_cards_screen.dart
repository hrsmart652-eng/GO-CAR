
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/passenger/Wallet/widgets/card_item.dart';

class CustomerCardsScreen extends StatelessWidget {
  const CustomerCardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFCFCFD),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Stack(
                clipBehavior: Clip.none,
                children: [
                  Image.asset(
                    'assets/images/wallet_background.png',
                    fit: BoxFit.cover,
                    width: double.infinity,
                    // height: 220.h,
                  ),
                  Positioned(
                    left: 20.w,
                    right: 20.w,
                    bottom: -40.h,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        //----------------------------------- card item---------------
                        CardItem(
                          isPinned: true,
                          bankLogo: 'assets/images/Group.svg',
                          bankName: 'Aareal Bank AG ',
                          serialNum: 'XXXXXXXXX236',
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              //-------------------------------- add card btn -----------------
              GestureDetector(
                onTap: () {
                  print('taped');
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: 16.0.h,
                    horizontal: 16.w,
                  ),
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
              SizedBox(height: 12.h),

              //----------------------------------- card item---------------
              CardItem(
                bankLogo: 'assets/images/Group.svg',
                bankName: 'Aareal Bank AG ',
                serialNum: 'XXXXXXXXX236',
              ),

              SizedBox(height: 10.h,),

              CardItem(
                bankLogo: 'assets/images/Group.svg',
                bankName: 'Aareal Bank AG ',
                serialNum: 'XXXXXXXXX236',
              ),
            ],
          ),
        ),

      // bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 1 ),
     
      ),
    );
  }
}
