import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/passenger/Wallet/widgets/card_item.dart';
import 'package:go_car/features/passenger/schedule_ride/views/request_sent_screen.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24.h),
              //----------------------------------- card item---------------
              CardItem(
                isPinned: true,
                bankLogo: 'assets/images/Group.svg',
                bankName: 'Aareal Bank AG ',
                serialNum: 'XXXXXXXXX236',
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
              Text(
                'Saved card',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 12.h),

              //----------------------------------- card item---------------
              CardItem(
                bankLogo: 'assets/images/Group.svg',
                bankName: 'Aareal Bank AG ',
                serialNum: 'XXXXXXXXX236',
              ),

              SizedBox(height: 10.h),

              CardItem(
                bankLogo: 'assets/images/Group.svg',
                bankName: 'Aareal Bank AG ',
                serialNum: 'XXXXXXXXX236',
              ),

              SizedBox(height: 50),
              CustomElevatedBtn(
                btnName: 'Pay',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => RequestSentScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
