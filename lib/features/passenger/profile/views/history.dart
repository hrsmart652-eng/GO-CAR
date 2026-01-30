import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFCFCFD),

        appBar: customAppBar(title: 'History'),

        body: Column(
          children: [
            SizedBox(
              height: 30.h,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                children: [
                  buildHistoryItem(
                    carLogo: 'assets/images/travel_car.svg',
                    time: '4/4/2004 , 4:44 PM',
                    amount: '122 SEK',
                    travelStatus: 'Scheduledreturn',
                    btnName: 'Completed',
                  ),

                  buildHistoryItem(
                    carLogo: 'assets/images/travel_15848612.svg',
                    time: '4/4/2004 , 4:44 PM',
                    amount: '122 SEK',
                    travelStatus: 'Normal Ride',
                    btnName: 'Canceled',
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

Padding buildHistoryItem({
  required String carLogo,
  required String travelStatus,
  required String time,
  required String amount,
  required String btnName,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 16.h),
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
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //-----------------------------  logo --------------------
                Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: Color(0xffE8EEFB),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: SvgPicture.asset(carLogo, width: 20.w, height: 20.h),
                ),
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
          SizedBox(width: 8.w),
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
              SizedBox(height: 5.h),

              Row(
                children: [
                  //------------------ circles and desaed lines -----------------
                  Column(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: Color(0xff5F00FB),
                          shape: BoxShape.circle,
                        ),
                      ),

                      SizedBox(
                        height: 20.h, // الطول الإجمالي باستخدام
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            // حساب عدد الشرطات بناءً على الطول
                            ((20) / (3 + 2)).floor(),
                            (index) => Container(
                              width:
                                  1.0.w, // عرض الشرطة (يمكن زيادته إذا أردت خطًا أعرض)
                              height: 3.h, // ارتفاع الشرطة
                              color: Color(0xff121212), // لون الشرطة
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: Color(0xff60BF95),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  //------------------------- to - from --------------
                  SizedBox(
                    width: 145.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sollefteå ,Sweden',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        Text(
                          'Försvarsmakten Västernorrland',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,

                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              //---------------------- amount ----------------
              Row(
                children: [
                  Image.asset(
                    'assets/images/pepicons_print_credit_card.png',
                    width: 20.w,
                    height: 20.w,
                  ),
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
            ],
          ),
          Spacer(flex: 1),
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
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
          ),
        ],
      ),
    ),
  );
}
