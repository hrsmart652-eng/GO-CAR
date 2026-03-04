import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';
import '../../schedule_ride/cubit/scheduled_ride_cubit.dart';
import '../../schedule_ride/cubit/scheduled_ride_state.dart';
import '../widgets/add_visa_container.dart';

// List of Visa Banks
class AddCredit extends StatefulWidget {
  const AddCredit({super.key, this.onPaymentChosen, this.isNormalRide = true});

  final VoidCallback? onPaymentChosen;
  final bool isNormalRide;

  @override
  State<AddCredit> createState() => _AddCreditState();
}

class _AddCreditState extends State<AddCredit> {
  int selectedCardIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child:
          widget.isNormalRide == true
              ? BlocConsumer<NormalRideCubit, RequestRideState>(
                listener: (context, state) {
                  if (state is! VisaBankAddedState) {
                    SizedBox();
                  }
                },
                builder: (context, state) {
                  final cubit = NormalRideCubit.get(context);
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Padding(
                      padding: EdgeInsets.only(
                        left: 16.0.w,
                        right: 16.0.w,
                        top: 70.0.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 22.w,
                            color: const Color(0xff266FFF),
                          ),
                          SizedBox(height: 20.h),
                          SizedBox(
                            height: 450.h,
                            child: ListView.builder(
                              itemCount: cubit.visaCards.length,
                              itemBuilder: (context, index) {
                                return AddVisaContainer(
                                  image: Image.asset(
                                    "${cubit.visaCards[index].image}",
                                    width: 38.w,
                                    height: 38.h,
                                  ),
                                  text: "${cubit.visaCards[index].name}",
                                  number: "${cubit.visaCards[index].number}",
                                  index: index,
                                  isSelected: cubit.selectedVisaIndex == index,
                                  onSelect: (index) {
                                    cubit.selectVisaBank(index: index);
                                  },
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 20.h),
                          CustomElevatedBtn(
                            btnName: "Choose",
                            onPressed: () {
                              cubit.saveVisaBankCards(
                                card: cubit.visaCards[cubit.selectedVisaIndex],
                              );
                              if (widget.onPaymentChosen != null) {
                                widget.onPaymentChosen!();
                              } else {
                                Navigator.pop(context); // fallback
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
              : BlocConsumer<ScheduledRideCubit, ScheduledRideState>(
                listener: (context, state) {
                  if (state is! VisaBankAddedState) {
                    SizedBox();
                  }
                },
                builder: (context, state) {
                  final cubit = ScheduledRideCubit.get(context);
                  return Scaffold(
                    backgroundColor: Colors.white,
                    body: Padding(
                      padding: EdgeInsets.only(
                        left: 16.0.w,
                        right: 16.0.w,
                        top: 70.0.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.arrow_back,
                            size: 22.w,
                            color: const Color(0xff266FFF),
                          ),
                          SizedBox(height: 20.h),
                          SizedBox(
                            height: 450.h,
                            child: ListView.builder(
                              itemCount: cubit.visaCards.length,
                              itemBuilder: (context, index) {
                                return AddVisaContainer(
                                  image: Image.asset(
                                    "${cubit.visaCards[index].image}",
                                    width: 38.w,
                                    height: 38.h,
                                  ),
                                  text: "${cubit.visaCards[index].name}",
                                  number: "${cubit.visaCards[index].number}",
                                  index: index,
                                  isSelected: cubit.selectedVisaIndex == index,
                                  onSelect: (index) {
                                    cubit.selectVisaBank(index: index);
                                  },
                                );
                              },
                            ),
                          ),

                          SizedBox(height: 20.h),
                          CustomElevatedBtn(
                            btnName: "Choose",
                            onPressed: () {
                              cubit.saveVisaBankCards(
                                card: cubit.visaCards[cubit.selectedVisaIndex],
                              );
                              if (widget.onPaymentChosen !=  null) {
                                widget.onPaymentChosen!();
                              } else {
                                Navigator.pop(context); // fallback
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
    );
  }

  Widget addCreditContainer(Image image, String text, int index) {
    final isSelected = selectedCardIndex == index;
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              selectedCardIndex = index;
            });
          },
          child: Container(
            width: double.infinity,
            height: 53.h,
            decoration: BoxDecoration(
              color: isSelected ? Color(0xffF5FAFF) : Colors.white,
              borderRadius: BorderRadius.circular(8.r),
              border:
                  isSelected
                      ? Border.all(color: Color(0xffBBD1FB), width: 1.w)
                      : null,
              boxShadow: [
                BoxShadow(
                  color: Color(0xffB4B4B4).withOpacity(0.16),
                  spreadRadius: 0,
                  blurRadius: 10,
                  offset: Offset(0, 0),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.only(left: 16.0.w),
              child: Row(
                children: [
                  image,
                  SizedBox(width: 16.w),
                  Text(
                    "Aareal Bank AG ",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                      color: Color(0xff121212),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(height: 20.h),
      ],
    );
  }
}
