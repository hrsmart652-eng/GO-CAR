import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/config/app_config.dart';
import 'package:go_car/config/environment.dart';
import 'package:go_car/core/services/api/dio_consumer.dart';
import 'package:go_car/features/common/auth/login/cubit/driver_login_cubit.dart';
import 'package:go_car/features/common/auth/login/cubit/driver_login_state.dart';
import 'package:go_car/features/common/auth/login/repository/driver_login_repository.dart';
import 'package:go_car/features/common/auth/login/views/login_screen.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_state.dart';
import 'package:go_car/features/passenger/profile/repository/client_profile_repository.dart';

import '../../../driver/profile/cubit/driver_profile_cubit.dart';
import '../cubit/client_profile_cubit.dart';

Future<dynamic> logoutDialog(BuildContext context) {
  final flavor = AppConfig.instance.environment;

  return showDialog(
    context: context,
    builder:
        (context) => AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
           content:
           //  create:(context)=>ClientProfileCubit(profileRepository: ClientProfileRepository(Api:DioConsumer(dio:Dio()))),
              BlocBuilder<ClientProfileCubit,ClientProfileState>(
              builder: (context,state) {
                final clientCubit =ClientProfileCubit.of(context);
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset('assets/images/sad_logout.png'),
                    SizedBox(height: 16.h),
                    Text(
                      'Are you sure!',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Color(0xff0D3244),
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Are you sure you want to logout?',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Color(0xff475467),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: const Color(0xffF9FAFB),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                                side: BorderSide(
                                  color: Color(0xffD0D5DD),
                                  width: 1.w,
                                ),
                              ),
                            ),
                            onPressed: () => Navigator.of(context).pop(false),
                            child: Text(
                              'No',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: const Color(0xff183E91),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xffD92D20),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            onPressed: () async {
                              try {
                                if (flavor == Environment.passenger &&clientCubit.clientModel?.role=="client") {
                                  await context.read<ClientProfileCubit>().clientLogout(context);
                                  debugPrint("Client Logout Succefuly");
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(isDriver:false,),
                                    ),
                                        (route) => false,
                                  );
                                } else{
                                  await context.read<DriverProfileCubit>().DriverLogout(
                                    context,
                                  );
                                  debugPrint("Driver Logout Succefuly");
                                  Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => LoginScreen(isDriver:true,),
                                    ),
                                        (route) => false,
                                  );
                                }
                              } catch (e) {
                                debugPrint('Error during logout: $e');
                                //  رسالة للمستخدم
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Error during logout: ${e.toString()}',
                                    ),
                                  ),
                                );
                              }
                            },
                            child: Text(
                              'Yes',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              }
                       ),
  //         ),
        ),
  );
}
