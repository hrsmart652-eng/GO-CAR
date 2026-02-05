import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/widgets/custom_app_bar.dart';

class PointsScreen extends StatelessWidget {
  const PointsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFCFCFD),

      appBar: customAppBar(
          title: 'Points'
      ),

      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/points_img_screen.png',
              width: 285.14.w,
              height: 188.h,
              // height: 220.h,
            ),

            SizedBox(height: 50.h),
            Text(
              'Invite friend , Get 25 SEK',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xff0D3244),
              ),
            ),

            SizedBox(height: 16.h),
            Text(
              'If you invites another user You will have a prize added to your wallet, from which commissions will be deducted, which are non-withdrawable .',
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
                color: Color(0xff344054),
              ),
            ),

            SizedBox(height: 30.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                buildPointsContactWayItem(
                  backgroundColor: Color(0xff266FFF),
                  contactIcon: Icons.link,
                  contactName: 'Copy code',
                ),
                SizedBox(width: 16.w),
                buildPointsContactWayItem(
                  backgroundColor: Color(0xff25D366),
                  contactIcon: FontAwesomeIcons.whatsapp,
                  contactName: 'Whatsapp',
                ),
                SizedBox(width: 16.w),
                buildPointsContactWayItem(
                  backgroundColor: Color(0xff475467),
                  contactIcon: Icons.ios_share,
                  contactName: 'Share',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column buildPointsContactWayItem({
    required Color backgroundColor,
    required String contactName,
    required IconData contactIcon,
  }) {
    return Column(
      children: [
        Container(
          width: 38.w,
          height: 38.h,
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(99),
          ),
          child: Icon(contactIcon, size: 19, color: Colors.white),
        ),

        SizedBox(height: 5.h),
        Text(
          contactName,
          style: TextStyle(
            fontSize: 11.sp,
            fontWeight: FontWeight.w400,
            color: Color(0xff0D3244),
          ),
        ),
      ],
    );
  }
}
