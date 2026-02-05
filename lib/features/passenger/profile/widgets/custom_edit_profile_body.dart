

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/widgets/custom_elevated_btn.dart';
import 'package:go_car/core/widgets/custom_text_field.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_cubit.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

Widget CustomEditProfileBody(
    ClientProfileState state,
    ClientProfileCubit cubit,
    BuildContext context
    ) {
  ImageProvider profileImage(String? image) {
    if (image == null || image.trim().isEmpty) {
      return const AssetImage(
        'assets/images/noun-profile-138926 1.png',
      );
    }
    return NetworkImage(image);
  }

  if (state is ClientProfileLoading) {
    return const Center(child: CircularProgressIndicator());
  }

  if (state is ClientProfileFailure) {
    return Center(child: Text(state.errMessage));
  }

  if (state is ClientProfileSuccess) {
    final profileImg =state.clientModel.image;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 30.h),

        // Profile Image
        Stack(
          clipBehavior: Clip.none,
          children: [
            CircleAvatar(
                radius: 70.r,
                backgroundImage:profileImage(profileImg)
            ),
            Positioned(
              bottom: -4.h,
              right: 10.w,
              child: GestureDetector(
                onTap: () async {
                  final image = await ImagePicker()
                      .pickImage(source: ImageSource.gallery);
                  if (image != null) cubit.setProfilePic(image);
                },
                child: Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: const Color(0xff266FFF),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Icon(Icons.edit, color: Colors.white),
                ),
              ),
            ),
          ],
        ),

        SizedBox(height: 30.h),

        // name
        CustomTextField(
          fieldTitle: 'Full name',
          controller: cubit.nameController,
        ),

        SizedBox(height: 16.h),

        // Phone
        IntlPhoneField(
          controller:cubit.phoneController,
          initialCountryCode: 'EG',
          decoration: const InputDecoration(
            filled: true,
            border: OutlineInputBorder(),
          ),
          onChanged: (phone) {
             cubit.phoneController.text = phone.number;
          },
        ),

        const Spacer(),

        // Update Button
        CustomElevatedBtn(
          btnName: 'Update',
          onPressed: () async {
            await cubit.clientProfileUpdate(cubit.nameController.text,cubit.phoneController.text);
            Navigator.pop(context);
          },
        ),

        SizedBox(height: 20.h),
      ],
    );
  }

  return const SizedBox();
}