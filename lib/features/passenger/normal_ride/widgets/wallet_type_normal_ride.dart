import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletTypeNormalRide extends StatelessWidget {
  const WalletTypeNormalRide({
    super.key,
    required this.isCash,
    required this.typeWallet,
    required this.price,
    required this.instruction,
  });

  final bool isCash;
  final String typeWallet;
  final String price;
  final String instruction;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text:typeWallet,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xff04034D),
                ),
              ),
              TextSpan(
                text:price,
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w300,
                  color: const Color(0xff475467),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: SizedBox(
            width: 240.w,
            child: Text(
              instruction,
              style: TextStyle(
                letterSpacing: 0,
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color:
                    isCash ? const Color(0xff4266fff) : const Color(0xff475467),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
