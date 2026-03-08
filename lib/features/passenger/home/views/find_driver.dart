import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/widgets/show_snackbar.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';

import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/services/api/end_points.dart';
import '../../normal_ride/widgets/custom_location_destination_ride.dart';
import '../widgets/custom_find_driver_text.dart';
import '../widgets/custom_info_driver_sheet.dart';

class FindDriver extends StatefulWidget {
  const FindDriver({super.key});

  @override
  State<FindDriver> createState() => _FindDriverState();
}

class _FindDriverState extends State<FindDriver> {
  NormalRideCubit? normalRideCubit;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      normalRideCubit = NormalRideCubit.get(context);
      normalRideCubit?.startCheckingTripStatus();
    });
  }

  @override
  void dispose() {
    normalRideCubit?.stopCheckingTripStatus();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NormalRideCubit, RequestRideState>(
      // ================= Listener =================
      listener: (context, state) {
        if (state is AllTripsFailureState) {
          showSnackBar(context, message: state.errorMsg);
        }
      },

      // ================= Builder =================
      builder: (context, state) {
        final cubit = NormalRideCubit.get(context);

        return Scaffold(
          body: Stack(
            children: [

              /// ================= Map =================
              Image(
                image: const AssetImage("assets/images/map.png"),
                fit: BoxFit.cover,
                width: 375.w,
                height: 685.h,
              ),

              /// ================= Locations =================
              CustomLocationAndDestinationRide(
                enableNavigate: false,
                currentLocCon: cubit.currentLocationCon,
                destinationCon: cubit.destinationCon,
              ),

              /// ================= Bottom Warning =================
              if (state is! AllTripsSuccessState)
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    height: 200.h,
                    alignment: Alignment.topCenter,
                    decoration: const BoxDecoration(
                      color: Color(0xffFEDF89),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(16),
                        topRight: Radius.circular(16),
                      ),
                    ),
                    child: const Text(
                      'If there is a traffic jam the estimated price will increase',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xff121212),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),

              // if (state is AllTripsSuccessState )
              //   CustomDriverInfoSheet(
              //     check:state.trip.status?.toLowerCase()=="accepted"?Center(child:CircularProgressIndicator(),): CheckStatusEndedTripBtn(),
              //     tripStatusModelModel:state.trip,
              //   ),
              if (state is AllTripsSuccessState)
                CustomDriverInfoSheet(
                  tripStatusModelModel: state.trip,
                  driverInfoModel:state.driverInfo,
                )
              else
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  height: 170.h,
                  child: CustomFindDriverRequestCancel(
                    height: 170.h,
                    context: context,
                    normalCubit: cubit,
                    isNormalRide: false,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}