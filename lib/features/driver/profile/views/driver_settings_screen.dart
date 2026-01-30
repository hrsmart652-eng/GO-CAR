import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_cubit.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_state.dart';
import 'package:go_car/features/passenger/profile/views/about_dialog.dart';
import 'package:go_car/features/passenger/profile/views/change_password_dialog.dart';
import 'package:go_car/features/passenger/profile/views/delete_account_dialog.dart';
import 'package:go_car/features/passenger/profile/views/language_dailog.dart';

import '../../../../core/widgets/custom_app_bar.dart';

class DriverSettingsScreen extends StatefulWidget {
  const DriverSettingsScreen({super.key});

  @override
  State<DriverSettingsScreen> createState() => _DriverSettingsScreenState();
}

class _DriverSettingsScreenState extends State<DriverSettingsScreen> {
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
          appBar: customAppBar(title: 'Settings'),

          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                //------------------ change Password ------------------
                BuildSettingsItem(
                  settingsName: 'Change password',
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return ChangePasswordDialog();
                      },
                    );
                  },
                ),

                //------------------ Language ------------------
                BuildSettingsItem(
                  settingsName: 'Language',
                  onTap: () {
                    languageDialog(context);
                  },
                ),

                //--------------------  Accept Payment ------------------
                BuildSettingsItem(settingsName: 'Accept Payment', onTap: () {}),

                //--------------------  About ------------------
                BuildSettingsItem(
                  settingsName: 'About',
                  onTap: () {
                    buildAboutDialog(context);
                  },
                ),

                //-------------------- Delete Account ------------------
                BuildSettingsItem(
                  settingsName: 'Delete Account',
                  settingsColorName: Color(0xffF04438),
                  onTap: () {
                    buildDeleteAccountDialog(context);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

class BuildSettingsItem extends StatelessWidget {
  const BuildSettingsItem({
    super.key,
    required this.settingsName,

    required this.onTap,
    this.settingsColorName = Colors.black,
  });

  final String settingsName;
  final Color? settingsColorName;
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
          border: Border.all(color: Color(0xffEAECF0), width: 1.w),
          borderRadius: BorderRadiusDirectional.circular(4.r),
        ),
        child: Text(
          settingsName,
          style: TextStyle(
            fontSize: 16.sp,
            fontWeight: FontWeight.w500,
            color: settingsColorName,
          ),
        ),
      ),
    );
  }
}
