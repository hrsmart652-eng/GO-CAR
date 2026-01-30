import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/passenger/Wallet/widgets/card_item.dart';
import 'package:go_car/features/passenger/Wallet/widgets/card_transactions_item.dart';


class CardTransactions extends StatelessWidget {
  const CardTransactions({super.key});

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
                    width: double.infinity,
                    fit: BoxFit.cover,
                    // height: 220.h,
                  ),
                  Positioned(
                    left: 20.w,
                    right: 20.w,
                    bottom: -40.h,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back_rounded,
                                color: Color(0xffEAECF0),
                                size: 24.w,
                              ),
                            ),
                            // SizedBox(width: 5.w),
                            Spacer(flex: 2),
                            Text(
                              'Card Transactions',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Spacer(flex: 3),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        //----------------------------------- card item---------------
                        CardItem(
                          // isPinned: isPinned,
                          bankLogo: 'assets/images/Group.svg',
                          bankName: 'Aareal Bank AG ',
                          serialNum: 'XXXXXXXXX236',
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 80.h),
              CardTransactionsItem(
                carLogo: 'assets/images/travel_car.svg',
                time: '4/4/2004 , 4:44 PM',
                amount: '122 SEK',
                travelStatus: 'Scheduledreturn',
                btnName: 'Completed',
              ),

              CardTransactionsItem(
                carLogo: 'assets/images/travel_car.svg',
                time: '4/4/2004 , 4:44 PM',
                amount: '122 SEK',
                travelStatus: 'Normal',
                btnName: 'Cancel',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
