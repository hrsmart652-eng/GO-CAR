import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_cubit.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_state.dart';
import 'package:go_car/features/passenger/profile/views/logout_dialog.dart';

import '../../home/widgets/bottom_navigation_bar.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // late StreamSubscription<ClientProfileState> _profileStateSubscription;

  // @override
  // void dispose() {
  //   _profileStateSubscription.cancel();
  //   super.dispose();
  // }

  @override
  void initState() {
    super.initState();
    context.read<ClientProfileCubit>().getClientProfile();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: const Color(0xffFCFCFD),
      body: Column(
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
                child: BlocBuilder<ClientProfileCubit, ClientProfileState>(
                  builder: (context, state) {
                    if (state is ClientProfileSuccess) {
                      return Column(
                        children: [
                          //--------------------------- driver image --------------

                          state.clientModel.image == null
                              ? CircleAvatar(
                            radius: 50.r,
                            child: Icon(Icons.person, size: 100),
                          )
                              : CircleAvatar(
                            radius: 50.r,
                            backgroundImage: NetworkImage(
                              state.clientModel.image,
                            ),
                          ),
                          SizedBox(height: 10.h),

                          //----------------------- name -------------------
                          Text(
                            state.clientModel.fullName ?? '',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: const Color(0xffFFFFFF),
                            ),
                          ),
                          //----------------------- phone -------------------
                          Text(
                            state.clientModel.phoneNumber ?? '',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xffEAECF0),
                            ),
                          ),
                        ],
                      );
                    } else if (state is ClientProfileLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    } else if (state is ClientProfileFailure) {
                      return Center(child: Text(state.errMessage));
                    }
                    return const SizedBox();
                  },
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
                      () => Navigator.pushNamed(context, Routes.pointsScreen),
                ),

                //---------------------------------History ----------------
                BuildHorizontalListItem(
                  onTap:
                      () => Navigator.pushNamed(context, Routes.historyScreen),
                  itemImg: 'assets/images/restore_10302913.png',
                  itemName: 'History',
                ),
                //-------------------------- reviews ---------------------
                BuildHorizontalListItem(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.reviewsScreen);
                  },
                  itemImg: 'assets/images/review_8632737 1.png',
                  itemName: 'Reviews',
                ),
                //-------------------------- Support ---------------------
                BuildHorizontalListItem(
                  onTap: () {
                    Navigator.pushNamed(context, Routes.supportScreen);
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
              Navigator.pushNamed(context, Routes.editProfileScreen);
            },
          ),

          //------------------ Settings ------------------
          BuildProfileAction(
            actionName: 'Settings',
            onTap: () {
              Navigator.pushNamed(context, Routes.settingsScreen);
            },
          ),

          //------------------ logout ------------------
          BuildProfileAction(
            actionName: 'Logout',
            onTap: () {
              logoutDialog(context);
              // logoutDialog(context).then((value) {
              //   if (value == true) {
              //     context.read<ClientProfileCubit>().logout();
              //   }
              //   logOut();
              // });
            },
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 3),
    );
  }
}

class BuildHorizontalListItem extends StatelessWidget {
  const BuildHorizontalListItem({
    super.key,
    required this.itemImg,
    required this.itemName,
    required this.onTap,
  });

  final String itemImg;
  final String itemName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 79.67.w,
        height: 80.h,
        padding: EdgeInsets.symmetric(vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffEAECF0), width: 1.w),
          borderRadius: BorderRadiusDirectional.circular(4.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(itemImg, width: 24.w, height: 24.h),
            SizedBox(height: 8.h),
            Text(
              itemName,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BuildProfileAction extends StatelessWidget {
  const BuildProfileAction({
    super.key,
    required this.actionName,
    required this.onTap,
  });

  final String actionName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 343.w,
        margin: EdgeInsets.only(right: 16.w, bottom: 10.h, left: 16.w),
        padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: const Color(0xffEAECF0), width: 1.w),
          borderRadius: BorderRadiusDirectional.circular(4.r),
        ),
        child: Text(
          actionName,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
