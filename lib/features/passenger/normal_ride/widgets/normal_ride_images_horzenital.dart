import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../cubit/normal_ride_cubit.dart';

Widget NormalRidetImagesHorizetal({required NormalRideCubit normalCubit}) {
  return Padding(
    padding: const EdgeInsets.only(left: 10, right: 10, top: 20, bottom: 10),
    child: SizedBox(
      width: 375.w,
      height: 91.h,
      child: Row(
        children: [
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: normalCubit.carsAndNames.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 25.0),
                  child: Column(
                    children: [
                      InkWell(
                        onTap: () {
                          normalCubit.changeCarTypeIndex(index: index);
                        },
                        child: Container(
                          width: 63.w,
                          height: 63.h,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.r),
                            border: Border.all(
                              width: 1.w,
                              color:
                                  normalCubit.currentCarIndex == index
                                      ? const Color(0xff344054)
                                      : const Color(0xffE8EEFB),
                            ),
                            color: const Color(0xffE8EEFB),
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              normalCubit.carsAndNames[index]["image"],

                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 7.h),
                      Text(
                        normalCubit.carsAndNames[index]["type"],
                        style: TextStyle(
                          color: const Color(0xff0D3244),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ),
  );
}
