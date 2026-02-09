import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/services/api/dio_consumer.dart';
import 'package:go_car/features/common/auth/login/repository/driver_login_repository.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_cubit.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_state.dart';
import 'package:go_car/features/passenger/profile/views/logout_dialog.dart';

import '../../../../core/services/api/api_consumer.dart';
import '../../../common/auth/login/cubit/driver_login_cubit.dart';
import '../../../driver/profile/views/build_horizontal_list.dart';
import '../../home/widgets/bottom_navigation_bar.dart';
import '../widgets/build_action_profile.dart';
import '../widgets/custom_profile_action_horzenatal_list.dart';
import '../widgets/custom_profile_text.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
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
              child: BlocConsumer<ClientProfileCubit, ClientProfileState>(
                listener: (context, state) {
                  if (state is ClientProfileFailure) {
                    Center(child: Text(state.errMessage));
                  }
                },
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
                            state.clientModel.image ?? "",
                          ),
                        ),
                        SizedBox(height: 10.h),

                        //----------------------- name -------------------
                        CustomProfileText(
                            text: state.clientModel.fullName ?? ""),
                        //----------------------- phone -------------------
                        CustomProfileText(
                            text: state.clientModel.phoneNumber ?? ""),
                      ],
                    );
                  } else if (state is ClientProfileLoading) {
                    return const Center(
                      child: CircularProgressIndicator(color: Colors.white),
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
        CustomProfilectionHorzeinatalList(),

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
        BuildProfileAction(
          actionName: 'Logout',
          onTap: () {
          //  logoutDialog(context);
            Navigator.pushNamed(context,Routes.login);
           // context.read<DriverLoginCubit>().logout(context);
          },
        )
    ]),
    bottomNavigationBar:BottomNavigationBarWidget(currentIndex: 3)
    ,
    );
  }
}







