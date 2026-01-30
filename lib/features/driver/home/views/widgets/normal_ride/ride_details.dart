import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/home/cubit/new_trip_cubit.dart';
import 'package:go_car/features/driver/home/cubit/new_trip_state.dart';
import 'package:go_car/features/driver/home/views/widgets/client.dart';

class RideDetailsScrolled extends StatefulWidget {
  final ScrollController? scrollController;
  const RideDetailsScrolled({super.key, this.scrollController});

  @override
  State<RideDetailsScrolled> createState() => _RideDetailsScrolledState();
}

class _RideDetailsScrolledState extends State<RideDetailsScrolled> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewTripCubit, NewTripState>(
      listener: (context, state) {
        if (state is NewTripFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        if (state is NewTripLoading) {
          return Center(child: CircularProgressIndicator());
        }

        if (state is NewTripSuccess) {
          if (state.trips.isEmpty) {
            return Center(child: Text("No trips available"));
          }

          final int cachedIndex =
              CacheHelper().getData(key: ApiKeys.index) ?? 0;
          final int safeIndex =
              cachedIndex < state.trips.length ? cachedIndex : 0;
          final trip = state.trips[safeIndex];
          // Optionally update cache to keep it valid
          if (state.trips.length == 1) {
            CacheHelper().saveData(key: ApiKeys.index, value: 0);
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10.h),
              Container(
                width: 343.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    SvgPicture.asset("assets/images/from_to_image.svg"),
                    SizedBox(width: 8.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        Text(
                          "Pick up",
                          style: TextStyle(
                            color: const Color(0xff475467),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "Alexandria, Egypt", // Replace with trip.pickup if available
                          style: TextStyle(
                            color: const Color(0xff121212),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          "Destination",
                          style: TextStyle(
                            color: const Color(0xff475467),
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "Cairo, Egypt", // Replace with trip.destination if available
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
              ),
              SizedBox(height: 20.h),
              Text(
                'Payment method',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        'Total fare: ',
                        style: TextStyle(
                          color: Color(0xff344054),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        "${trip.price} EGP",
                        style: TextStyle(
                          color: Color(0xff027A48),
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset(
                        'assets/images/credit_card.png',
                        width: 25.w,
                        height: 25.h,
                      ),
                      SizedBox(width: 10.w),
                      Text(
                        'Unknown',
                        style: TextStyle(
                          color: Color(0xff266FFF),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              ClientDetails(index: safeIndex),
              SizedBox(height: 25.h),
            ],
          );
        }

        return Center(child: Text("Failed to load trips"));
      },
    );
  }
}
