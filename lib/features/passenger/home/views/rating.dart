// rating_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';

import '../../../../config/environment.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/confirmation_delete_dialog.dart';
import '../../../../core/widgets/custom_elevated_btn.dart';
import '../widgets/custom_thumb_shape.dart';
import '../widgets/custom_value_Indicator_shape.dart';
import '../widgets/gradient_slider_track_shape.dart';

class Rating extends StatefulWidget {
  const Rating({
    super.key,
    required this.cubit,
    required this.isSuccess,
    required this.isFailure,
    required this.successMessage,
    required this.errorMessage,
  });

  final RatingCubitInterface cubit;
  final bool isSuccess;
  final bool isFailure;
  final String? successMessage;
  final String? errorMessage;

  @override
  State<Rating> createState() => _RatingScreenState();
}

class _RatingScreenState extends State<Rating> {
  @override
  void didUpdateWidget(Rating oldWidget) {
    super.didUpdateWidget(oldWidget);

    // Handle navigation on success
    if (widget.isSuccess && !oldWidget.isSuccess) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        widget.cubit.resetTrip();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.successMessage ?? "Rated Successfully")),
        );
        Navigator.pushNamedAndRemoveUntil(
          context,
          Routes.home,
              (route) => false,
        );
      });
    }

    // Handle error
    if (widget.isFailure && !oldWidget.isFailure) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(widget.errorMessage ?? "Something went wrong")),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final cubit = widget.cubit;

    return Scaffold(
      backgroundColor: Color(cubit.colors[cubit.sliderValue.toInt()]),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            children: [
              const SizedBox(height: 20),
              const Text(
                "Rate the ride",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              Text(cubit.ratingDescriptions[cubit.sliderValue.toInt()]),
              SizedBox(height: 30.h),
              Image.asset(
                cubit.emojiAssets[cubit.sliderValue.toInt()],
                height: 260.h,
              ),
              SizedBox(height: 30.h),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 8.h,
                  trackShape: GradientSliderTrackShape(),
                  thumbShape: CustomThumbShape(),
                  valueIndicatorShape: CustomValueIndicatorShape(),
                ),
                child: Slider(
                  value: cubit.sliderValue,
                  min: 0,
                  max: 4,
                  divisions: 4,
                  label: cubit.ratingTexts[cubit.sliderValue.toInt()],
                  onChanged: (value) {
                    setState(() {
                      cubit.sliderValue = value;
                    });
                  },
                ),
              ),
              const Spacer(),
              CustomElevatedBtn(
                btnName: widget.isSuccess ? "Sending..." : "Submit",
                onPressed: () {
                  cubit.sendTripReview(
                    rating: cubit.sliderValue.toInt() + 1,
                    review: cubit.ratingDescriptions[cubit.sliderValue.toInt()],
                  );
                },
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  onPressed: () {
                    confirmationDeleteDialog(
                      context,
                      title: "Block driver, Are you Sure!",
                      text:
                      "you may don't see this driver again\nbetween your recommendation",
                      onPressed: () {
                        Navigator.pushNamed(context,Routes.home);
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
  }
}