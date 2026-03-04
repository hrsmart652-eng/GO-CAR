import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/features/passenger/normal_ride/model/driver_info_model.dart';

import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/services/api/end_points.dart';
import '../../../../core/widgets/show_snackbar.dart';
import '../../normal_ride/cubit/normal_ride_cubit.dart';
import '../../normal_ride/cubit/normal_ride_state.dart';
import '../../normal_ride/model/ride_accepted_model.dart';
import '../../schedule_ride/cubit/scheduled_ride_cubit.dart';

class CustomDriverInfoSheet extends StatefulWidget {
   CustomDriverInfoSheet({
    super.key,
     this.tripStatusModelModel,
    this.driverInfoModel
  });
   DriverInfoModel? driverInfoModel;
   TripStatusModel? tripStatusModelModel;

  @override
  State<CustomDriverInfoSheet> createState() => _CustomDriverInfoSheetState();
}

class _CustomDriverInfoSheetState extends State<CustomDriverInfoSheet> {
  bool isExpanded = false;
  bool isNormalRide = true;


  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NormalRideCubit>().startCheckingTripStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NormalRideCubit, RequestRideState>(
      listener: (BuildContext context, state) {
        if (state is AllTripsFailureState) {
          showSnackBar(context, message: state.errorMsg);
        }
      },
      builder: (context, state) {
        if (state is AllTripsSuccessState) {
          final cubit = NormalRideCubit.get(context);
          return NotificationListener<DraggableScrollableNotification>(
            onNotification: (notification) {
              final isScrolled = notification.extent > 0.31;
              if (isScrolled != isExpanded) {
                setState(() {
                  isExpanded = isScrolled;
                });
              }
              return true;
            },
            child: DraggableScrollableSheet(
              initialChildSize: 0.38,
              minChildSize: 0.37,
              maxChildSize: 0.6,
              builder: (context, scrollController) {
                return SingleChildScrollView(
                      controller: scrollController,
                      child: SizedBox(
                        height: 430.h,
                        child: Stack(
                          children: [
                            Container(height:50.h),

                            // ================= White Card =================
                            Positioned(
                              top: 70,
                              left: 0,
                              right: 0,
                              child: Container(
                                height: 390.h,
                                padding: EdgeInsets.symmetric(horizontal: 16.w),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20),
                                  ),
                                ),

                                child: Column(
                                  children: [

                                    /// PRICE + CALL
                                    Padding(
                                      padding: const EdgeInsets.symmetric(vertical:16),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${state.trip.price?.toStringAsFixed(0)} EGP",
                                            style: TextStyle(
                                              fontSize: 18.sp,
                                              fontWeight: FontWeight.w700,
                                              color: const Color(0xff266FFF),
                                            ),
                                          ),
                                          const Spacer(),
                                          Image.asset(
                                            "assets/images/call.png",
                                            width: 48.w,
                                          )
                                        ],
                                      ),
                                    ),


                                    /// DRIVER NAME
                                    Text(
                                      state.driverInfo.fullName,
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),

                                    SizedBox(height: 6.h),

                                    /// RATING
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(Icons.star,
                                            color: Color(0xffFFC107), size: 16),

                                        SizedBox(width: 4.w),

                                        Text(
                                          "${cubit.driverReviews?.averageRating ?? "4.4"}",
                                          style: TextStyle(fontSize: 14.sp),
                                        ),

                                        Text(
                                          " ${cubit.driverTrips.length} rides",
                                          style: TextStyle(
                                            fontSize: 10.sp,
                                            color: const Color(0xff667085),
                                          ),
                                        ),
                                      ],
                                    ),

                                    SizedBox(height: 5.h),

                                    /// CAR SECTION
                                    Row(
                                      children: [

                                        /// CAR IMAGE
                                        SvgPicture.asset(
                                          "assets/images/car.svg",
                                          width: 125.w,
                                        ),

                                        const Spacer(),

                                        /// CAR INFO
                                        Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                          children: [

                                            Text(
                                              cubit.normalRide?.trip.carType ??
                                                  "VIP",
                                              style: TextStyle(
                                                fontSize: 14.sp,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),

                                            SizedBox(height: 10.h),

                                            Row(
                                              children: [
                                                SvgPicture.asset(
                                                    "assets/images/noun_distance.svg"),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  "${cubit.normalRide?.distanceKm?.toStringAsFixed(0)} Km",
                                                ),
                                                SizedBox(width: 10.w),
                                                SvgPicture.asset(
                                                    "assets/images/noun_time.svg"),
                                                SizedBox(width: 4.w),
                                                Text(
                                                  "${cubit.getEstimatedTime(
                                                    cubit.normalRide?.distanceKm,
                                                  ).toStringAsFixed(0)} Mins",
                                                ),
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),

                                    SizedBox(height: 20.h),

                                    /// PAYMENT
                                    Container(
                                      height: 40.h,
                                      padding:
                                      EdgeInsets.symmetric(horizontal: 10.w),
                                      decoration: BoxDecoration(
                                        color: const Color(0xffF9FAFB),
                                        borderRadius:
                                        BorderRadius.circular(8.r),
                                      ),
                                      child: Row(
                                        children: [
                                          const Icon(Icons.credit_card,
                                              color: Color(0xff266FFF)),
                                          SizedBox(width: 8.w),
                                          Text(
                                            state.trip.paymentInfo?.method ??
                                                "Credit card",
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: 10.h),
                                    Divider(),
                                    /// END RIDE
                                    state.trip.status
                                        ?.toLowerCase() ==
                                        "completed"
                                        ? const CheckStatusEndedTripBtn()
                                        :  Padding(
                                      padding: EdgeInsets.symmetric(horizontal:1.w),
                                      child:
                                      CircularProgressIndicator(),
                                    ),

                                    SizedBox(height: 10.h),

                                    /// CANCEL
                                    Container(
                                     padding:EdgeInsets.symmetric(horizontal:6.w),
                                      child: GestureDetector(
                                        onTap: () async {

                                          final tripId =
                                          CacheHelper()
                                              .getData(
                                            key: ApiKeys.tripId,
                                          )
                                              .toString();

                                          await cubit.cancelRide(tripId);

                                          cubit.resetTrip();

                                          Navigator.pushNamed(
                                            context,
                                            Routes.home,
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            SvgPicture.asset(
                                                "assets/images/cancel_ride.svg"),
                                            SizedBox(width: 8.w),
                                            Text(
                                              "Cancel ride",
                                              style: TextStyle(
                                                color: Color(0xffF04438),
                                                fontSize: 14.sp,
                                                fontWeight:
                                                FontWeight.w600,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // ================= Driver Avatar =================
                            Positioned(
                              top: 17,
                              left: 0,
                              right: 0,
                              child: CircleAvatar(
                                radius: 45.5.r,
                                backgroundColor: Colors.white,
                                child: CircleAvatar(
                                  radius: 41.5.r,
                                  backgroundImage:
                                  state.driverInfo.image.isNotEmpty &&
                                      state.driverInfo.image.startsWith("http")
                                      ? NetworkImage(state.driverInfo.image)
                                      : const AssetImage(
                                    "assets/images/driver_image.png",
                                  ) as ImageProvider,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
              },
            ),
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

class CheckStatusEndedTripBtn extends StatelessWidget {
  const CheckStatusEndedTripBtn({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(Routes.rideEnded);
      },
      child: Container(
        width: double.infinity,
        height: 36.h,
        margin: EdgeInsets.symmetric(horizontal:5.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.r),
          color: const Color(0xffFCFCFD),
        ),
        child: Row(
          children: [
            Icon(
              Icons.check_circle,
              color: const Color(0xff027A48),
              size: 20.w,
            ),
            SizedBox(width: 10.w),
            Text(
              "End Ride",
              style: TextStyle(
                color: const Color(0xff027A48),
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
