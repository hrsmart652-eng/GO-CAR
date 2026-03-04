import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/confirmation_delete_dialog.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';
import '../widgets/custom_thumb_shape.dart';
import '../widgets/custom_value_Indicator_shape.dart';
import '../widgets/gradient_slider_track_shape.dart';

class Rating extends StatefulWidget {
  const Rating({super.key});

  @override
  State<Rating> createState() => _RatingState();
}

class _RatingState extends State<Rating> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NormalRideCubit,RequestRideState>(builder:(context,state){
      bool isLoading = state is RequestRideLoading;
      final cubit=NormalRideCubit.get(context);
      return Scaffold(
        backgroundColor:
        Color(cubit.colors[cubit.sliderValue.toInt()]),

        body: SafeArea(
          child: Padding(
            padding:
            EdgeInsets.symmetric(horizontal: 16.w),

            child: Column(
              children: [

                const SizedBox(height: 20),

                const Text(
                  "Rate the ride",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 20.h),

                Text(
                  cubit.ratingDescriptions[
                  cubit.sliderValue.toInt()],
                ),

                SizedBox(height: 30.h),

                Image.asset(
                  cubit.emojiAssets[
                  cubit.sliderValue.toInt()],
                  height: 260.h,
                ),

                SizedBox(height: 30.h),

                SliderTheme(
                  data:
                  SliderTheme.of(context).copyWith(
                    trackHeight: 8.h,
                    trackShape:
                    GradientSliderTrackShape(),
                    thumbShape:
                    CustomThumbShape(),
                    valueIndicatorShape:
                    CustomValueIndicatorShape(),
                  ),

                  child: Slider(
                    value:cubit. sliderValue,
                    min: 0,
                    max: 4,
                    divisions: 4,
                    label:cubit.ratingTexts[
                    cubit.sliderValue.toInt()],

                    onChanged: (value) {
                      setState(() {
                        cubit.sliderValue = value;
                        isLoading=false;
                      });
                    },
                  ),
                ),

                const Spacer(),

                CustomElevatedBtn(
                  btnName:isLoading==false? "Sending...":"Submit",
                  onPressed: () {

                    context.read<NormalRideCubit>().sendTripReview(rating:
                      cubit.sliderValue.toInt() + 1,
                      review:
                      cubit.ratingDescriptions[
                      cubit.sliderValue
                          .toInt()],
                    );
                    isLoading=false;
                  },
                ),

                SizedBox(height: 10.h),
                Container(
                  width:double.infinity,
                  child: ElevatedButton(
                   style: ElevatedButton.styleFrom(
                     shape:RoundedRectangleBorder( borderRadius: BorderRadius.circular(4))
                   ),
                    onPressed:
                         () {
                      confirmationDeleteDialog(
                        context,
                        title:
                        "Block driver, Are you Sure!",
                        text:
                        "you may don't see this driver again\nbetween your recommendation ,and you will not be able to change your mind after this message",
                        onPressed: () {
                          context.read<NormalRideCubit>()
                              .resetTrip();
                          return null;
                        },
                      );
                    },
                    child: Text(
                      "Skip",
                      style: TextStyle(
                        fontFamily: "Cairo",
                        fontWeight: FontWeight.w500,
                        fontSize: 14.sp,
                        color: const Color(0xff0D3244),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
              ],
            ),
          ),
        ),
      );
    },
        listener: (context, state) {

          if (state is ReviewSuccessState) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content:
                Text(state.rateModel.message ?? "Rated Successfully"),
              ),
            );

            Navigator.pushNamedAndRemoveUntil(
              context,
              Routes.home,
                  (route) => false,
            );
          }

          if (state is RequestRideFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.errMessage)),
            );
          }
        },


    );
  }
}