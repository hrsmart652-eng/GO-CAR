import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/features/passenger/home/widgets/add_container.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';
import '../../../../core/widgets/show_snackbar.dart';
import '../../normal_ride/widgets/wallet_type_normal_ride.dart';
import '../../normal_ride/widgets/wallet_type_ride_cart.dart';

class PaymentMethod extends StatefulWidget {
  const PaymentMethod({super.key});

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  bool isCash = false;
  bool isCredit = false;
  int selectedCardIndex = -1;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NormalRideCubit, RequestRideState>(
      // listenWhen: (previous, current) {
      //   return current is WalletRideSuccess ||
      //       (current is RequestRideFailure && previous is! RequestRideSuccess);
      // },
      listener: (context, state) {
        if (state is RequestRideFailure) {
          ScaffoldMessenger.of(context).hideCurrentSnackBar();
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        } else if (state is WalletRideSuccess) {
          // showSnackBar(context,message:'Wallet Completed Successfully');
        }
      },
      builder: (context, state) {
        final normalCubit = NormalRideCubit.get(context);
        if (state is RequestRideLoading) {
          return Scaffold(
            body: const Center(child: CircularProgressIndicator()),
          );
        }
        return Scaffold(
          appBar: customAppBar(title: ''),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  WalletTypeRideCart(
                    image: "assets/images/noun-cash.svg",
                    walletType: WalletTypeNormalRide(
                      isCash: !isCash,
                      typeWallet: 'Cash',
                      price: '(10 SEK)',
                      instruction:
                          "If there is a traffic jam the estimated price will increase",
                    ),
                    context: context,
                    isCach: !isCash,
                    walletOnTap: () {
                      setState(() {
                        isCash = false;
                        isCredit = false;
                        normalCubit.paymentMethod = 'cash';
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                  WalletTypeRideCart(
                    image: "assets/svgs/credit-card.svg",
                    walletType: WalletTypeNormalRide(
                      isCash: isCash,
                      typeWallet: 'Credit card',
                      price: ' (10+1 SEK)',
                      instruction:
                          "we will take 1 SEK from your card until you finished the ride then you will take \n it back",
                    ),
                    context: context,
                    isCach: isCash,
                    walletOnTap: () {
                      setState(() {
                        isCash = true;
                        isCredit = false;
                        normalCubit.paymentMethod = 'credit Card';
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                  isCredit ? addContainer() : SizedBox(height: 250.h),
                  CustomElevatedBtn(
                    btnName: "Pay",
                    onPressed: () async {
                      ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      await normalCubit.requestRide();
                      showSnackBar(context,message:'Wallet Completed Successfully');
                      Navigator.pushNamed(context, Routes.findDriver);
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
