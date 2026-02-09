import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/core/widgets/show_snackbar.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_state.dart';

import '../../normal_ride/widgets/custom_location_destination_ride.dart';
import '../widgets/custom_find_driver_text.dart';

class FindDriver extends StatefulWidget {
  const FindDriver({super.key});

  @override
  State<FindDriver> createState() => _FindDriverState();
}

class _FindDriverState extends State<FindDriver> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(Duration(seconds: 5), () {
  //     if (mounted) Navigator.pushNamed(context, Routes.showPrice);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NormalRideCubit, RequestRideState>(
      listener: (context, state) {
        if (state is RequestRideFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }

        else if (state is RequestRideSuccess) {
          // how get data for client

        showSnackBar(context, message:"Trip Cancelled Successfully");
        }
      },
      builder: (context, state) {
        if (state is RequestRideLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
         final cubit=NormalRideCubit.get(context);
        return Scaffold(
          body: Stack(
            children: [
              Image(
                image: const AssetImage("assets/images/map.png"),
                fit: BoxFit.cover,
                width: 375.w,
                height: 685.h,
              ),
              CustomLocationAndDestinationRide(),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(10),
                  height: 200.h,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Color(0xffFEDF89),
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Text(
                    'If there is a traffic jam the estimated price will increase',
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xff121212),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              CustomFindDriverRequestCancel(height:170.h ,context: context, normalCubit:cubit)
            ],
          ),
        );
      },
    );
  }
}


