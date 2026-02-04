import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/features/passenger/home/widgets/add_container.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_state.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';

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
    return BlocConsumer<RequestRideCubit, RequestRideState>(
      listener: (context, state) {
        if (state is RequestRideFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        } else if (state is ClientProfileSuccess) {
          // how get data for client

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Welcome ${state.clientModel.fullName}')),
          // );
        }
      },
      builder: (context, state) {
        if (state is RequestRideLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Scaffold(
          appBar: customAppBar(title: ''),
          backgroundColor: Colors.white,
          body: Padding(
            padding: EdgeInsets.only(left: 16.0.w, right: 16.0.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCash = true;
                        isCredit = false;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: isCash ? 92.h : 112.h,
                      decoration: BoxDecoration(
                        color: isCash ? Color(0xffF5FAFF) : Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color:
                              isCash
                                  ? Color(0xffBBD1FB)
                                  : const Color(0xffEAECF0),
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
                                border: Border.all(
                                  width: 4.w,
                                  color: const Color(0xffF2F4FF),
                                ),
                                color: Color(0xffEBEDFF),
                              ),
                              child: Center(
                                child: SvgPicture.asset(
                                  "assets/images/noun-cash.svg",
                                  width: 16.w,
                                  height: 16.h,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Cash',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xff04034D),
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' (10 SEK)',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w300,
                                          color: const Color(0xff475467),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 240.w,
                                  child: Text(
                                    "If there is a traffic jam the estimated price will increase",
                                    style: TextStyle(
                                      letterSpacing: 0,
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          isCash
                                              ? const Color(0xff4266fff)
                                              : const Color(0xff475467),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            Container(
                              width: 16.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border:
                                    isCash
                                        ? null
                                        : Border.all(
                                          width: 1.w,
                                          color:
                                              isCash
                                                  ? Colors.white
                                                  : Color(0xffD0D5DD),
                                        ),
                                color:
                                    isCash ? Color(0xff266FFF) : Colors.white,
                              ),
                              child:
                                  isCash
                                      ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12.w,
                                      )
                                      : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 20.h),

                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isCredit = true;
                        isCash = false;
                      });
                    },
                    child: Container(
                      width: double.infinity,
                      height: isCredit ? 92.h : 112.h,
                      decoration: BoxDecoration(
                        color: isCredit ? Color(0xffF5FAFF) : Colors.white,
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color:
                              isCredit
                                  ? Color(0xffBBD1FB)
                                  : const Color(0xffEAECF0),
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
                                border: Border.all(
                                  width: 4.w,
                                  color: const Color(0xffF2F4FF),
                                ),
                                color: Color(0xffEBEDFF),
                              ),
                              child: Center(
                                child: Image.asset(
                                  "assets/images/credit_card.png",
                                  width: 16.w,
                                  height: 16.h,
                                ),
                              ),
                            ),
                            SizedBox(width: 10.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Credit card',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              isCredit
                                                  ? Color(0xff266FFF)
                                                  : Color(0xff344054),
                                        ),
                                      ),
                                      TextSpan(
                                        text: ' (10+1 SEK)',
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0,
                                          color: Color(0xff344054),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 240.w,
                                  child: Text(
                                    "we will take 1 SEK from your card until you finished the ride then you will take it back",
                                    style: TextStyle(
                                      fontFamily: "Cairo",
                                      fontSize: 14.sp,
                                      wordSpacing: 0,
                                      fontWeight: FontWeight.w400,
                                      color:
                                          isCredit
                                              ? Color(0xff266FFF)
                                              : Color(0xff475467),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: 16.w,
                              height: 16.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                border:
                                    isCredit
                                        ? null
                                        : Border.all(
                                          width: 1.w,
                                          color:
                                              isCredit
                                                  ? Colors.white
                                                  : Color(0xffD0D5DD),
                                        ),
                                color:
                                    isCredit ? Color(0xff266FFF) : Colors.white,
                              ),
                              child:
                                  isCredit
                                      ? Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 12.w,
                                      )
                                      : null,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  isCredit ? addContainer() : SizedBox(height: 250.h),
                  CustomElevatedBtn(
                    btnName: "Pay",
                    onPressed: () {
                      context.read<RequestRideCubit>()
                        ..paymentMethod =
                            {isCash ? 'cash' : 'credit Card'}.toString()
                        ..requestRide().then((_) {
                          Navigator.pushNamed(context, Routes.findDriver);
                        });
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
