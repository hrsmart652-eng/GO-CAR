import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

Widget WalletTypeRideCart({
  required BuildContext context,
  required void Function()? walletOnTap,
  required bool isCach,
  required Widget walletType,
  required String image
}) {
  return GestureDetector(
    onTap: walletOnTap,
    child: Container(
      width: double.infinity,
      height: isCach ? 92.h : 120.h,
      decoration: BoxDecoration(
        color: isCach ? Color(0xffF5FAFF) : Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: isCach ? Color(0xffBBD1FB) : const Color(0xffEAECF0),
          width: 1.w,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(11),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.w,
              height: 32.h,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(width: 4.w, color: const Color(0xffF2F4FF)),
                color: Color(0xffEBEDFF),
              ),
              child: Center(
                child: SvgPicture.asset(image,
                  width: 16.w,
                  height: 16.h,
                ),
              ),
            ),
            SizedBox(width: 10.w),
            walletType,
            Container(
              width: 16.w,
              height: 16.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.r),
                border:
                isCach
                        ? null
                        : Border.all(
                          width: 1.w,
                          color: isCach ? Colors.white : Color(0xffD0D5DD),
                        ),
                color: isCach ? Color(0xff266FFF) : Colors.white,
              ),
              child:
               isCach
                      ? Icon(Icons.check, color: Colors.white, size: 12.w)
                      : null,
            ),
          ],
        ),
      ),
    ),
  );
}
