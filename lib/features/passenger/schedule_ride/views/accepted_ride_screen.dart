import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/routing/routes.dart';

import '../../../../core/database/cache/cache_helper.dart';
import '../../../../core/services/api/end_points.dart';
import '../cubit/scheduled_ride_cubit.dart';
import '../cubit/scheduled_ride_state.dart';

class AcceptedRideScreen extends StatefulWidget {
  AcceptedRideScreen({super.key});

  @override
  State<AcceptedRideScreen> createState() => _AcceptedRideScreenState();
}

class _AcceptedRideScreenState extends State<AcceptedRideScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async{
     await context.read<ScheduledRideCubit>().fetchDriverData();
      context.read<ScheduledRideCubit>().startListeningTripAccept();
    });
  }

  Widget build(BuildContext context) {
    return BlocConsumer<ScheduledRideCubit, ScheduledRideState>(
      listener: (context, state) {
        if(state is SchduledTripSuccessState){
         if(state.tripAccepted.status?.toLowerCase()=="completed"){

           Navigator.pushNamed(context, Routes.scheduledRating);
         }
        }
      },
      builder: (context, state) {
        final cubit = ScheduledRideCubit.get(context);
        final trip =
            state is ScheduledRideSuccess
                ? state.scheduledRideResponse
                : cubit.scheduledRideResponse;
        final driver =
            state is DriverInfoLoadedState
                ? state.driverInfo
                : cubit.driverInfoModel;
        final rating =cubit.driverReviewsModel;
        final allTrips=state is SchduledAllTripSuccessState?state.allTrip:cubit.allNewTrips;
        final img = driver?.image ?? "";
        final rideType=CacheHelper().getData(key:ApiKeys.rideType);
        return SafeArea(
          child: Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              centerTitle: true,
              title: Text('Request has been accepted'),
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

                  // ----------------------- 2- Driver info  ------------------
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                    child: Row(
                      children: [
                        // ------------------------ driver image ------------------------
                        Stack(
                          clipBehavior: Clip.none,
                          alignment: Alignment.bottomCenter,
                          children: [
                            CircleAvatar(
                              radius: 34.r,
                              backgroundImage:
                                  img.isNotEmpty
                                      ? NetworkImage(driver?.image ?? "")
                                      : const AssetImage(
                                            "assets/images/driver_image.png",
                                          )
                                          as ImageProvider,
                            ),
                            Positioned(
                              bottom: -10.h,
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 10.w,
                                  vertical: 3.h,
                                ),
                                decoration: BoxDecoration(
                                  color: Color(0xffE8FFF2),
                                  borderRadius: BorderRadius.circular(6.r),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.black.withOpacity(0.1),
                                      blurRadius: 4,
                                      offset: const Offset(0, 2),
                                    ),
                                  ],
                                ),
                                child: Text(
                                  'Accepted',
                                  style: TextStyle(
                                    fontSize: 11.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xff027A48),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 20.w),
                        // ------------------------ driver details ------------------------
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${driver?.fullName}',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff121212),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              children: [
                                Icon(
                                  Icons.star,
                                  color: Colors.yellow,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 4.w),
                                Text(
                                  '${rating?.averageRating.split('.')[0]}.0',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff121212),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  '${allTrips.length} rides',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xff344054),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              '${trip?.trip?.carType}',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff344054),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 24.h),

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
                              cubit.pickupDateTime != null
                                  ? '${cubit.pickupDateTime!.day}/${cubit.pickupDateTime!.month}/${cubit.pickupDateTime!.year}'
                                  : '--/--/----',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff0D3244),
                              ),
                            ),
                            SizedBox(height: 10.h),
                            Text(
                              cubit.pickupDateTime != null
                                  ? '${cubit.pickupDateTime!.hour % 12 == 0 ? 12 : cubit.pickupDateTime!.hour % 12}:${cubit.pickupDateTime!.minute.toString().padLeft(2, '0')} ${cubit.pickupDateTime!.hour >= 12 ? "PM" : "AM"}'
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
                                cubit.pickupDateTime != null
                                    ? '${cubit.pickupDateTime!.day}/${cubit.pickupDateTime!.month}/${cubit.pickupDateTime!.year}'
                                    : '--/--/----',
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xff0D3244),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              Text(
                                cubit.returnTime != null
                                    ? '${cubit.returnTime!.hour % 12 == 0 ? 12 : cubit.returnTime!.hour % 12}:${cubit.returnTime!.minute.toString().padLeft(2, '0')} ${cubit.returnTime!.hour >= 12 ? "PM" : "AM"}'
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
                              height: 30.h, // الطول الإجمالي باستخدام
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: List.generate(
                                  // حساب عدد الشرطات بناءً على الطول
                                  ((20) / (3 + 2)).floor(),
                                  (index) => Container(
                                    width: 1.0.w,
                                    // عرض الشرطة (يمكن زيادته إذا أردت خطًا أعرض)
                                    height: 3.h,
                                    // ارتفاع الشرطة
                                    color: Color(0xff121212), // لون الشرطة
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
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Pick-up',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff475467),
                                  ),
                                ),
                                Text(
                                  '${cubit.currentLocationCon.text}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff121212),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Destination',
                                  style: TextStyle(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff475467),
                                  ),
                                ),

                                Text(
                                  '${cubit.destinationCon.text}',
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xff121212),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
                              'Distance',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff344054),
                              ),
                            ),
                            Text(
                              '${trip?.distanceKm?.toStringAsFixed(0)} Km',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff121212),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.timer,
                              color: Color(0xff344054),
                              size: 16.sp,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Time',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff344054),
                              ),
                            ),
                            Text(
                              '${cubit.getEstimatedTime(trip?.distanceKm).toStringAsFixed(0)} mins',
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
                  // 5. Text
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
                    margin: EdgeInsets.symmetric(horizontal: 8.h),
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: Color(0xFFFCFCFD),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Row(
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
                            // SizedBox(width: 8),
                            Text(
                              '${trip?.price?.toStringAsFixed(0)} EGP',
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w600,
                                color: Color(0xff266FFF),
                              ),
                            ),
                          ],
                        ),
                        Spacer(),
                        Row(
                          children: [
                            //Icon(Icons.payment, color: Color(0XFF183E91)),
                            SvgPicture.asset("assets/svgs/pepicons-print_credit-card.svg",fit:BoxFit.fill,height:20.h,width:20.w,),
                            SizedBox(width: 8),
                            Text(
                              '${cubit.tripAcceptModel?.paymentInfo?.method?.toLowerCase()=="cash"?"Cash":"Credit Card" }',
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
                  // SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
