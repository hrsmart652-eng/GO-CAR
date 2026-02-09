import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../cubit/normal_ride_cubit.dart';

class PassengerAndLugageNumItems extends StatelessWidget {
  const PassengerAndLugageNumItems({
    super.key,
    required this.normalCubit,
    required this.selectedIndex,
    required this.onSelect,
    this.isPassenger=true
  });

  final NormalRideCubit normalCubit;
  final int selectedIndex;
  final Function(int) onSelect;
  final bool isPassenger;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(6, (index) {
        int value =isPassenger? index+1:index;

        return InkWell(
          onTap: () => onSelect(isPassenger?value+1:value),
          child: Container(
            width: 51.w,
            height: 40.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8.r),
              color: selectedIndex == value
                  ? const Color(0xff266FFF)
                  : Colors.white,
            ),
            child: Center(
              child: Text(
                '$value',
                style: TextStyle(
                  color: selectedIndex == value
                      ? Colors.white
                      : const Color(0xff04034C),
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        );
      }),
    );
  }
}
