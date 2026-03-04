import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';
import 'package:go_car/features/passenger/schedule_ride/cubit/scheduled_ride_cubit.dart';
import 'package:go_car/features/passenger/schedule_ride/cubit/scheduled_ride_state.dart';
import 'package:go_car/features/passenger/schedule_ride/views/widgets/schdule_save_bank_visa.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';
import '../../../../core/widgets/show_snackbar.dart';
import '../../home/widgets/saved_bank_cards.dart';
import '../../normal_ride/widgets/wallet_type_normal_ride.dart';
import '../../normal_ride/widgets/wallet_type_ride_cart.dart';

class SchdulePaymentScreen extends StatefulWidget {
  const SchdulePaymentScreen({super.key});

  @override
  State<SchdulePaymentScreen> createState() => _SchdulePaymentScreenState();
}

class _SchdulePaymentScreenState extends State<SchdulePaymentScreen> {
  bool isCash = false;
  bool isCredit = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduledRideCubit, ScheduledRideState>(
      listener: (context, state) {
        if (state is ScheduledRideFailure) {
          showSnackBar(context, message: state.errMessage);
        }
        if (state is ScheduledRideLoading) {

        }
      },
      builder: (context, state) {
        final cubit = ScheduledRideCubit.get(context);
        return Scaffold(
          appBar: customAppBar(title: ''),
          backgroundColor: Colors.white,

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WalletTypeRideCart(
                    image: "assets/images/noun-cash.svg",

                    walletType: WalletTypeNormalRide(
                      isCash: isCash,
                      typeWallet: 'Cash',
                      price: '(10 SEK)',
                      instruction:
                          "If there is a traffic jam the estimated price will increase",
                    ),

                    context: context,
                    isCach: isCash,

                    walletOnTap: () {
                      setState(() {
                        isCash = true;
                        isCredit = false;

                        cubit.choosePaymentMethod(paymentMethod: 'cash');
                      });
                    },
                  ),

                  SizedBox(height: 20.h),

                  /// CREDIT
                  WalletTypeRideCart(
                    image: "assets/svgs/credit-card.svg",

                    walletType: WalletTypeNormalRide(
                      isCash: isCredit,
                      typeWallet: 'Credit Card',
                      price: '(10+1 SEK)',
                      instruction: "We will take 1 SEK until ride finished",
                    ),

                    context: context,
                    isCach: isCredit,

                    walletOnTap: () {
                      setState(() {
                        isCash = false;
                        isCredit = true;

                        cubit.choosePaymentMethod(paymentMethod: 'credit');
                      });
                    },
                  ),

                  SizedBox(height: 20.h),

                  /// SAVED CARDS
                  isCredit ? SchduleSaveVisaBank(selectedCardIndex:cubit.selectedVisaIndex,) : SizedBox(height: 250.h),

                  SizedBox(height: 20.h),

                  /// PAY BUTTON
                  state is RequestRideLoading?CircularProgressIndicator():CustomElevatedBtn(
                    btnName: "Pay",

                    onPressed: () async {
                      /// VALIDATION
                      if (!isCash && !isCredit) {
                        showSnackBar(
                          context,
                          message: "Please choose payment method",
                        );
                        return;
                      }
                      await cubit.requestRide();

                      Navigator.pushNamed(context, Routes.requestSendScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

/*
Scaffold(
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
* */
