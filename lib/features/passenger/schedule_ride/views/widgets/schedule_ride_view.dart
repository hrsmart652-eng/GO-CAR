import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/widgets/custom_elevated_btn.dart';
import '../../../../../core/routing/routes.dart';
import '../../../normal_ride/widgets/custom_location_destination_ride.dart';
import '../../../normal_ride/widgets/passenger_and_lugage_num_items.dart';
import '../../cubit/scheduled_ride_cubit.dart';
import 'custom_car_type_list_item.dart';
import 'custom_ride_type.dart';

class ScheduleRide extends StatelessWidget {
   ScheduleRide({super.key, required this.scheduledRideCubit});

  final ScheduledRideCubit scheduledRideCubit;

  GlobalKey<FormState> formKey =GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Form(
      key:formKey ,
      child: Column(
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          CustomCarTypeListItem(scheduledRideCubit: scheduledRideCubit),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16.r),
                topRight: Radius.circular(16.r),
              ),
              color: const Color(0xffEAECF0),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                 horizontal: 20,
              ),
              child: Stack(
                children: [
                  Column(
                    crossAxisAlignment:CrossAxisAlignment.start,
                    children: [
                      CustomLocationAndDestinationRide(
                        vertical: 10,
                        key: key,
                        horizontal: 0.0,
                        currentLocCon: scheduledRideCubit.currentLocationCon,
                        destinationCon: scheduledRideCubit.destinationCon,
                      ),
                   //   SizedBox(height: 16),

                        Text(
                          "Ride",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff475467),
                          ),
                        ),


                      SchduleRideType(scheduledRideCubit: scheduledRideCubit),

                      SizedBox(height: 10), // كان 20
                         Text(
                          "Pickup Date",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xff6b7785),
                          ),
                        ),


                      GestureDetector(
                        onTap: () {
                          scheduledRideCubit.selectPickupDateTime(context);
                        },
                        child: AbsorbPointer(
                          child: TextFormField(
                            validator:(value) {
                              if (value == null || value.isEmpty) {
                                return "Pickup date is required";
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Day / Month / year HH:MM',
                            ),
                            controller: TextEditingController(
                              text: scheduledRideCubit.pickupDateTime != null
                                  ? scheduledRideCubit.dateFormat
                                  .format(scheduledRideCubit.pickupDateTime!)
                                  : "",
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 8), // كان 16

                      (scheduledRideCubit.returnRideType ==
                          scheduledRideCubit.selectedRideType)
                          ? Text(
                        "Return time",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Color(0xff6b7785),
                        ),
                      )
                          : SizedBox(),

                      if (scheduledRideCubit.returnRideType ==
                          scheduledRideCubit.selectedRideType)
                        GestureDetector(
                          onTap: () {
                            scheduledRideCubit.selectReturnTime(context);
                          },
                          child: AbsorbPointer(
                            child: TextFormField(
                              validator:(value) {
                                if (value == null || value.isEmpty) {
                                  return "return time is required";
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                hintText: 'HH:MM',
                              ),
                              controller: TextEditingController(
                                text: scheduledRideCubit.returnTime != null
                                    ? scheduledRideCubit.returnTime!
                                    .format(context)
                                    : "",
                              ),
                            ),
                          ),
                        ),

                      SizedBox(height: 16.h), // كان 30.h

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h), // كان 13.h
                        child: Text(
                          "Passengers no.",
                          style: TextStyle(
                            color: const Color(0xff475467),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      PassengerAndLugageNumItems(
                        selectedIndex: scheduledRideCubit.currentPassengersIndex,
                        isPassenger: true,
                        onSelect: (int index) {
                          scheduledRideCubit.currentPassengersIndex = index - 1;
                          scheduledRideCubit.changePassengerIndex(
                              index: index - 1);
                        },
                      ),

                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.h), // كان 13.h
                        child: Text(
                          "Luggage no.",
                          style: TextStyle(
                            color: const Color(0xff266FFF),
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),

                      PassengerAndLugageNumItems(
                        isPassenger: false,
                        onSelect: (int index) {
                          scheduledRideCubit.changeLuggageIndex(index: index);
                        },
                        selectedIndex: scheduledRideCubit.currentLuggageIndex,
                      ),

                      SizedBox(height: 16.h), // كان 30.h

                      CustomElevatedBtn(
                        btnName: 'Send Request',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            Navigator.pushNamed(context, Routes.schdulePayment);
                          }
                        },
                      ),
                    ],
                  ),

                  Positioned(
                    top: 65.h,
                    right: 15,
                    child: SizedBox(
                      height: 30.h,
                      width: 30.w,
                      child: FloatingActionButton.extended(
                        onPressed: () {},
                        backgroundColor: const Color(0xff266FFF),
                        label: SvgPicture.asset(
                          'assets/images/floating_image.svg',
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}