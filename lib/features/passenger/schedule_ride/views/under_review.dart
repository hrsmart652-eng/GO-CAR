import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/passenger/schedule_ride/cubit/scheduled_ride_cubit.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/confirmation_delete_dialog.dart';
import '../cubit/scheduled_ride_state.dart';

class UnderReview extends StatefulWidget {
  const UnderReview({super.key});

  @override
  State<UnderReview> createState() => _UnderReviewState();
}

class _UnderReviewState extends State<UnderReview> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduledRideCubit, ScheduledRideState>(
      listener: (context, state) {},
      builder: (context, state) {
        final schduleCubit = ScheduledRideCubit.get(context);

        final trip =
            state is SchduledTripSuccessState
                ? state.tripAccepted
                : schduleCubit.foundNewTrip;

        // 1. حل مشكلة الكراش (Null Check Operator) في السعر
        double price =
            double.tryParse(
              schduleCubit.scheduledRideResponse?.price?.toStringAsFixed(2) ??
                  '0.0',
            ) ??
            0.0;

        final newTrip =
            state is GetNewTripsSuccessState
                ? state.newTrip
                : schduleCubit.foundNewTrip;

          final rideType = CacheHelper().getData(key: ApiKeys.rideType);
        final isReturnRide =
            schduleCubit.selectedRideType == schduleCubit.returnRideType;
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Icons.arrow_back),
              ),
              centerTitle: true,
              title: Text('Request under review'),
            ),
            body: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //--------------------------- 1. map Image ---------------------------
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0.w),
                    child: Image.asset(
                      'assets/images/rectangle.png',
                      width: double.infinity,
                      height: 200.h,
                      fit: BoxFit.cover,
                    ),
                  ),

                  SizedBox(height: 24),

                  // ----------------------3- Row with date, time, and two icons
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.w),
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: Color(0xffFCFCFD),
                      border: Border.all(color: Color(0xffEAECF0), width: 1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      children: [
                        // --------- Pickup Date & Time ---------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              schduleCubit.pickupDateTime != null
                                  ? '${schduleCubit.pickupDateTime!.day}/${schduleCubit.pickupDateTime!.month}/${schduleCubit.pickupDateTime!.year}'
                                  : '--/--/----',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0D3244),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              schduleCubit.pickupDateTime != null
                                  ? '${schduleCubit.pickupDateTime!.hour % 12 == 0 ? 12 : schduleCubit.pickupDateTime!.hour % 12}:${schduleCubit.pickupDateTime!.minute.toString().padLeft(2, '0')} ${schduleCubit.pickupDateTime!.hour >= 12 ? "PM" : "AM"}'
                                  : "--:--",
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff344054),
                              ),
                            ),
                          ],
                        ),

                        Spacer(),

                        // --------- الأيقونة في المنتصف ---------
                        if (rideType=="return")
                          Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: Color(0xffEAECF0),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: SvgPicture.asset(
                              "assets/svgs/return.svg",
                              fit: BoxFit.fill,
                              height: 32.h,
                              width: 32.w,
                            ),
                          )
                        else
                          SizedBox(),

                        Spacer(),

                        // --------- Return Date & Time أو فراغ ---------
                        if (rideType=="return")
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                schduleCubit.pickupDateTime != null
                                    ? '${schduleCubit.pickupDateTime!.day}/${schduleCubit.pickupDateTime!.month}/${schduleCubit.pickupDateTime!.year}'
                                    : '--/--/----',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff0D3244),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                schduleCubit.returnTime != null
                                    ? '${schduleCubit.returnTime!.hour % 12 == 0 ? 12 : schduleCubit.returnTime!.hour % 12}:${schduleCubit.returnTime!.minute.toString().padLeft(2, '0')} ${schduleCubit.returnTime!.hour >= 12 ? "PM" : "AM"}'
                                    : "--:--",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0xff344054),
                                ),
                              ),
                            ],
                          )
                        else
                          Container(
                            padding: EdgeInsets.all(4.w),
                            decoration: BoxDecoration(
                              color: Color(0xffEAECF0),
                              borderRadius: BorderRadius.circular(4.r),
                            ),
                            child: SvgPicture.asset(
                              "assets/svgs/noun-round-trip-flight-1211382 2.svg",
                              fit: BoxFit.fill,
                              height: 32.h,
                              width: 32.w,
                            ),
                          ), // one-way مفيش return time
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  //------------------------
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 207, 199, 199),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        //------------------ circles and desaed lines -----------------
                        Column(
                          children: [
                            Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: Color(0xff5F00FB),
                                shape: BoxShape.circle,
                              ),
                            ),
                            SizedBox(
                              height: 30.h,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  ((20) / (3 + 2)).floor(),
                                  (index) => Container(
                                    width: 1.0.w,
                                    height: 3.h,
                                    color: Color(0xff121212),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: 8.w,
                              height: 8.h,
                              decoration: BoxDecoration(
                                color: Color(0xff60BF95),
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(width: 16),
                        // 3. تم إضافة Expanded هنا حتى لا يحدث overflow عندما يكون النص طويلا
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'pick-up',
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff475467),
                                    ),
                                  ),
                                  Text(
                                    schduleCubit.currentLocationCon.text ?? '',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff121212),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Destination",
                                    style: TextStyle(
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff475467),
                                    ),
                                  ),
                                  Text(
                                    schduleCubit.destinationCon.text ?? '',
                                    style: TextStyle(
                                      fontSize: 14.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Color(0xff121212),
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

                  //  4. Row with bottom border
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding: EdgeInsets.only(bottom: 12.h),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1,
                        ),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(
                              'assets/images/noun-distance.svg',
                              width: 16.w,
                              height: 16.h,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Distance ',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff344054),
                              ),
                            ),
                            Text(
                              // 4. حماية الـ distanceKm من الطباعة ككلمة null
                              '${schduleCubit.scheduledRideResponse?.distanceKm?.toStringAsFixed(0) ?? '0'} km',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff121212),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Color(0xff344054),
                              size: 16.sp,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Time ',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff344054),
                              ),
                            ),
                            Text(
                              '${schduleCubit.getEstimatedTime(schduleCubit.scheduledRideResponse?.distanceKm ?? 0).toStringAsFixed(0)} mins',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff121212),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  // 5. Payment Method Text
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      'Payment Method',
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Color(0xff121212),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),

                  // 6. Row with background
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16.h),
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFFCFCFD),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Down-Payment: ',
                              style: TextStyle(
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF344054),
                              ),
                            ),
                            Text(
                              '${price.toStringAsFixed(0)} EGP',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff266FFF),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SvgPicture.asset(
                              "assets/svgs/pepicons-print_credit-card.svg",
                              fit: BoxFit.fill,
                              height: 20.h,
                              width: 20.w,
                            ),
                            SizedBox(width: 8),
                            Text(
                              schduleCubit.tripAcceptModel?.paymentInfo?.method
                                          ?.toLowerCase() ==
                                      "cash"
                                  ? "Cash"
                                  : "Credit Card",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF266FFF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),

                  Center(
                    child: TextButton(
                      onPressed: () {
                        confirmationDeleteDialog(
                          title: "Are you Sure!",
                          context,
                          text:
                              'Once you delete this card it will be gone forever.',
                          onPressed: () async {
                            Navigator.pop(context);
                            final tripId = CacheHelper().getData(
                              key: ApiKeys.tripId,
                            );
                            await schduleCubit.cancelRide(tripId: tripId);
                            if (context.mounted) {
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                Routes.schduleHome,
                                (route) => false,
                              );
                            }
                          },
                        );
                      },
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFFF04438),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
