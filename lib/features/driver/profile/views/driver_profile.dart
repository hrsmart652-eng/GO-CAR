import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_cubit.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_state.dart';
import 'package:go_car/features/passenger/profile/views/profile_screen.dart';
import '../../../passenger/profile/views/logout_dialog.dart';
import '../../home/views/widgets/driver_bottom_navigation_bar.dart';

class DriverProfile extends StatefulWidget {
  const DriverProfile({super.key});

  @override
  State<DriverProfile> createState() => _DriverProfileState();
}

class _DriverProfileState extends State<DriverProfile> {
  int currentIndex = 2;

  @override
  void initState() {
    super.initState();
    context.read<DriverProfileCubit>().getDriverProfile();
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
          body:
              state is DriverProfileLoading
                  ? Center(child: CircularProgressIndicator())
                  : state is DriverProfileSuccess
                  ? Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          Image.asset(
                            'assets/images/profile_bg.png',
                            width: double.infinity,
                            // height: 220.h,
                          ),
                          Positioned(
                            // // top: 10,
                            left: 20.w,
                            right: 20.w,
                            bottom: 20.h,
                            child: Column(
                              children: [
                                //--------------------------- driver image --------------
                                state.driverProfile.image == null
                                    ? CircleAvatar(
                                      radius: 50.r,
                                      child: Icon(Icons.person, size: 100),
                                    )
                                    : CircleAvatar(
                                      radius: 50.r,
                                      backgroundImage: NetworkImage(
                                        state.driverProfile.image,
                                      ),
                                    ),

                                SizedBox(height: 10.h),

                                //----------------------- name -------------------
                                Text(
                                  state.driverProfile.fullName,
                                  style: TextStyle(
                                    fontSize: 18.sp,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xffFFFFFF),
                                  ),
                                ),
                                //----------------------- phone -------------------
                                Text(
                                  state.driverProfile.phoneNumber,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffEAECF0),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      Padding(
                        padding: EdgeInsets.all(16.0.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //-------------------------------- points ---------------
                            BuildHorizontalListItem(
                              itemImg: 'assets/images/rate_5249368.png',
                              itemName: 'Points',
                              onTap:
                                  () => Navigator.pushNamed(
                                    context,
                                    Routes.pointsScreen,
                                  ),
                            ),

                            //---------------------------------History ----------------
                            BuildHorizontalListItem(
                              onTap:
                                  () => Navigator.pushNamed(
                                    context,
                                    Routes.driverHistory,
                                  ),
                              itemImg: 'assets/images/restore_10302913.png',
                              itemName: 'History',
                            ),
                            //-------------------------- reviews ---------------------
                            BuildHorizontalListItem(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.driverReviews,
                                );
                              },
                              itemImg: 'assets/images/review_8632737 1.png',
                              itemName: 'Reviews',
                            ),
                            //-------------------------- Support ---------------------
                            BuildHorizontalListItem(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  Routes.supportScreen,
                                );
                              },
                              itemImg: 'assets/images/support_3249904.png',
                              itemName: 'Support',
                            ),
                          ],
                        ),
                      ),

                      //------------------ Edit profile ------------------
                      BuildProfileAction(
                        actionName: 'Edit profile',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.drivereditProfileScreen,
                          );
                        },
                      ),

                      //------------------ Settings ------------------
                      BuildProfileAction(
                        actionName: 'Settings',
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            Routes.driversettingsScreen,
                          );
                        },
                      ),

                      //------------------ logout ------------------
                      BuildProfileAction(
                        actionName: 'Logout',
                        onTap: () {
                          logoutDialog(context);
                          // context.read<DriverProfileCubit>().DriverLogout(
                          //   context,
                          // );
                        },
                      ),
                    ],
                  )
                  : Container(child: Text('no Data')),
          bottomNavigationBar: DriverNavigationBarWidget(currentIndex: 2),
        );
      },
    );
  }
}
