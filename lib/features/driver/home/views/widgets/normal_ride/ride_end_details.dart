import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/home/cubit/new_trip_cubit.dart';
import 'package:go_car/features/driver/home/cubit/new_trip_state.dart';
import 'package:go_car/features/driver/home/views/widgets/client.dart';
import 'package:go_car/features/driver/home/views/widgets/normal_ride/rating.dart';
import '../../../../../../core/widgets/custom_elevated_btn.dart';

class RideEndDetails extends StatelessWidget {
  const RideEndDetails({super.key});

  void Rating(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => RatingWid(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      child: BlocConsumer<NewTripCubit, NewTripState>(
        listener: (context, state) {
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
              ? SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ClientDetails(
                          index: CacheHelper().getData(key: ApiKeys.index),
                          // name: 'John Doe',
                          // imageUrl: 'https://example.com/image.jpg',
                        ),
                        Column(
                          children: [
                            Text(
                              'Today',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff266FFF),
                              ),
                            ),
                            Text(
                              '9:05 AM',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Color(0xff266FFF),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      width: 343.w,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 4,
                            offset: Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          SizedBox(width: 10.w),
                          SvgPicture.asset("assets/images/from_to_image.svg"),
                          SizedBox(width: 8.w),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 10.h),
                              Text(
                                "Pick up",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: const Color(0xff475467),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Alexandria, Egypt",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: const Color(0xff121212),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 20.h),
                              Text(
                                "Destination",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: const Color(0xff475467),
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Text(
                                "Cairo, Egypt",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  color: const Color(0xff121212),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 10.h),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset("assets/images/noun_distance.svg"),
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
                            SvgPicture.asset("assets/images/noun_time.svg"),
                            SizedBox(width: 4.w),
                            Text(
                              "Time 32Mins",
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
                    SizedBox(height: 20.h),
                    Container(
                      width: 343.w,
                      height: 2.h,
                      color: Color(0xffEAECF0),
                    ),
                    SizedBox(height: 20.h),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
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
                                '${state.trips[CacheHelper().getData(key: ApiKeys.index)].price} EGP',
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
                                'Credit card',
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
                    ),
                    SizedBox(height: 20.h),
                    CustomElevatedBtn(
                      btnName: 'Done',
                      onPressed: () {
                        Navigator.pop(context);
                        Rating(context);
                      },
                    ),
                  ],
                ),
              )
              : Container();
        },
      ),
    );
  }
}
