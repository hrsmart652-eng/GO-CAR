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
                        color: Color(0xff121212),
                      ),
                    ),
                    Spacer(),

                    GestureDetector(
                      onTap:() {
                        Navigator.pushNamed(
                          context,
                          Routes.addNewCard,
                          arguments: {
                            'onPaymentChosen':
                                (){
                              Navigator.pushNamed(context,Routes.normalPayment);
                            },
                            'isNormal': true,
                          },
                        );
                      },
                      child: Row(
                        children: [
                          Icon(
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
                              color: Color(0xff266FFF),
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
                  child: ListView.builder(
                    itemCount: cubit.savedVisaCards.length,
                    itemBuilder: (context, index) {
                      return AddVisaContainer(
                        image: Image.asset(
                          "${cubit.visaCards[index].image}",
                          width: 38.w,
                          height: 38.h,
                        ),
                        text: "${cubit.visaCards[index].name}",
                        number: "${cubit.visaCards[index].number}",
                        index: cubit.visaCards[index].id!,
                        isSelected:
                            cubit.selectedVisaCard?.id ==
                            cubit.visaCards[index].id,
                        onSelect: (index) {
                          cubit.selectVisaBank(index: index);
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
