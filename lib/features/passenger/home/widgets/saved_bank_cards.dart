import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/routing/routes.dart';
import '../../normal_ride/cubit/normal_ride_cubit.dart' show NormalRideCubit;
import '../../normal_ride/cubit/normal_ride_state.dart';
import 'add_visa_container.dart';

class SavedBankCards extends StatelessWidget {
  SavedBankCards({super.key, this.selectedCardIndex});

  int? selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NormalRideCubit, RequestRideState>(
      listener: (context, state) {
        if (state is! VisaBankAddedState) {
          SizedBox();
        }
      },
      builder: (context, state) {
        final cubit = NormalRideCubit.get(context);
        return Container(
          height: 250.h,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      "Saved Card",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontSize: 16.sp,
                        letterSpacing: 0,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff121212),
                      ),
                    ),
                    const Spacer(),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.addNewCard,
                          arguments: {
                            'onPaymentChosen': () {
                              Navigator.pushNamed(
                                context,
                                Routes.schdulePayment,
                              );
                            },
                            'isNormal': true,
                          },
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.add,
                            color: Color.fromARGB(255, 104, 107, 112),
                          ),
                          SizedBox(width: 5.w),
                          Text(
                            "Add New Card",
                            style: TextStyle(
                              fontFamily: "Cairo",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xff266FFF),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                SizedBox(
                  height: 200.h,
                  child: cubit.visaCards.isEmpty
                      ? const Center(child: Text("No saved cards"))
                      : ListView.builder(
                    itemCount: cubit.visaCards.length,
                    itemBuilder: (context, index) {
                      final card = cubit.visaCards[index];
                      final isSelected =
                          cubit.selectedVisaCard?.id == card.id;

                      return AddVisaContainer(
                        image: Image.asset(
                          card.image ?? '',
                          width: 38.w,
                          height: 38.h,
                        ),
                        text: card.name ?? '',
                        number: card.number ?? '',
                        index: index,
                        isSelected: isSelected,
                        onSelect: (selectedIndex) {
                          cubit.selectVisaBank(index: selectedIndex);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// AddVisaContainer(
//   image: Image.asset(
//     "assets/images/visa.png",
//     width: 38.w,
//     height: 38.h,
//   ),
//   text: "Aareal Bank AG \n",
//   number: "XXXXXXXXX236",
//   index: 1,
//   isSelected: selectedCardIndex == 1,
//   onSelect: (index) => setState(() => selectedCardIndex = index),
// ),
// AddVisaContainer(
//   image: Image.asset(
//     "assets/images/visa1.png",
//     width: 38.w,
//     height: 38.h,
//   ),
//   text: "Aareal Bank AG \n",
//   number: "XXXXXXXXX236",
//   index: 2,
//   isSelected: selectedCardIndex == 2,
//   onSelect: (index) => setState(() => selectedCardIndex = index),
// ),
