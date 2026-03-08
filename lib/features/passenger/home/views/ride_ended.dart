import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';

import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/services/api/end_points.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';
import '../../../../core/widgets/show_snackbar.dart';

class RideEnded extends StatefulWidget {
  const RideEnded({super.key});

  @override
  State<RideEnded> createState() => _RideEndedState();
}

class _RideEndedState extends State<RideEnded> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<NormalRideCubit>().fetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NormalRideCubit, RequestRideState>(
      listener: (context, state) {
        if (state is AllTripsFailureState) {
          showSnackBar(context, message: state.errorMsg);
        }
      },
      builder: (context, state) {
        final cubit = NormalRideCubit.get(context);
        final driver =state is AllTripsSuccessState?state.driverInfo:cubit.driverInfo;
        final driverTrips =state is AllTripsSuccessState?state.driverTrips:cubit.driverTrips;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child:Column(
              children: [

                /// ================= HEADER =================
                Text(
                  "Ride ended",
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),

                SizedBox(height: 4.h),

                Text(
                  "thank you for using YESCAB",
                  style: TextStyle(color: Color(0xff667085), fontSize: 14.sp),
                ),

                SizedBox(height: 10.h),

                /// ================= MAP =================
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Image.asset(
                          "assets/images/rectangle.png",
                          fit: BoxFit.cover,
                        ),
                      ),

                      /// ================= BOTTOM SHEET =================
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 18.h,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(28.r),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(.1),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [

                              /// DRIVER INFO ROW
                              Row(
                                children: [
                                  Stack(
                                    clipBehavior: Clip.none,
                                    alignment: Alignment.bottomCenter,
                                    children: [
                                      CircleAvatar(
                                        radius: 34.r,
                                        backgroundImage:driver!.image
                                            .isNotEmpty
                                            ? NetworkImage(
                                            driver.image)
                                            : const AssetImage(
                                            "assets/images/driver_image.png")
                                        as ImageProvider,
                                      ),
                                      Positioned(
                                        bottom: -10.h,
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10.w, vertical: 3.h),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                                6.r),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.black.withOpacity(
                                                    0.1),
                                                blurRadius: 4,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Text(
                                            '${cubit.normalRide?.trip.carType}',
                                            style: TextStyle(
                                              fontSize: 11.sp,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xff344054),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  SizedBox(width: 12.w),

                                  /// NAME + RATE
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        driver.fullName ?? "",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 15.sp,
                                        ),
                                      ),

                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star,
                                            color: Color(0xffF0C24D),
                                            size: 14.sp,
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            "${cubit.driverReviews?.averageRating}",
                                          ),
                                          SizedBox(width: 4.w),
                                          Text(
                                            "${driverTrips.length} rides",
                                          ),
                                        ],
                                      ),

                                      SizedBox(height: 4.h),

                                    ],
                                  ),

                                  Spacer(),

                                  /// TIME
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        "Today",
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff266FFF),
                                        ),
                                      ),
                                      Text(
                                        cubit.formatTime(
                                          driver?.updatedAt
                                                .toString()),
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          fontWeight: FontWeight.w500,
                                          color: Color(0xff266FFF),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: 18.h),

                              /// LOCATION CARD
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12.r),
                                  color: Colors.grey.shade50,
                                ),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/from_to_image.svg",
                                    ),
                                    SizedBox(width: 10.w),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Text("Pick-up"),
                                        Text(cubit.currentLocationCon.text),
                                        SizedBox(height: 10.h),
                                        Text("Destination"),
                                        Text(cubit.destinationCon.text),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              SizedBox(height: 18.h),

                              /// DISTANCE + TIME
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/noun_distance.svg",
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        "Distance ${cubit.normalRide?.distanceKm
                                            ?.toStringAsFixed(0)}Km",
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        "assets/images/noun_time.svg",
                                      ),
                                      SizedBox(width: 5.w),
                                      Text(
                                        "Time ${cubit.getEstimatedTime(
                                            cubit.normalRide?.distanceKm)
                                            .toStringAsFixed(0)} Mins",
                                      ),
                                    ],
                                  ),
                                ],
                              ),

                              SizedBox(height: 18.h),
                              Divider(),

                              SizedBox(height: 12.h),

                              /// PAYMENT
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text("Total fare: "),
                                      Text(
                                        "${cubit.normalRide?.trip.price} EGP",
                                        style: TextStyle(
                                          color: Color(0xff266FFF),
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                          cubit.normalRide?.trip.paymentInfo.method == "cash"
                                          ? SvgPicture.asset(
                                        "assets/images/noun-cash.svg",
                                      )
                                          : Image.asset(
                                        "assets/images/credit_card.png",
                                        width: 24.w,
                                      ),
                                      SizedBox(width: 6.w),
                                      Text(cubit.normalRide
                                          ?.trip
                                          .paymentInfo
                                          .method == "cash"
                                          ? "Cash"
                                          : "Credit card"),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(height: 18.h),

                              /// RATING BUTTON
                              CustomElevatedBtn(
                                btnSize: Size(double.infinity, 50.h),
                                btnName: "Rating",
                                onPressed: () {
                                  Navigator.pushNamed(context, Routes.rating);
                                },
                              ),
                            ],
                          ),
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
