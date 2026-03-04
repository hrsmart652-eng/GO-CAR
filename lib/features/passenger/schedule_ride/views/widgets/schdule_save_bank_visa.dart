import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/show_snackbar.dart';
import '../../../home/widgets/add_visa_container.dart';
import '../../cubit/scheduled_ride_cubit.dart';
import '../../cubit/scheduled_ride_state.dart';

class SchduleSaveVisaBank extends StatelessWidget {
  SchduleSaveVisaBank({super.key, this.selectedCardIndex});

  int? selectedCardIndex;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduledRideCubit, ScheduledRideState>(
      listener: (context, state) {
        if (state is ScheduledRideFailure) {
          showSnackBar(context, message: state.errMessage);
        }
      },
      builder: (context, state) {
        final cubit = ScheduledRideCubit.get(context);
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
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          Routes.addNewCard,
                          arguments: {
                            'onPaymentChosen':
                              (){
                                Navigator.pushNamed(context,Routes.schdulePayment);
                              },
                            'isNormal': false,
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
                        text:
                            "${cubit.visaCards[selectedCardIndex ?? index].name}",
                        number:
                            "${cubit.visaCards[selectedCardIndex ?? index].number}",
                        index: cubit.visaCards[selectedCardIndex ?? index].id!,
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
