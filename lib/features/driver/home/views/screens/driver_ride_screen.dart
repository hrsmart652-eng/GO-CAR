import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/home/cubit/driver_ride_cubit.dart';
import 'package:go_car/features/driver/home/cubit/new_trip_cubit.dart';
import 'package:go_car/features/driver/home/cubit/new_trip_state.dart';
import 'package:go_car/features/driver/home/views/widgets/normal_ride/cancel_bar.dart';
import 'package:go_car/features/driver/home/views/widgets/normal_ride/ride_details.dart';
import 'package:go_car/features/driver/home/views/widgets/normal_ride/thank_you.dart';
import '../../../../../core/widgets/custom_elevated_btn.dart';
import '../widgets/normal_ride/ride_end_details.dart';

class DriverRideScreen extends StatefulWidget {
  const DriverRideScreen({super.key});

  @override
  State<DriverRideScreen> createState() => _DriverRideScreenState();
}

class _DriverRideScreenState extends State<DriverRideScreen> {
  bool scrolled = false;
  double position = 200.0;
  bool started = false;
  bool atLocation = false;
  bool ended = false;

  @override
  void initState() {
    super.initState();
    context.read<NewTripCubit>().getNewTrip();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewTripCubit, NewTripState>(
      listener:
          (context, state) => {
            if (state is NewTripFailure)
              {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errMessage))),
              }
            else if (state is NewTripSuccess)
              {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('Success'))),
              },
          },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xffFCFCFD),
          body: SafeArea(
            child: Column(
              children: [
                ended ? ThankYou() : CancelBar(),
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          'assets/images/map.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        bottom: scrolled ? 540 : 230,
                        right: 0,
                        child: TextButton(
                          onPressed: () {},
                          child: Image.asset(
                            'assets/images/location.png',
                            width: 60.w,
                          ),
                        ),
                      ),
                      ended
                          ? Container()
                          : atLocation
                          ? Positioned(
                            bottom: scrolled ? 500 : 160,

                            left: 0,
                            child: Container(
                              width: 360.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                color: Color(0xffFEDF89),
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'If there is a traffic jam the estimated price will increase',
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          )
                          : Container(),
                      NotificationListener<DraggableScrollableNotification>(
                        onNotification: (notification) {
                          final isScrolled =
                              notification.extent >
                              0.3 + 0.01; // adjust threshold
                          if (isScrolled != scrolled) {
                            setState(() {
                              scrolled = isScrolled;
                            });
                          }
                          return true;
                        },
                        child: DraggableScrollableSheet(
                          initialChildSize: ended ? 0.75 : 0.3,
                          minChildSize: 0.3,
                          maxChildSize: 0.75,
                          builder: (context, scrollController) {
                            return Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(16),
                                  topRight: Radius.circular(16),
                                ),
                              ),
                              child:
                                  ended
                                      ? RideEndDetails()
                                      : ListView(
                                        padding: EdgeInsets.all(8),
                                        controller: scrollController,
                                        physics:
                                            AlwaysScrollableScrollPhysics(),
                                        children: [
                                          Center(
                                            child: Container(
                                              color: Color(0xff475467),
                                              width: 60.w,
                                              height: 3.h,
                                            ),
                                          ),
                                          scrolled
                                              ? SizedBox(height: 10.h)
                                              : Text(
                                                state is NewTripSuccess
                                                    ? state.trips[0].price
                                                        .toString()
                                                    : 'Loading...',
                                                style: TextStyle(
                                                  color: Color(0xff027A48),

                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              ),

                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    children: [
                                                      started
                                                          ? Container(
                                                            width: 58.w,
                                                            height: 22.h,
                                                            color: Color(
                                                              0xffE8FFF2,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'On ride',
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xff027A48,
                                                                  ),

                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          : atLocation
                                                          ? Container(
                                                            width: 58.w,
                                                            height: 22.h,
                                                            color: Color(
                                                              0xffFFFAEB,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Waiting',
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xffB54708,
                                                                  ),

                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          )
                                                          : Container(
                                                            width: 58.w,
                                                            height: 22.h,
                                                            color: Color(
                                                              0xffF0F9FF,
                                                            ),
                                                            child: Center(
                                                              child: Text(
                                                                'Pre-ride',
                                                                style: TextStyle(
                                                                  color: Color(
                                                                    0xff266FFF,
                                                                  ),

                                                                  fontSize: 12,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w500,
                                                                ),
                                                              ),
                                                            ),
                                                          ),

                                                      SizedBox(
                                                        width: 68.w,
                                                        height: 22.h,
                                                        child: Center(
                                                          child: Text(
                                                            '00:22',
                                                            style: TextStyle(
                                                              color: Color(
                                                                0xff475467,
                                                              ),

                                                              fontSize: 24,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  SizedBox(width: 10.w),
                                                  Container(
                                                    width: 2.w,
                                                    height: 52.h,
                                                    color: Color(0xffEAECF0),
                                                  ),
                                                  SizedBox(width: 15.w),
                                                  Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceEvenly,
                                                        children: [
                                                          Text(
                                                            '40Km',
                                                            style: TextStyle(
                                                              color: Color(
                                                                0xff475467,
                                                              ),

                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                          SizedBox(width: 15.w),
                                                          Text(
                                                            '.',
                                                            style: TextStyle(
                                                              color: Color(
                                                                0xff475467,
                                                              ),

                                                              fontSize: 20,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w800,
                                                            ),
                                                          ),
                                                          SizedBox(width: 15.w),
                                                          Text(
                                                            '32 Mins',
                                                            style: TextStyle(
                                                              color: Color(
                                                                0xff475467,
                                                              ),

                                                              fontSize: 16,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      Text(
                                                        'From pick-up to drop location',
                                                        style: TextStyle(
                                                          color: Color(
                                                            0xff475467,
                                                          ),

                                                          fontSize: 12,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(width: 20.w),
                                              SizedBox(
                                                width: 62.w,
                                                height: 62.h,
                                                child: TextButton(
                                                  onPressed: () {},
                                                  child: Image.asset(
                                                    'assets/images/call.png',
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          scrolled
                                              ? RideDetailsScrolled()
                                              : Container(),
                                          SizedBox(height: 10.h),

                                          started
                                              ? Container(
                                                width: 343.w,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff266FFF),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: CustomElevatedBtn(
                                                  btnName: 'End ride',
                                                  onPressed: () {
                                                    context
                                                        .read<DriverRideCubit>()
                                                        .endRide(
                                                          CacheHelper().getData(
                                                            key:
                                                                ApiKeys
                                                                    .tripCode,
                                                          ),
                                                        );
                                                    setState(() {
                                                      ended = true;
                                                    });
                                                  },
                                                ),
                                              )
                                              : atLocation
                                              ? Container(
                                                width: 343.w,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff266FFF),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: CustomElevatedBtn(
                                                  btnName: 'Start ride',
                                                  onPressed: () {
                                                    context
                                                        .read<DriverRideCubit>()
                                                        .startRide(
                                                          CacheHelper().getData(
                                                            key:
                                                                ApiKeys
                                                                    .tripCode,
                                                          ),
                                                        );
                                                    setState(() {
                                                      started = true;
                                                    });
                                                  },
                                                ),
                                              )
                                              : Container(
                                                width: 343.w,
                                                decoration: BoxDecoration(
                                                  color: Color(0xff266FFF),
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                ),
                                                child: CustomElevatedBtn(
                                                  btnName: 'I\'m at location',
                                                  onPressed: () {
                                                    context
                                                        .read<DriverRideCubit>()
                                                        .inLocation(
                                                          CacheHelper().getData(
                                                            key:
                                                                ApiKeys
                                                                    .tripCode,
                                                          ),
                                                        );
                                                    setState(() {
                                                      atLocation = true;
                                                    });
                                                  },
                                                ),
                                              ),
                                        ],
                                      ),
                            );
                          },
                        ),
                      ),
                    ],
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
