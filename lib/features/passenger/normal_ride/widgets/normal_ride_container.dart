import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/widgets/custom_elevated_btn.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_state.dart';

class NormalRideContainer extends StatefulWidget {
  const NormalRideContainer({super.key});

  @override
  State<NormalRideContainer> createState() => _NormalRideContainerState();
}

class _NormalRideContainerState extends State<NormalRideContainer> {
  int currentPassengersIndex = 1;
  int currentLuggageIndex = 0;
  int currentCarIndex = 0;

  List<List<dynamic>> carsAndNames = [
    ['assets/images/economy_car.svg', "Economy"],
    ["assets/images/large_car.svg", "Large"],
    ["assets/images/vip_car.svg", "VIP"],
    ["assets/images/pet_car.svg", "Pet"],
  ];

  final TextEditingController currentLocation = TextEditingController();
  final TextEditingController destination = TextEditingController();

  @override
  void dispose() {
    currentLocation.dispose();
    destination.dispose();
    super.dispose();
  }

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
        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 20,
                bottom: 10,
              ),
              child: SizedBox(
                width: 375.w,
                height: 91.h,
                child: Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: carsAndNames.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 25.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      currentCarIndex = index;
                                    });
                                  },
                                  child: Container(
                                    width: 63.w,
                                    height: 63.h,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        width: 1.w,
                                        color:
                                            currentCarIndex == index
                                                ? const Color(0xff344054)
                                                : const Color(0xffE8EEFB),
                                      ),
                                      color: const Color(0xffE8EEFB),
                                    ),
                                    child: Center(
                                      child: SvgPicture.asset(
                                        carsAndNames[index][0],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 7.h),
                                Text(
                                  carsAndNames[index][1],
                                  style: TextStyle(
                                    color: const Color(0xff0D3244),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w500,
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
            ),

            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16.r),
                  topRight: Radius.circular(16.r),
                ),
                color: const Color(0xffEAECF0),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 18,
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Current Location Field
                        TextFormField(
                          controller: currentLocation,
                          onChanged: (_) => setState(() {}),
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
                          controller: destination,
                          onChanged: (_) => setState(() {}),
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
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  currentPassengersIndex = index + 1;
                                });
                              },
                              child: Container(
                                width: 51.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color:
                                      currentPassengersIndex == index + 1
                                          ? const Color(0xff266FFF)
                                          : Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '${index + 1}',
                                    style: TextStyle(
                                      color:
                                          currentPassengersIndex == index + 1
                                              ? Colors.white
                                              : const Color(0xff04034C),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 13.h),
                          child: Text(
                            "Luggage no.",
                            style: TextStyle(
                              color: const Color(0xff475467),
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),

                        // Luggage number
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(6, (index) {
                            return InkWell(
                              onTap: () {
                                setState(() {
                                  currentLuggageIndex = index;
                                });
                              },
                              child: Container(
                                width: 51.w,
                                height: 40.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  color:
                                      currentLuggageIndex == index
                                          ? const Color(0xFFCCCCCC)
                                          : Colors.white,
                                ),
                                child: Center(
                                  child: Text(
                                    '$index',
                                    style: TextStyle(
                                      color:
                                          currentLuggageIndex == index
                                              ? const Color(0xff959595)
                                              : const Color(0xff04034C),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        ),

                        // Summary container
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0.h),
                          child: Container(
                            width: double.infinity,
                            height: 151.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(16.r),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 14.0.w,
                                vertical: 14.h,
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
                                          Text(currentLocation.text),
                                          SizedBox(height: 15.h),
                                          Text(
                                            "To",
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(destination.text),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 25.h),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      _buildInfo(
                                        "assets/images/noun_distance.svg",
                                        "-- Km",
                                      ),
                                      _buildInfo(
                                        "assets/images/noun_time.svg",
                                        "-- Mins",
                                      ),
                                      _buildInfo(
                                        "assets/images/noun_passenger.svg",
                                        "$currentPassengersIndex Passengers",
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        CustomElevatedBtn(
                          btnName: 'Done',
                          onPressed: () {
                            context.read<RequestRideCubit>()
                              ..selectedCarType =
                                  carsAndNames[currentCarIndex][1]
                              ..currentLocation = {
                                "type": "Point",
                                "coordinates": [31.2357, 30.0444],
                              }
                              ..destination = {
                                "type": "Point",
                                "coordinates": [32.2500, 31.0500],
                              }
                              ..scheduledAt = DateTime.now().toIso8601String()
                              ..passengerCount = currentPassengersIndex
                              ..luggageCount = currentLuggageIndex;

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
                          label: SvgPicture.asset(
                            'assets/images/floating_image.svg',
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfo(String asset, String text) {
    return Row(
      children: [
        SvgPicture.asset(asset),
        SizedBox(width: 2.w),
        Text(
          text,
          style: TextStyle(
            color: const Color(0xff121212),
            fontSize: 12.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
