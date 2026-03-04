import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';
import '../../../../core/widgets/show_snackbar.dart';
import '../../normal_ride/cubit/normal_ride_cubit.dart';
import '../../normal_ride/cubit/normal_ride_state.dart';
import '../../normal_ride/widgets/wallet_type_normal_ride.dart';
import '../../normal_ride/widgets/wallet_type_ride_cart.dart';
import '../widgets/saved_bank_cards.dart';


class NormalPaymentScreen extends StatefulWidget {
  const NormalPaymentScreen({super.key});

  @override
  State<NormalPaymentScreen> createState() => _NormalPaymentScreenState();
}

class _NormalPaymentScreenState extends State<NormalPaymentScreen> {
  bool isCash = false;
  bool isCredit = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NormalRideCubit, RequestRideState>(

      /// LISTENER
      listener: (context, state) {

        if (state is RequestRideFailure) {
          showSnackBar(
            context,
            message: state.errMessage,
          );
        }

      },

      builder: (context, state) {
        final normalCubit = NormalRideCubit.get(context);
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
                        normalCubit.choosePaymentMethod(paymentMethod: 'cash',
                        );
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
                      instruction:
                      "We will take 1 SEK until ride finished",
                    ),

                    context: context,
                    isCach: isCredit,

                    walletOnTap: () {
                      setState(() {
                        isCash = false;
                        isCredit = true;

                        normalCubit.choosePaymentMethod(
                          paymentMethod: 'credit',
                        );
                      });
                    },
                  ),

                  SizedBox(height: 20.h),

                  /// SAVED CARDS
                  isCredit
                      ?  SavedBankCards()
                      : SizedBox(height: 250.h),

                  SizedBox(height: 20.h),

                  /// PAY BUTTON
                 state is RequestRideLoading?CircularProgressIndicator(): CustomElevatedBtn(
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
                      await normalCubit.requestRide();

                      Navigator.pushNamed(
                        context,
                        Routes.findDriver,
                      );
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
