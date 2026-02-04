import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/services/api/dio_consumer.dart';
import 'package:go_car/features/driver/profile/views/build_horizontal_list.dart' ;
import 'package:go_car/features/driver/profile/views/build_profile_actions.dart' ;
import 'package:go_car/features/passenger/home/widgets/bottom_navigation_bar.dart';
import 'package:go_car/features/passenger/profile/repository/client_profile_repository.dart';

import '../cubit/client_profile_cubit.dart' show ClientProfileCubit;
import '../cubit/client_profile_state.dart';
import 'logout_dialog.dart' show logoutDialog;

class ProfileScreen extends StatefulWidget { const ProfileScreen({super.key}); @override State<ProfileScreen> createState() => _ProfileScreenState(); }

class _ProfileScreenState extends State<ProfileScreen> {


  @override
  void initState() {
    super.initState();
   context.read<ClientProfileCubit>().getClientProfile();

  }
  ImageProvider profileImage(String? image) {
    if (image == null || image.trim().isEmpty) {
      return const AssetImage(
        'assets/images/noun-profile-138926 1.png',
      );
    }
    return NetworkImage(image);
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
              ),
              Positioned(
                left: 20.w,
                right: 20.w,
                bottom: 20.h,
                child: BlocConsumer<ClientProfileCubit, ClientProfileState>(
                  listener:(context, state) {
                    if(state is ClientProfileFailure){
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(state.errMessage)));
                    }
                  },
                  builder: (context, state) {
                    if (state is ClientProfileSuccess) {
                      final model = state.clientModel;
                      final imageUrl =state.clientModel.image;

                      return Column(
                        children: [
                          // Image
                        CircleAvatar(
                        radius: 50.r,
                        backgroundImage: profileImage(imageUrl)
                      ),
                          SizedBox(height: 10.h),

                          // Name
                          Text(
                            state.clientModel.fullName ?? '',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),

                          // phone
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
                    }

                   else if (state is ClientProfileLoading) {
                      return const Center(
                        child: CircularProgressIndicator(color: Colors.white),
                      );
                    }

                    else if (state is ClientProfileFailure) {
                      return Text(
                        state.errMessage,
                        style: const TextStyle(color: Colors.white),
                      );
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
                BuildHorizontalListItem(
                  itemImg: 'assets/images/rate_5249368.png',
                  itemName: 'Points',
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.pointsScreen),
                ),
                BuildHorizontalListItem(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.historyScreen),
                  itemImg: 'assets/images/restore_10302913.png',
                  itemName: 'History',
                ),
                BuildHorizontalListItem(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.reviewsScreen),
                  itemImg: 'assets/images/review_8632737 1.png',
                  itemName: 'Reviews',
                ),
                BuildHorizontalListItem(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.supportScreen),
                  itemImg: 'assets/images/support_3249904.png',
                  itemName: 'Support',
                ),
              ],
            ),
          ),

          BuildProfileAction(
            actionName: 'Edit profile',
            onTap: ()async{

               Navigator.pushNamed(context, Routes.editProfileScreen);


            }
          ),
          BuildProfileAction(
            actionName: 'Settings',
            onTap: () =>
                Navigator.pushNamed(context, Routes.settingsScreen),
          ),
          BuildProfileAction(
            actionName: 'Logout',
            onTap: () => logoutDialog(context),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 3),
    );
  }
}
