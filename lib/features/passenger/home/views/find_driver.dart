import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_state.dart';

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
    return BlocConsumer<RequestRideCubit, RequestRideState>(
      listener: (context, state) {
        if (state is RequestRideFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        } else if (state is ClientProfileSuccess) {
          // how get data for client

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Welcome ${state.clientModel.fullName}')),
          // );
        }
      },
      builder: (context, state) {
        if (state is RequestRideLoading) {
          return const Center(child: CircularProgressIndicator());
        }
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
                    TextField(
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
                    SizedBox(height: 8.h),

                    // Where to   ****************************************
                    TextField(
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
                  ],
                ),
              ),
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
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(16),

                  height: 175.h,
                  alignment: Alignment.topCenter,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '122 EGP',

                            style: TextStyle(
                              foreground:
                                  Paint()
                                    ..shader = const LinearGradient(
                                      colors: [
                                        Color(0xFF183E91),
                                        Color(0xFF266FFF),
                                      ],
                                      begin: Alignment.bottomLeft,
                                      end: Alignment.topRight,
                                    ).createShader(
                                      const Rect.fromLTWH(0, 0, 200, 70),
                                    ),

                              fontSize: 18,

                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          TextButton(
                            child: Text(
                              'Cancel',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationColor: const Color(0xffF04438),
                                decorationThickness: 1.2,
                                color: Color(0xffF04438),
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            onPressed: () {
                              context
                                  .read<RequestRideCubit>()
                                  .cancelRide(
                                    CacheHelper()
                                        .getData(key: ApiKeys.tripCode)
                                        .toString(),
                                  )
                                  .then((_) {
                                    Navigator.of(
                                      context,
                                    ).pushNamed(Routes.home);
                                  });
                            },
                          ),
                        ],
                      ),
                      Image.asset('assets/images/car_outline.png', width: 350),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
