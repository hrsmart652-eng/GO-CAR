import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_cubit.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_state.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../../../../core/widgets/password_validations.dart';

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({super.key});

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  bool isConfirmPasswordVisible = true;
  bool isNewPasswordVisible = true;

  bool isOldPasswordVisible = false;

  bool isPasswordVisible = true;
  bool hasUppercase = false;
  bool hasNumber = false;
  bool hasMinLength = false;

  final TextEditingController oldPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
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
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.r),
          ),
          title: Text(
            'Change Password',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: Color(0xff0D3244),
            ),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your password must be at least 8 characters long and contain at least one letter and one digit',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w400,
                  color: Color(0xff121212),
                ),
              ),

              SizedBox(height: 20.h),

              //--------------------- old password field ---------------------
              CustomTextField(
                controller: oldPasswordController,
                padding: 3.h,
                fieldTitle: 'Old Password',
                isTextSecure: isOldPasswordVisible,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isOldPasswordVisible = !isOldPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isOldPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(0xff121212),
                  ),
                ),
              ),
              //--------------------- new password field ---------------------
              CustomTextField(
                controller:
                    context.read<DriverProfileCubit>().passwordController,
                padding: 3.h,
                fieldTitle: 'New Password',
                isTextSecure: isNewPasswordVisible,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isNewPasswordVisible = !isNewPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isNewPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: Color(0xff121212),
                  ),
                ),
              ),

              //---------------------  confirm password field --------------
              CustomTextField(
                controller: confirmPasswordController,
                fieldTitle: 'Confirm Password',
                isTextSecure: isConfirmPasswordVisible,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      isConfirmPasswordVisible = !isConfirmPasswordVisible;
                    });
                  },
                  icon: Icon(
                    isConfirmPasswordVisible
                        ? Icons.visibility
                        : Icons.visibility_off,
                    color: const Color(0xFF121212),
                  ),
                ),
              ),
              PasswordValidations(
                hasMinLength: hasMinLength,
                hasUppercase: hasUppercase,
                hasNumber: hasNumber,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                if (context
                            .read<DriverProfileCubit>()
                            .passwordController
                            .text ==
                        confirmPasswordController.text &&
                    oldPasswordController.text ==
                        CacheHelper().getData(key: ApiKeys.password)) {
                  state is DriverProfileSuccess
                      ? context
                          .read<DriverProfileCubit>()
                          .DriverUpdate(
                            context
                                .read<DriverProfileCubit>()
                                .nameController
                                .text,
                            context
                                .read<DriverProfileCubit>()
                                .phoneNumberController
                                .text,
                            context
                                .read<DriverProfileCubit>()
                                .passwordController
                                .text,
                          )
                          .then((_) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Password changed successfully!'),
                              ),
                            );
                            Navigator.pop(context);
                          })
                      : null;
                } else if (oldPasswordController.text !=
                    CacheHelper().getData(key: ApiKeys.password)) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Old Password is incorrect.')),
                  );
                } else if (confirmPasswordController.text !=
                    context
                        .read<DriverProfileCubit>()
                        .passwordController
                        .text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Passwords do not match or are invalid.'),
                    ),
                  );
                }
              },
              child: Container(
                width: 295.w,
                height: 48.h,
                padding: EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                decoration: BoxDecoration(
                  color: Color(0xff266FFF),

                  borderRadius: BorderRadiusDirectional.circular(8.r),
                ),
                child: Center(
                  child: Text(
                    'Change',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: TextButton(
                onPressed: () {},
                child: Text(
                  'Cancel',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
