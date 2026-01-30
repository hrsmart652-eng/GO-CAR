import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/routing/routes.dart';

class CardTransactionsItem extends StatelessWidget {
  const CardTransactionsItem({
    super.key,
    required this.carLogo,
    required this.travelStatus,
    required this.time,
    required this.amount,
    required this.btnName,
  });

  final String carLogo;
  final String travelStatus;
  final String time;
  final String amount;
  final String btnName;


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h, left: 16.w, right: 16.w),
      child: GestureDetector(
        onTap: (){
          Navigator.pushNamed(context, Routes.rideDetails );

        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
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
              SizedBox(
                width: 44.w,
                child: Column(
                  children: [
                    //-----------------------------  logo --------------------
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: Color(0xffE8EEFB),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: SvgPicture.asset(carLogo),
                    ),
                    SizedBox(height: 2.w),
                    Text(
                      travelStatus,
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //---------------------- time ----------------
                  Text(
                    time,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff344054),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  //---------------------- ----------------
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              Spacer(flex: 1),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xffE8FFF2),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                onPressed: () {},
                child: Text(
                  btnName,
                  style: TextStyle(
                    fontSize: 10.sp,
                    color: const Color(0xff027A48),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
