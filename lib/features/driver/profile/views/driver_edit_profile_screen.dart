import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/widgets/custom_elevated_btn.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_cubit.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_text_field.dart';

class DriverEditProfileScreen extends StatefulWidget {
  const DriverEditProfileScreen({super.key});

  @override
  State<DriverEditProfileScreen> createState() =>
      _DriverEditProfileScreenState();
}

class _DriverEditProfileScreenState extends State<DriverEditProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String? completePhoneNumber;

  @override
  void initState() {
    super.initState();
    final cubit = context.read<DriverProfileCubit>();

    if (cubit.state is DriverProfileSuccess) {
      final profile = (cubit.state as DriverProfileSuccess).driverProfile;

      cubit.nameController.text = profile.fullName ?? '';
      cubit.phoneNumberController.text = profile.phoneNumber ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverProfileCubit, DriverProfileState>(
      listener: (context, state) {
        if (state is DriverProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Color(0xffFCFCFD),

          appBar: customAppBar(title: 'Edit Profile'),

          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child:
                state is DriverProfileLoading
                    ? Center(child: CircularProgressIndicator())
                    : state is DriverProfileSuccess
                    ? SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 30.h),
                          Stack(
                            clipBehavior: Clip.none,

                            children: [
                              SizedBox(
                                width: 141.w,
                                height: 141.h,
                                child: CircleAvatar(
                                  radius: 50.r,
                                  backgroundImage:
                                      state.driverProfile.image == null
                                          ? AssetImage(
                                            'assets/images/noun-profile-138926 1.png',
                                          )
                                          : NetworkImage(
                                            state.driverProfile.image,
                                          ),
                                ),
                              ),

                              Positioned(
                                left: 56.w,
                                bottom: -4.h,
                                child: GestureDetector(
                                  onTap: () async {
                                    try {
                                      final pickedImage = await ImagePicker()
                                          .pickImage(
                                            source: ImageSource.gallery,
                                          );

                                      if (pickedImage == null) {
                                        // User canceled
                                        return;
                                      }

                                      context
                                          .read<DriverProfileCubit>()
                                          .setProfilePic(pickedImage);
                                    } catch (e) {
                                      // Optionally show an error message to the user
                                      debugPrint('Image pick failed: $e');
                                    }
                                  },
                                  child: Container(
                                    width: 36,
                                    height: 36,
                                    decoration: BoxDecoration(
                                      color: Color(0xff266FFF),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.edit,
                                      size: 20.w,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 30.h),

                          CustomTextField(
                            fieldTitle: 'Full name',
                            hint: "Full Name",
                            controller:
                                context
                                    .read<DriverProfileCubit>()
                                    .nameController,
                          ),

                          SizedBox(
                            height: 60.h,
                            child: IntlPhoneField(
                              // initialValue:
                              //     context
                              //         .read<DriverProfileCubit>()
                              //         .phoneNumberController
                              //         .text,
                              textAlignVertical: TextAlignVertical.top,
                              // controller:
                              // phoneController,
                              // context
                              //     .read<DriverProfileCubit>()
                              //     .phoneNumberController,
                              pickerDialogStyle: PickerDialogStyle(
                                countryNameStyle: TextStyle(
                                  color: Colors.black,
                                ),
                                countryCodeStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              dropdownTextStyle: TextStyle(color: Colors.black),
                              dropdownDecoration: BoxDecoration(),
                              style: TextStyle(color: Colors.black),
                              autovalidateMode: AutovalidateMode.disabled,
                              decoration: InputDecoration(
                                fillColor: Colors.white,
                                filled: true,
                                labelText: 'Phone Number',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFFD0D5DD),
                                    // width: 1,
                                  ),
                                ),

                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFD0D5DD),
                                    width: 1,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFD0D5DD),
                                    width: 1,
                                  ),
                                ),
                              ),
                              initialCountryCode: 'EG',
                              onChanged: (phone) {
                                context
                                    .read<DriverProfileCubit>()
                                    .phoneNumberController
                                    .text
                                = phone.completeNumber;
                                // completePhoneNumber = phone.completeNumber;
                              },
                            ),
                          ),

                          SizedBox(height: 170.h),

                          CustomElevatedBtn(
                            btnName: 'Update',
                            onPressed: () {
                              context
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
                                  .then((_) => Navigator.of(context).pop());
                            },
                          ),
                        ],
                      ),
                    )
                    : Scaffold(
                      backgroundColor: Colors.white,
                      body: Text("Something went wrong"),
                    ),
          ),
        );
      },
    );
  }
}
