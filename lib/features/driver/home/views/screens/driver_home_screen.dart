import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/home/cubit/driver_shift_cubit.dart';
import 'package:go_car/features/driver/home/views/widgets/driver_bottom_navigation_bar.dart';
import 'package:go_car/features/driver/home/views/widgets/choose_car.dart';
import 'package:go_car/features/driver/home/views/widgets/driver_app_bar.dart';
import 'package:go_car/features/driver/home/views/widgets/normal_ride/normal_ride.dart';
import 'package:go_car/features/driver/home/views/widgets/ride_type.dart';
import 'package:go_car/features/driver/home/views/widgets/scheduled_ride/scheduled_ride.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_cubit.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_state.dart';

import '../../../../../config/environment.dart';

class DriverHomeScreen extends StatefulWidget {
  const DriverHomeScreen(this.online, {super.key});
  final bool online;
  @override
  State<DriverHomeScreen> createState() => _DriverHomeScreenState();
}

class _DriverHomeScreenState extends State<DriverHomeScreen> {
  ScrollPosition? currentScrollPosition;
  late bool online = widget.online;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      BlocProvider.of<DriverProfileCubit>(context).getDriverProfile();
      if (!online) {
        final result = await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(content: ChooseCar()),
        );
        if (result == true) {
          setState(() {
            online = true;
          });
        }
      }
    });
  }

  int currentIndex = 0;
  int currentCarIndex = 0;
  int currentPassengersIndex = 0;
  int currentLuggageIndex = 0;

  List<Color> activeGrad = [Color(0xff183E91), Color(0xff266FFF)];
  List<Color> unactiveGrad = [
    Color(0xFF344054),
    Color.fromARGB(255, 165, 165, 165),
  ];
  bool checkbox = true;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverProfileCubit, DriverProfileState>(
      listener:
          (context, state) => {
        if (state is DriverProfileFailure)
          {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage))),
          },
      },
      builder: (context, state) {
        return state is DriverProfileLoading
            ? Center(child: CircularProgressIndicator())
            :
        state is DriverProfileSuccess ?
        Scaffold(
          backgroundColor: Color(0xffFCFCFD),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: [
                  DriverAppBar(Name: state.driverProfile.fullName),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0),
                    child: Container(
                      height: 44.h,
                      decoration: BoxDecoration(color: Color(0xffFEFBDA)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Offline',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color(0xFF344054),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            child: Container(
                              width: 50.w,
                              height: 24.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors:
                                  online ? activeGrad : unactiveGrad,
                                ),
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              child: FlutterSwitch(
                                value: online,
                                onToggle: (val) {
                                  setState(() {
                                    online = val;
                                    if (online) {
                                      // Start shift
                                      // context
                                      //     .read<DriverShiftCubit>()
                                      //     .beOnline();
                                      context
                                          .read<DriverShiftCubit>()
                                          .startShift(
                                        carType: CacheHelper().getData(
                                          key: ApiKeys.carType,
                                        ),
                                      );
                                    } else {
                                      // End shift
                                      // context
                                      //     .read<DriverShiftCubit>()
                                      //     .beOffline();
                                      context
                                          .read<DriverShiftCubit>()
                                          .endShift();
                                    }
                                  });
                                },
                                activeColor: Colors.transparent,
                                inactiveColor: Colors.transparent,
                                toggleColor: Colors.white,
                                width: 50.w,
                                height: 24.h,
                                activeSwitchBorder: Border.all(
                                  color: Colors.transparent,
                                ),
                                inactiveSwitchBorder: Border.all(
                                  color: Colors.transparent,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Online',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Color.fromARGB(255, 52, 64, 84),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Accept cash',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff121212),
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                checkbox
                                    ? context
                                    .read<DriverShiftCubit>()
                                    .acceptCash()
                                    : context
                                    .read<DriverShiftCubit>()
                                    .refuseCash();
                                setState(() {
                                  checkbox = !checkbox;
                                });
                              },
                              icon:
                              checkbox
                                  ? Icon(
                                color: Color.fromARGB(
                                  255,
                                  165,
                                  165,
                                  165,
                                ),
                                Icons.check_box_outline_blank,
                              )
                                  : Icon(
                                color: Color(0xff266FFF),
                                Icons.check_box_outlined,
                              ),
                            ),
                          ],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.white,
                          ),
                          width: 434.w,
                          height: 110.h,
                          child: Stack(
                            children: [
                              Positioned(
                                top: -1,
                                left: 10,
                                child: Container(
                                  height: 43.h,
                                  width: 24.w,
                                  decoration: BoxDecoration(
                                    color: Color(0xffEAECF0),
                                  ),
                                  child: Image.asset(
                                    'assets/images/pro.png',
                                    width: 26.w,
                                    height: 26.w,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceAround,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Text(
                                              'Remaining Time',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              '12:00:00',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 1.w,
                                          height: 40.h, // Adjust as needed
                                          color:
                                          Colors
                                              .grey[300], // Or any color you prefer
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Trips',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              '1200',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                        Container(
                                          width: 1.w,
                                          height: 40.h, // Adjust as needed
                                          color: Colors.grey[300],
                                          margin: EdgeInsets.symmetric(
                                            horizontal: 12,
                                          ),
                                        ),
                                        Column(
                                          children: [
                                            Text(
                                              'Km',
                                              style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.w400,
                                              ),
                                            ),
                                            SizedBox(height: 10.h),
                                            Text(
                                              '12K',
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          'Today\'s Total',
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                        Text(
                                          '5000 SEK',
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        RideTypeScreen(
                          onIndexChanged: (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),
                      ],
                    ),
                  ),

                  Expanded(
                    child: SingleChildScrollView(
                      child:
                      currentIndex == 0
                          ? NormalRide()
                          : ScheduledRide(),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: const DriverNavigationBarWidget(
            currentIndex: 0,
          ),
        )
            : Scaffold(
          backgroundColor: Colors.white,
          body: Center(child: Text("Please Sign Up")),
        );
      },
    );
  }
}