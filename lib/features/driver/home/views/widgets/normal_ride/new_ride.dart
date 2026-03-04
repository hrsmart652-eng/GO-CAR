import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/services/api/dio_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/home/cubit/driver_ride_cubit.dart';
import 'package:go_car/features/driver/home/cubit/new_trip_cubit.dart';
import 'package:go_car/features/driver/home/cubit/new_trip_state.dart';
import 'package:go_car/features/driver/home/repository/new_trip_repository.dart';
import 'package:go_car/features/driver/home/views/widgets/client.dart';

class NewRide extends StatefulWidget {
  const NewRide({super.key});

  @override
  State<NewRide> createState() => _NewRideState();
}

class _NewRideState extends State<NewRide> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              NewTripCubit(NewTripRepository(Api: DioConsumer(dio: Dio())))
                ..getNewTrip(),
      child: BlocConsumer<NewTripCubit, NewTripState>(
        listener: (context, state) {
          // if (state is NewTripSuccess) {
          //   context.read<NewTripCubit>().emit(
          //     NewTripSuccess(trips: [...state.trips]),
          //   );
          // }
          if (state is NewTripFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          return state is NewTripLoading
              ? CircularProgressIndicator()
              : state is NewTripSuccess
              ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: state.trips.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        width: 343.w,
                        height: 210.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          border: Border.all(
                            color: Color.fromARGB(44, 165, 165, 165),
                          ),
                          color: Colors.white,
                        ),
                        child: Column(
                          children: [
                            ClientDetails(index: index),

                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  '00:10 Sec',
                                  style: TextStyle(
                                    color: Color(0xff266FFF),

                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Text(
                                  '${state.trips.elementAt(index).price} SEK',
                                  style: TextStyle(
                                    color: Color(0xff027A48),

                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/images/from_to_image.svg",
                                ),
                                SizedBox(width: 8.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "From",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: const Color(0xff121212),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 35.h),
                                    Text(
                                      "To",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: const Color(0xff121212),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 10.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/noun_distance.svg",
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      "Distance 40Km",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: const Color(0xff121212),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(width: 40.w),
                                Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/images/noun_time.svg",
                                    ),
                                    SizedBox(width: 4.w),
                                    Text(
                                      "Time 32 Mins",
                                      textAlign: TextAlign.start,
                                      style: TextStyle(
                                        color: const Color(0xff121212),
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        width: 343.w,
                        height: 60.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8),
                          ),
                          border: Border.all(
                            color: Color.fromARGB(44, 165, 165, 165),
                          ),
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(
                              child: TextButton(
                                onPressed: () {
                                  context.read<DriverRideCubit>().rejectRide(
                                    state.trips.elementAt(index).id,
                                  );
                                },
                                child: Text(
                                  "Decline",
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                    color: const Color(0xffF04438),
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(width: 4.w),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xff266FFF),
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    context.read<DriverRideCubit>().acceptRide(
                                      state.trips.elementAt(index).id,
                                    );
                                    final tripCode =
                                    CacheHelper().getData(key: ApiKeys.tripCode);
                                    CacheHelper().saveData(
                                      key: ApiKeys.tripId,
                                      value: state.trips.elementAt(index).id,
                                    );
                                    CacheHelper().saveData(
                                      key: ApiKeys.tripCode,
                                      value: state.trips.elementAt(index).id,
                                    );
                                    // CacheHelper().saveData(
                                    //   key: 'index',
                                    //   value: index,
                                    // );

                                    print('trip id came right ${tripCode ?? "No tripCode"}');
                                    Navigator.pushNamed(context, Routes.ride);
                                  },
                                  child: Text(
                                    "Accept",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: const Color(0xff266FFF),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  );
                },
              )
              : state is NewTripFailure
              ? Center(child: Text('no trips available'))
              : Center(child: Text('unknown error'));
        },
      ),
    );
  }
}
