import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/routing/routes.dart';

class CardItem extends StatelessWidget {
  const CardItem({
    super.key,
    required this.bankLogo,
    required this.bankName,
    required this.serialNum,
    this.isPinned = false,
  });

  final String bankLogo;
  final String bankName;
  final String serialNum;
  final bool? isPinned;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       Navigator.pushNamed(context, Routes.cardDetailsScreen );
      },
      child: Container(
        width: 320.w,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
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
        child: Column(
          children: [

            Row(
              children: [
                //----------------------------- bank logo --------------------
                SvgPicture.asset(bankLogo),
                SizedBox(width: 12.w),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //---------------------- bank name ----------------
                    Text(
                      bankName,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5.h),

                    //---------------------- card serial num ----------------
                    Text(
                      serialNum,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Color(0xff344054),
                      ),
                    ),
                  ],
                ),
                Spacer(flex: 3),

                //------------------------- is pinned -----------------------

                if (isPinned == true)
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.push_pin,
                      color: Color(0xff475467),
                      size: 18.w,
                    ),
                  ),

              ],
            ),
          ],
        ),
      ),
    );
 
  }
}
