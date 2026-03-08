import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/widgets/custom_textt_field.dart';
import 'package:go_car/features/passenger/normal_ride/model/normal_ride_model.dart';
import 'package:go_car/features/passenger/normal_ride/widgets/search_location.dart';

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
      padding: const EdgeInsets.symmetric(horizontal: 20,),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                child: CustomTextFieldValidator(
                  isCurrentLocation:true,
                  labelText: "Current Location",
                  enableBorder: true,
                  isPrefixIcon: true,
                  enableAddress: false,
                  controller: normalCubit.currentLocationCon,
                  enableTextField: false,),
                onTap: () {
                  CacheHelper().saveData(key:ApiKeys.currentLocation, value:normalCubit.currentLocationCon.text);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) =>
                          SearchLocationAndDestination(
                              isCurrentLocation: true)));
                },
              ),

              GestureDetector(
                child: CustomTextFieldValidator(
                  isCurrentLocation:false,
                  enableBorder: true,
                  enableAddress: false,
                  isPrefixIcon: true,
                  labelText: "Where to",
                  controller: normalCubit.destinationCon,
                  enableTextField: false,),
                onTap: () {
                  CacheHelper().saveData(key:ApiKeys.destination, value:normalCubit.destinationCon.text);
                  Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) =>
                          SearchLocationAndDestination(
                              isCurrentLocation: false)));
                },
              ),

              Padding(
                padding: EdgeInsets.symmetric(vertical:7.h),
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
                // normalCubit: normalCubit,
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
                //   normalCubit: normalCubit,
                isPassenger: false,
                onSelect: (int index) {
                  normalCubit.changeLuggageIndex(index: index);

                  normalCubit.getEstimatedTime(
                      normalCubit.normalRide?.distanceKm);
                },
                selectedIndex: normalCubit.currentLuggageIndex,
              ),
              // Summary container
              DisplayNormalRideDataItems(normalCubit: normalCubit),
              CustomElevatedBtn(
                btnName: 'Done',
                onPressed: (){
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  showSnackBar(context, message: 'Request Sent Completed ');
                  // final tripId = CacheHelper().getData(key: ApiKeys.tripId);
                  // debugPrint(
                  //   "=====================TripId : ${tripId
                  //       .toString()}========================",
                  // );
                  Navigator.pushNamed(context, Routes.normalPayment,);
                },
              ),
            ],
          ),
          Positioned(
            top: 50.h,
            right: 15,
            child: SizedBox(
              height:30.h,
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
