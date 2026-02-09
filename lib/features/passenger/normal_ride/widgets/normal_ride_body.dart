import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/passenger/normal_ride/model/normal_ride_model.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';
import '../../../../core/widgets/show_snackbar.dart';
import '../cubit/normal_ride_cubit.dart';
import 'display_normal_ride_data_items.dart';
import 'passenger_and_lugage_num_items.dart';

Widget NormalRidetBody({
  required NormalRideCubit normalCubit,
  required BuildContext context,
}) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(16.r),
        topRight: Radius.circular(16.r),
      ),
      color: const Color(0xffEAECF0),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Current Location Field
              TextFormField(
                controller: normalCubit.currentLocationCon,
                onChanged: (location) {
                  normalCubit.setCurrentLocation(fromLocation: location);
                },
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Current location',
                  labelStyle: TextStyle(
                    color: const Color(0xff475467),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.all(5.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.circle,
                    color: const Color(0xff5F00FB),
                    size: 8.w,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              // Destination Field
              TextFormField(
                controller: normalCubit.destinationCon,
                onChanged: (location) {
                  normalCubit.setDestination(toLocation: location);
                },
                decoration: InputDecoration(
                  isDense: true,
                  labelText: 'Where to?',
                  labelStyle: TextStyle(
                    color: const Color(0xff475467),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  contentPadding: const EdgeInsets.all(5.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.r),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.circle,
                    color: const Color(0xff60BF95),
                    size: 8.w,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 13.h),
                child: Text(
                  "Passengers no.",
                  style: TextStyle(
                    color: const Color(0xff475467),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              // Passengers number
              PassengerAndLugageNumItems(
                normalCubit: normalCubit,
                selectedIndex: normalCubit.currentPassengersIndex,
                isPassenger: true,
                onSelect: (int index) {
                  normalCubit.changePassengerIndex(index: index - 1);
                },
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 13.h),
                child: Text(
                  "Luggage no.",
                  style: TextStyle(
                    color: const Color(0xff266FFF),
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),

              // Luggage number
              PassengerAndLugageNumItems(
                normalCubit: normalCubit,
                isPassenger: false,
                onSelect: (int index) {
                  normalCubit.changeLuggageIndex(index: index);
                },
                selectedIndex: normalCubit.currentLuggageIndex,
              ),
              // Summary container
              DisplayNormalRideDataItems(normalCubit: normalCubit),
              CustomElevatedBtn(
                btnName: 'Done',
                onPressed: () {
                 // ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  showSnackBar(context,message:'Request Sent Completed ');
                  final tripId = CacheHelper().getData(key: ApiKeys.tripId);
                  debugPrint(
                    "=====================TripId : ${tripId.toString()}========================",
                  );
                  Navigator.pushNamed(context, Routes.paymentMethod);
                },
              ),
            ],
          ),
          Positioned(
            top: 37,
            right: 15,
            child: SizedBox(
              height: 30.h,
              width: 30.w,
              child: FloatingActionButton.extended(
                onPressed: () {},
                backgroundColor: const Color(0xff266FFF),
                label: SvgPicture.asset('assets/images/floating_image.svg'),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
