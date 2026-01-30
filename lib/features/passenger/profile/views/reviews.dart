import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class ReviewsScreen extends StatelessWidget {
  const ReviewsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFCFCFD),

        appBar: customAppBar(title: 'Reviews'),

        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0.w),

          child: Column(
            children: [
              SizedBox(height: 50.h),
              //--------------------------- rating ---------------
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //----------------------- rate avg ------------
                  Text(
                    '4.4',
                    style: TextStyle(
                      fontSize: 64.sp,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff121212),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildWhichStarsIsColored(starsNum: 3, starSize: 32),

                      //----------------------- rate num ------------
                      Text(
                        '529 ratings',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          color: Color(0xff121212),
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              Divider(color: Color(0xff475467), thickness: 1, height: 20.h),
              buildWhoIsRatingItem(
                starNum: 3,
                date: '4/4/2004 , 4:44 PM',
                name: 'Hazem',
              ),
              buildWhoIsRatingItem(
                starNum: 2,
                date: '1/1/2011 , 1:11 PM',
                name: 'Asmaa',
              ),
              buildWhoIsRatingItem(
                starNum: 5,
                date: '4/4/2004 , 4:44 PM',
                name: 'Hazem',
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildWhoIsRatingItem({
    required int starNum,
    required String name,
    required String date,
  }) {
    return Container(
      padding: EdgeInsets.only(top: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffEAECF0), width: 1.w),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48.w,
            height: 48.h,
            child: CircleAvatar(
              radius: 50.r,
              backgroundImage: AssetImage('assets/images/Ellipse 14.png'),
            ),
          ),
          SizedBox(width: 10.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff121212),
                ),
              ),
              //----------------------- stars num ------------
              buildWhichStarsIsColored(starsNum: starNum, starSize: 20),
            ],
          ),
          Spacer(flex: 1),
          Text(
            date,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff344054),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildWhichStarsIsColored({
    required int starsNum,
    required double starSize,
  }) {
    return SizedBox(
      // width: 120.w,
      height: 50.h,
      child: ListView.builder(
        itemCount: 5,
        itemBuilder: (context, index) {
          if (starsNum > index ) {
            return Icon(Icons.star, size: starSize.w, color: Color(0xffF0C24D));
          } else {
            return Icon(Icons.star, size: starSize.w, color: Colors.amber[100]);
          }
        },
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    );
  }
}
