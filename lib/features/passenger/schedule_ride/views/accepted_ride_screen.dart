import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class AcceptedRideScreen extends StatelessWidget {
  const AcceptedRideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text('Request has been accepted'),
        ),
        body: SingleChildScrollView(
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //--------------------------- 1. map Image ---------------------------
              Padding(
                padding: EdgeInsets.symmetric(vertical: 16.0.w),

                child: Image.asset(
                  'assets/images/rectangle.png',
                  width: double.infinity,
                  height: 200.h,
                  fit: BoxFit.cover,
                ),
              ),

              // ----------------------- 2- Driver info  ------------------
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                child: Row(
                  children: [
                    // ------------------------ driver image ------------------------
                    Stack(
                      clipBehavior: Clip.none,
                      alignment: Alignment.center,
                      children: [
                        CircleAvatar(
                          radius: 30.r,
                          backgroundImage: AssetImage(
                            'assets/images/image56.png',
                          ),
                        ),
                        Positioned(
                          bottom: -20.h,
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xffE8FFF2),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.r),
                              ),
                            ),
                            onPressed: () {},
                            child: Text(
                              'completed',
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
                    SizedBox(width: 20.w),
                    // ------------------------ driver details ------------------------
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Driver Name',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff121212),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          children: [
                            Icon(Icons.star, color: Colors.yellow, size: 16.sp),
                            SizedBox(width: 4.w),
                            Text(
                              '4.4',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff121212),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              '8,500 rides',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff344054),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          'Nissan juke ب ن م 1232',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff344054),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              // ----------------------3- Row with date, time, and two icons
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.all(12.w),
                decoration: BoxDecoration(
                  color: Color(0xffFCFCFD),
                  border: Border.all(color: Color(0xffEAECF0), width: 1),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  //---------------- Column with date and time ---------------
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '4 / 4/ 2004',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff0D3244),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Text(
                          '10:00 AM',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff344054),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    // -----------------------  2 Icons
                    Container(
                      padding: EdgeInsets.all(4.w),
                      decoration: BoxDecoration(
                        color: Color(0xffEAECF0),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.car_crash,
                            color: Color(0xff121212),
                            size: 20.sp,
                          ),
                          Icon(
                            Icons.arrow_forward_sharp,
                            color: Color(0xff121212),
                            size: 20.sp,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),

              //------------------------
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 207, 199, 199),
                      blurRadius: 8,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
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
                          height: 30.h, // الطول الإجمالي باستخدام
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
                    SizedBox(width: 16),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Pick-up',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff475467),
                              ),
                            ),
                            Text(
                              'Sollefteå ,Sweden',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff121212),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Destination',
                              style: TextStyle(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff475467),
                              ),
                            ),

                            Text(
                              'Försvarsmakten Västernorrland',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                                color: Color(0xff121212),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24.h),

              //  4. Row with bottom border
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16),
                padding: EdgeInsets.only(bottom: 12.h),
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.grey.shade300, width: 1),
                  ),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        SvgPicture.asset(
                          'assets/images/noun-distance.svg',
                          width: 16.w,
                          height: 16.h,
                        ),
                        SizedBox(width: 8.w),
                        Text(
                          'Distance',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff344054),
                          ),
                        ),
                        Text(
                          '40Km',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff121212),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Color(0xff344054),
                          size: 16.sp,
                        ),
                        SizedBox(width: 8),
                        Text(
                          'Time',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff344054),
                          ),
                        ),
                        Text(
                          '32 mins',
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff121212),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // 5. Text
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  'Payment',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff121212),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              // 6. Row with background
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.h),
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: Color(0xFFFCFCFD),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Row(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Total fare:',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF344054),
                          ),
                        ),
                        // SizedBox(width: 8),
                        Text(
                          '122 EGP',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xff183E91),
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Icon(Icons.payment, color: Color(0XFF183E91)),
                        SizedBox(width: 8),
                        Text(
                          'Credit Card',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF266FFF),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
