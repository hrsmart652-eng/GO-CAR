import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/widgets/show_snackbar.dart';
import 'package:go_car/features/passenger/profile/widgets/custom_profile_text.dart';
import 'package:go_car/features/passenger/schedule_ride/views/under_review.dart';
import 'package:go_car/features/passenger/schedule_ride/views/widgets/schdule_trip_transaction.dart';
import 'package:go_car/features/passenger/schedule_ride/views/widgets/schedule_ride_view.dart';

import '../../home/widgets/bottom_navigation_bar.dart';
import '../cubit/scheduled_ride_cubit.dart';
import '../cubit/scheduled_ride_state.dart';
import 'accepted_ride_screen.dart';

class PassengerScheduleRide extends StatefulWidget {
  PassengerScheduleRide({super.key});

  @override
  State<PassengerScheduleRide> createState() => _PassengerScheduleRideState();
}

class _PassengerScheduleRideState extends State<PassengerScheduleRide> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final cubit = ScheduledRideCubit.get(context);
      cubit.getRequestNewTrip().then((value) {
        if (value?.status?.toLowerCase() == "requested"&&cubit.isSchdule==true) {
          cubit.startListeningTripAccept();
        } else {
          cubit.stopListeningTripAccept();
        }
      });
    });
  }

  bool isSeeMore = false;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ScheduledRideCubit, ScheduledRideState>(
      listener: (context, state) {
        if (state is ScheduledRideFailure) {
          showSnackBar(context, message: "${state.errMessage}");
        }
      },
      builder: (context, state) {
        final schduleCubit = ScheduledRideCubit.get(context);
        final trip = schduleCubit.foundNewTrip;
        final status = trip?.status?.toLowerCase();
        final isAccepted =
            state is SchduledTripSuccessState &&
            state.tripAccepted.status?.toLowerCase() == "accepted";
        // final isRequested =
        //     state is GetNewTripsSuccessState &&
        //     state.newTrip?.status?.toLowerCase() == "requested";
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Column(
                    //     crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          left: 16.0.w,
                          right: 16.0.w,
                          top: 20.0.h,
                          bottom: 8.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomProfileText(
                              text: "Schedule your upcoming ride!",
                              color: const Color(0xff0D3244),
                            ),
                            SizedBox(height: 12.h),
                            // كان 20.h
                            CustomProfileText(
                              text: "Upcoming rides!",
                              color: const Color(0xff0D3244),
                            ),
                            SizedBox(height: 8.h),

                            if (schduleCubit.foundNewTrip !=null&&status == "requested")
                              SchduleTripTransaction(
                                key: const ValueKey("requested"),
                                image: Image.asset(
                                  "assets/images/review_request.png",
                                ),
                                title:
                                    '#${trip?.tripCode} request under review..',
                                content: 'please be patient...',
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => UnderReview(),
                                    ),
                                  );
                                },
                              ),
                            SizedBox(height: 10.h),
                            // if (isAccepted ||
                            //     schduleCubit.tripAcceptModel != null)
                            if (schduleCubit.tripAcceptModel!=null&&schduleCubit.isSeeMore)
                              SchduleTripTransaction(
                                key: const ValueKey("accepted"),
                                image: Image.asset(
                                  "assets/images/accepted.png",
                                ),
                                title:
                                    '#${trip?.tripCode} request has been Accepted.',
                                content: 'please be on time...',
                                onTap: () async {
                                  // CacheHelper().saveData(key: ApiKeys.driverId, value:schduleCubit.tripAcceptModel?.driverId);
                                  print(
                                    "**********************driverId${schduleCubit.tripAcceptModel!.driverId.toString()}",
                                  );
                                  schduleCubit.fetchDriverData();
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => AcceptedRideScreen(),
                                    ),
                                  );
                                },
                              )
                          ],
                        ),
                      ),
                      SizedBox(height: 5.h),
                      if (schduleCubit.tripAcceptModel!=null)
                        Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          // width: double.infinity,
                          child: InkWell(
                            onTap: () {
                              schduleCubit.toggleSeeMoreLess();
                            },
                            child: Text(
                              "${schduleCubit.isSeeMore? "See less" : "See more"}",
                              style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff266FFF),
                                decoration: TextDecoration.underline,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),

                      ScheduleRide(scheduledRideCubit: schduleCubit),
                    ],
                  ),
                ],
              ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 1),
        );
      },
    );
  }
}
