import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_cubit.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_state.dart';

class DriverHistory extends StatefulWidget {
  const DriverHistory({super.key});

  @override
  State<DriverHistory> createState() => _DriverHistoryState();
}

class _DriverHistoryState extends State<DriverHistory> {
  @override
  void initState() {
    super.initState();

    context.read<DriverProfileCubit>().getDriverTrips();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverProfileCubit, DriverProfileState>(
      listener:
          (context, state) => {
            if (state is DriverProfileFailure)
              {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errMessage))),
              },
          },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xffFCFCFD),

          appBar: AppBar(
            title: Text('History'),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: Colors.black),
              onPressed:
                  () => Navigator.of(
                    context,
                  ).pop(context.read<DriverProfileCubit>().getDriverProfile()),
            ),
          ),

          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 30.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.0.w),
                  child: Column(
                    children: [
                      state is DriverProfileSuccess
                          ? state.driverProfile.trips.isNotEmpty
                              ? ListView.builder(
                                shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemCount: state.driverProfile.trips.length,
                                itemBuilder: (context, index) {
                                  return buildHistoryItem(
                                    carLogo: 'assets/images/travel_car.svg',
                                    time: state.driverProfile.trips[index].time,
                                    amount:
                                        state.driverProfile.trips[index].price,
                                    travelStatus:
                                        state.driverProfile.trips[index].status,
                                    btnName:
                                        state
                                            .driverProfile
                                            .trips[index]
                                            .paymentStatus,
                                  );
                                },
                              )
                              : Center(child: Text('No trips found'))
                          : state is DriverProfileLoading
                          ? Center(child: CircularProgressIndicator())
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Padding buildHistoryItem({
  required String carLogo,
  required String travelStatus,
  required String time,
  required String amount,
  required String btnName,
}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 16.h),
    child: Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 10.r,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          SizedBox(
            width: 50.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //-----------------------------  logo --------------------
                Container(
                  width: 32.w,
                  height: 32.h,
                  decoration: BoxDecoration(
                    color: Color(0xffE8EEFB),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: SvgPicture.asset(carLogo, width: 20.w, height: 20.h),
                ),
                Text(
                  travelStatus,
                  style: TextStyle(
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 8.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //---------------------- time ----------------
              Text(
                time,
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff344054),
                ),
              ),
              SizedBox(height: 5.h),

              Row(
                children: [
                  //------------------ circles and desaed lines -----------------
                  Column(
                    children: [
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: Color(0xff5F00FB),
                          shape: BoxShape.circle,
                        ),
                      ),

                      SizedBox(
                        height: 20.h, // الطول الإجمالي باستخدام
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(
                            // حساب عدد الشرطات بناءً على الطول
                            ((20) / (3 + 2)).floor(),
                            (index) => Container(
                              width:
                                  1.0.w, // عرض الشرطة (يمكن زيادته إذا أردت خطًا أعرض)
                              height: 3.h, // ارتفاع الشرطة
                              color: Color(0xff121212), // لون الشرطة
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 8.w,
                        height: 8.h,
                        decoration: BoxDecoration(
                          color: Color(0xff60BF95),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 8),
                  //------------------------- to - from --------------
                  SizedBox(
                    width: 145.w,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sollefteå ,Sweden',
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10.h),

                        Text(
                          'Försvarsmakten Västernorrland',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            overflow: TextOverflow.ellipsis,

                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.h),

              //---------------------- amount ----------------
              Row(
                children: [
                  Image.asset(
                    'assets/images/pepicons_print_credit_card.png',
                    width: 20.w,
                    height: 20.w,
                  ),
                  Text(
                    amount,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Spacer(flex: 1),
          SizedBox(
            height: 90.h,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 8.h,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffE8FFF2),
                    borderRadius: BorderRadius.circular(4.r),
                  ),

                  child: Text(
                    btnName,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: const Color(0xff027A48),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
