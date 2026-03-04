import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/passenger/normal_ride/model/driver_info_model.dart';
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
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_)async {
     await context.read<ScheduledRideCubit>().getAllTripsByClientId();
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
            await context.read<ScheduledRideCubit>().getAcceptNewTrip();
            Navigator.pushNamed(context,Routes.home);
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
          final cubit = ScheduledRideCubit.get(context);
          final trips =
              state is SchduledAllTripSuccessState ? state.allTrip : [];
          return state is SchduledAllTripSuccessState
              ? ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
                itemCount: trips.length,
                separatorBuilder: (_, __) => SizedBox(height: 5.h),

                itemBuilder: (context, index) {
                  final trip = trips[index];
                  final status = trip.status?.toLowerCase();

                  if (status == "requested") {
                    return SchduleTripTransaction(
                      image: Image.asset("assets/images/review_request.png"),
                      title: '#${state.allTrip[index].tripCode}  request under review',
                      content: 'Please be patient...',
                      onTap: () {
                      //  cubit.getTripStatus();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const UnderReview(),
                          ),
                        );
                      },
                    );
                  }

                  if (status == "accepted") {
                    return SchduleTripTransaction(
                      image: Image.asset("assets/images/accepted.png"),
                      title: '#${state.allTrip[index].tripCode} request has been accepted',
                      content: 'Please be on time...',
                      onTap: () async {
                        final driverId = state.allTrip[index].driverId;
                            // cubit.getAllTripsById(id:driverId??"");
                        CacheHelper().saveData(
                          key: ApiKeys.driverId,
                          value: driverId,
                        );

                        print("driverId : ${driverId}");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => AcceptedRideScreen(),
                          ),
                        );
                      },
                    );
                  }
                  if (state != "accepted" || state != "requested") {
                    return SizedBox(height: 0, width: 0);
                  }
                  return SizedBox(height: 0, width: 0);
                },
              )
              : Center(child: CircularProgressIndicator());
        },
        listener: (context, state) {
          if (state is SchduledAllTripFailureState) {
            Center(child: Text(state.errorMsg));
          }
          if (state is SchduledTripLoadingState) {
            Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
