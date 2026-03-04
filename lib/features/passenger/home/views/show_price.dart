import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/passenger/home/widgets/custom_info_driver_sheet.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';

import '../../../../core/widgets/custom_textt_field.dart';
import '../../schedule_ride/cubit/scheduled_ride_cubit.dart';

class ShowPrice extends StatefulWidget {
  const ShowPrice({super.key});

  @override
  State<ShowPrice> createState() => _ShowPriceState();
}

class _ShowPriceState extends State<ShowPrice> {
  NormalRideCubit? normalRideCubit;
@override
  void initState() {
    super.initState();
   normalRideCubit=NormalRideCubit.get(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image(
            image: const AssetImage("assets/images/map.png"),
            fit: BoxFit.cover,
            width: 375.w,
            height: 685.h,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 65.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomTextFieldValidator(
                  isCurrentLocation:true,
                  labelText: "Current Location",
                  enableBorder: true,
                  isPrefixIcon: true,
                  enableAddress: false,
                  controller: normalRideCubit!.currentLocationCon,
                  enableTextField: false,),
                SizedBox(height: 8.h),

                // Where to   ****************************************
                CustomTextFieldValidator(
                  isCurrentLocation:true,
                  labelText: "Where to?",
                  enableBorder: true,
                  isPrefixIcon: true,
                  enableAddress: false,
                  controller: normalRideCubit!.currentLocationCon,
                  enableTextField: false,),
              ],
            ),
          ),
          // const ShowPriceContainerWidget(),

          /// ✨ Animated Positioned
         // CustomDriverInfoSheet(),
        ],
      ),
    );
  }
}


