import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/custom_elevated_btn.dart';
import '../../../../../core/widgets/custom_textt_field.dart';
import '../../../../../core/widgets/show_snackbar.dart';
import '../../cubit/scheduled_ride_cubit.dart';
import '../../cubit/scheduled_ride_state.dart';

class SchduleTripSearchLocationDestination extends StatelessWidget {
   SchduleTripSearchLocationDestination({super.key,this.isCurrentLocation=false});
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final bool isCurrentLocation;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduledRideCubit, ScheduledRideState>(
      listener: (context, state) {},
      builder: (context, state) {
        final schduleCubit = ScheduledRideCubit.get(context);
        return Scaffold(
          body: Form(
            key:formKey,
            child: Stack(
              children: [
                // Background Map
                IgnorePointer(
                  child: Image(
                    image: const AssetImage("assets/images/map.png"),
                    fit: BoxFit.cover,
                    width: 375.w,
                    height: 685.h,
                  ),
                ),
                // Close Button
                Positioned(
                  right:5.w,
                  top:30.h,
                  child:IconButton(
                    iconSize: 20.w,
                    style: IconButton.styleFrom(
                      backgroundColor: Colors.grey.shade300,
                      shape: const CircleBorder(),
                      padding: EdgeInsets.all(8.w),
                      foregroundColor: Colors.black87,
                    ),
                    onPressed: () {
                      schduleCubit.clearLocation();
                    },
                    icon: const Icon(Icons.close_rounded),
                  ),

                ),

                // Current Location Field
                Positioned(
                  right: 55.w,
                  left: 20.w,
                  top: 10.h,
                  child: SizedBox(
                    width: 300.w,
                    height: 120.h,
                    child: CustomTextFieldValidator(
                      enableBorder:true,
                      enableAddress:false,
                      enableTextField: true,
                      isCurrentLocation:isCurrentLocation,
                      isPrefixIcon: true,
                      controller:
                      isCurrentLocation
                          ? schduleCubit.currentLocationCon
                          : schduleCubit.destinationCon,
                      fieldTitle:
                      isCurrentLocation
                          ? "Current Location"
                          : "Destination",
                      validator: (location) {
                        if (location == null || location.isEmpty) {
                          return isCurrentLocation
                              ? "Enter current location"
                              : "Enter destination";
                        }
                        return null;
                      },
                      onChanged: (location) {
                        isCurrentLocation == true
                            ? schduleCubit.setCurrentLocation(
                          fromLocation: location,
                        )
                            : schduleCubit.setDestination(toLocation: location);
                      },
                    ),
                  ),
                ),
                // Done Button
                Positioned(
                  right: 15.w,
                  left: 15.w,
                  bottom: 50.h,
                  child: CustomElevatedBtn(
                    btnSize: Size(343.w, 48.h),
                    btnName: 'Done',
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        String message =isCurrentLocation
                            ? 'Location Selected Successfully'
                            : 'Destination Selected Successfully';

                        showSnackBar(context, message: message);

                        Navigator.pushNamed(context, Routes.schduleHome);
                      }
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
