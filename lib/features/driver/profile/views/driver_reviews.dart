import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/driver/profile/cubit/driver_reviews_cubit.dart';
import 'package:go_car/features/driver/profile/cubit/driver_reviews_state.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class DriverReviews extends StatefulWidget {
  const DriverReviews({super.key});

  @override
  State<DriverReviews> createState() => _DriverReviewsState();
}

class _DriverReviewsState extends State<DriverReviews> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DriverReviewsCubit>(context).getDriverReviews();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverReviewsCubit, DriverReviewsState>(
      listener:
          (context, state) => {
            if (state is DriverReviewsFailure)
              {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errMessage))),
              },
          },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xffFCFCFD),

          appBar: customAppBar(title: 'Reviews'),

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),

            child: Column(
              children: [
                SizedBox(height: 50.h),
                //--------------------------- rating ---------------
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    //----------------------- rate avg ------------
                    state is DriverReviewsSuccess
                        ? Text(
                          state.driverReviews.averageRating,
                          style: TextStyle(
                            fontSize: 64.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff121212),
                          ),
                        )
                        : state is DriverReviewsLoading
                        ? Center(child: CircularProgressIndicator())
                        : Text(
                          'no reviews',
                          style: TextStyle(
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff121212),
                          ),
                        ),

                    SizedBox(width: 10.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildWhichStarsIsColored(
                          starsNum:
                              state is DriverReviewsSuccess &&
                                      state.driverReviews.averageRating
                                          .contains('.')
                                  ? int.parse(
                                    state.driverReviews.averageRating
                                        .split('.')
                                        .first,
                                  )
                                  : 0,

                          starSize: 30,
                        ),

                        //----------------------- rate num ------------
                        Text(
                          '${state is DriverReviewsSuccess ? state.driverReviews.totalReviews : 0} ratings',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w400,
                            color: Color(0xff121212),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Divider(color: Color(0xff475467), thickness: 1, height: 20.h),

                Expanded(
                  child: ListView.builder(
                    itemCount:
                        state is DriverReviewsSuccess
                            ? state.driverReviews.reviews.length
                            : 0,
                    itemBuilder: (context, index) {
                      state is DriverReviewsSuccess
                          ? state.driverReviews.reviews[index].rating.toString()
                          : '';
                      return buildWhoIsRatingItem(
                        name: 'No Name',
                        starNum:
                            state is DriverReviewsSuccess
                                ? state.driverReviews.reviews[index].rating
                                : 0,
                        date:
                            state is DriverReviewsSuccess
                                ? state.driverReviews.reviews[index].date
                                    .toString()
                                : 'No Date',
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildWhoIsRatingItem({
    required int starNum,
    required String name,
    required String date,
  }) {
    return Container(
      padding: EdgeInsets.only(top: 12.h),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xffEAECF0), width: 1.w),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 48.w,
            height: 48.h,
            child: CircleAvatar(
              radius: 50.r,
              backgroundImage: AssetImage('assets/images/Ellipse 14.png'),
            ),
          ),
          SizedBox(width: 10.h),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: Color(0xff121212),
                ),
              ),
              //----------------------- stars num ------------
              buildWhichStarsIsColored(starsNum: starNum, starSize: 20),
            ],
          ),
          Spacer(flex: 1),
          Text(
            date,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w400,
              color: Color(0xff344054),
            ),
          ),
        ],
      ),
    );
  }

  SizedBox buildWhichStarsIsColored({
    required int starSize,
    required int starsNum, // rating (e.g. 3 out of 5)
  }) {
    return SizedBox(
      height: 30.h,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(5, (index) {
          if (index < starsNum) {
            return Icon(
              Icons.star,
              size: starSize.w,
              color: Color(0xffF0C24D),
            ); // filled
          } else {
            return Icon(
              Icons.star_border,
              size: starSize.w,
              color: Color(0xffD0D5DD),
            ); // empty
          }
        }),
      ),
    );
  }
}
