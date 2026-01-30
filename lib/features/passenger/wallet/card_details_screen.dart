import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/features/passenger/Wallet/widgets/card_item.dart';

import '../../../core/widgets/confirmation_delete_dialog.dart';

class CardDetailsScreen extends StatelessWidget {
  const CardDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFCFCFD),
        body: Column(
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
                  // // top: 10,
                  left: 20.w,
                  right: 20.w,
                  bottom: -40.h,
                  child: Column(
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                          Center(
                            child: Text(
                              'Card details',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
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

            SizedBox(height: 40.h),

            Padding(
              padding: EdgeInsets.all(20.0.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //-------------------------------- delete card ---------------
                  BulidCardAction(
                    actionImg: 'assets/images/credit-card.png',
                    actionName: 'Delete',
                    onTap:
                        () => confirmationDeleteDialog(
                          onPressed: () {},
                          context,
                          text:
                              'Once you delete this card it will be gone forever.',
                        ),
                  ),

                  //--------------------------------- pinned ----------------
                  BulidCardAction(
                    onTap: () {},
                    isPinned: true,
                    actionImg: 'assets/images/pin.png',
                    actionName: 'Pinned',
                  ),
                  //-------------------------- transactions ---------------------
                  BulidCardAction(
                    onTap: () {
                      Navigator.pushNamed(context, Routes.cardTransactions);
                    },
                    actionImg: 'assets/images/online-banking.png',
                    actionName: 'transactions',
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

class BulidCardAction extends StatelessWidget {
  const BulidCardAction({
    super.key,
    required this.actionImg,
    required this.actionName,
    required this.onTap,
    this.isPinned = false,
  });

  final String actionImg;
  final String actionName;
  final VoidCallback onTap;
  final bool isPinned;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 103.67.w,
        height: 100.h,
        padding: EdgeInsets.symmetric(vertical: 12.h),
        decoration: BoxDecoration(
          color: isPinned ? Color(0xffE8EEFB) : Colors.white,
          border: Border.all(
            color: isPinned ? Color(0xff183E91) : Color(0xffEAECF0),

            width: 1.w,
          ),
          borderRadius: BorderRadiusDirectional.circular(8.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // SvgPicture.asset(actionImg, width: 40.w, height: 40.h),
            Image.asset(actionImg, width: 40.w, height: 40.h,),
            SizedBox(height: 8.h),
            Text(
              actionName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
