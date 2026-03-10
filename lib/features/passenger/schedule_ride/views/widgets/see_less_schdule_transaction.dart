import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/passenger/schedule_ride/views/widgets/schdule_trip_transaction.dart';

import '../../cubit/scheduled_ride_cubit.dart';
import '../../cubit/scheduled_ride_state.dart';
import '../accepted_ride_screen.dart';
import '../under_review.dart';

class SeeLessSchduleTransaction extends StatefulWidget {
  const SeeLessSchduleTransaction({super.key});

  @override
  State<SeeLessSchduleTransaction> createState() =>
      _SeeLessSchduleTransactionState();
}

class _SeeLessSchduleTransactionState extends State<SeeLessSchduleTransaction> {
  // @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ScheduledRideCubit>().getAllTripsByDriverId();
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            // await context.read<ScheduledRideCubit>().getAcceptNewTrip();
            Navigator.pushNamed(context, Routes.home);
          },
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0xff266FFF)),
        title: const Text(
          "All  Trips",
          style: TextStyle(
            color: Color(0xff0D3244),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      body: BlocConsumer<ScheduledRideCubit, ScheduledRideState>(
        builder: (context, state) {
          if (state is ScheduledRideLoading) {
            return Center(child: CircularProgressIndicator());
          }else if (state is SchduledAllTripSuccessState) {
            final cubit = ScheduledRideCubit.get(context);
            final trips = state.allTrip;
            return ListView.separated(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
              itemCount: trips.length,
              separatorBuilder: (_, __) => SizedBox(height: 5.h),

              itemBuilder: (context, index) {
                final trip = trips[index];
                final status = trip.status?.toLowerCase();

                if (status == "requested") {
                  return SchduleTripTransaction(
                    image: Image.asset("assets/images/review_request.png"),
                    title: '#${trip.tripCode} request under review',
                    content: 'Please be patient...',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const UnderReview()),
                      );
                    },
                  );
                }

                if (status == "accepted") {
                  return SchduleTripTransaction(
                    image: Image.asset("assets/images/accepted.png"),
                    title: '#${trip.tripCode} request has been accepted',
                    content: 'Please be on time...',
                    onTap: () {
                      print("driverId : ${trip.driverId}");
                      CacheHelper().saveData(key:ApiKeys.driverId, value:trip.driverId);
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => AcceptedRideScreen()),
                      );
                    },
                  );
                }

                return const SizedBox.shrink();
              },
            );
          }
          return Center(child: CircularProgressIndicator());
        },
        listener: (context, state) {
        },
      ),
    );
  }
}
