import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/show_snackbar.dart';
import '../../../home/widgets/add_visa_container.dart';
import '../../cubit/scheduled_ride_cubit.dart';
import '../../cubit/scheduled_ride_state.dart';

class SchduleSaveVisaBank extends StatelessWidget {
  const SchduleSaveVisaBank({super.key});

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
                            'isNormal': false,
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