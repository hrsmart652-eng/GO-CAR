import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/home/cubit/driver_ride_cubit.dart';
import 'package:go_car/features/driver/home/cubit/driver_ride_state.dart';

class RatingWid extends StatefulWidget {
  const RatingWid({super.key});

  @override
  State<RatingWid> createState() => _RatingWidState();
}

class _RatingWidState extends State<RatingWid> {
  int selectedIndex = -1; // -1 means nothing selected yet

  final List<String> emojis = [
    'assets/images/angry.png',
    'assets/images/sad.png',
    'assets/images/meh.png',
    'assets/images/smile.png',
    'assets/images/loveEye.png',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverRideCubit, DriverRideState>(
      listener: (context, state) {
        if (state is DriverRideFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        } else if (state is DriverRideSuccess) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text('Request success')));
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.all(12),
          height: 250,
          child: Column(
            children: [
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(emojis.length, (index) {
                  final isSelected = index == selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.grey : Colors.transparent,
                          width: 2,
                        ),
                        color:
                            isSelected
                                ? Colors.grey.withOpacity(0.3)
                                : Colors.transparent,
                      ),

                      child: Image.asset(emojis[index], width: 40.w),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20.h),
              Container(
                width: 343.w,
                decoration: BoxDecoration(
                  color: Color(0xff266FFF),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextButton(
                  onPressed: () {
                    if (selectedIndex == -1) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Please select a rating")),
                      );
                      return;
                    }

                    context.read<DriverRideCubit>().reviewRide(
                      CacheHelper().getData(key: ApiKeys.tripCode).toString(),
                      (selectedIndex + 1).toString(),
                    );

                    Navigator.pop(context);
                  },
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              SizedBox(
                width: 343.w,
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      color: Color(0xff0D3244),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
