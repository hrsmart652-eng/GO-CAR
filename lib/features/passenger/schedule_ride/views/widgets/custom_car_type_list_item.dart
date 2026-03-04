import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../cubit/scheduled_ride_cubit.dart';

class CustomCarTypeListItem extends StatelessWidget {
  const CustomCarTypeListItem({
    super.key,
    required this.scheduledRideCubit,
  });

  final ScheduledRideCubit scheduledRideCubit;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
       top:10,
        bottom: 10,
      ),
      child: SizedBox(
        width: 370.w,
        height:90.h,
        child: Row(
          children: [
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: scheduledRideCubit.carsAndNames.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: Column(
                      mainAxisAlignment:MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            scheduledRideCubit.changeCarTypeIndex(index: index);
                          },
                          child: Container(
                            width: 63.w,
                            height: 63.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                width: 1.w,
                                color:
                                scheduledRideCubit
                                    .currentCarIndex ==
                                    index
                                    ? const Color(0xff344054)
                                    : const Color(0xffE8EEFB),
                              ),
                              color: const Color(0xffE8EEFB),
                            ),
                            child: Center(
                              child: SvgPicture.asset(
                                scheduledRideCubit
                                    .carsAndNames[index]["image"],
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 7.h),
                        Text(
                          scheduledRideCubit.carsAndNames[index]["type"],
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
}