


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';

import 'build_normal_ride_data_item.dart';

class DisplayNormalRideDataItems extends StatelessWidget {
  const DisplayNormalRideDataItems({
    super.key,required this.normalCubit
  });
final NormalRideCubit normalCubit;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0.h),
      child: Container(
        width: double.infinity,
        height: 153.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(16.r),
          ),
          color: Colors.white,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 14.0.w,
            vertical: 12.h,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    "assets/images/from_to_image.svg",
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.start,
                    children: [
                      Text(
                        "From",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      //        Text(normalRideCubit.currentLocation.text),
                      Text("${normalCubit.currentLocationCon.text}"),
                      SizedBox(height: 15.h),
                      Text(
                        "To",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      //     Text(normalRideCubit.destination.text),
                      Text("${normalCubit.destinationCon.text}"),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 25.h),
              Row(
                mainAxisAlignment:
                MainAxisAlignment.spaceBetween,
                children: [
                  BuildNormalRideDataItem(
                    "assets/images/noun_distance.svg",
                    "${normalCubit.normalRide?.distanceKm?.toStringAsFixed(2)} Km",
                  ),
                  BuildNormalRideDataItem(
                    "assets/images/noun_time.svg",
                    "${normalCubit.getEstimatedTime(normalCubit.normalRide?.distanceKm)} Mins",
                  ),
                  BuildNormalRideDataItem(
                    "assets/images/noun_passenger.svg",
                    "${normalCubit.currentPassengersIndex} Passengers",
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}