import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/widgets/custom_elevated_btn.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_cubit.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_state.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // late StreamSubscription<ClientProfileState> _profileStateSubscription;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  String? completePhoneNumber;

  // @override
  // void dispose() {
  //   _profileStateSubscription.cancel();
  //   super.dispose();
  // }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final cubit = context.read<ClientProfileCubit>();

    if (cubit.state is ClientProfileSuccess) {
      final profile = (cubit.state as ClientProfileSuccess).clientModel;

      cubit.nameController.text = profile.fullName ?? '';
      cubit.phoneController.text = profile.phoneNumber ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientProfileCubit, ClientProfileState>(
      listener: (context, state) {
        if (state is ClientProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
        // else if (state is ClientProfileSuccess) {
        //   // how get data for client
        // }
      },
      builder: (context, state) {
        // state is ClientProfileInitial
        //     ? context.read<ClientProfileCubit>().getClientProfile()
        //     : null;
        return Scaffold(
          backgroundColor: Color(0xffFCFCFD),

          appBar: customAppBar(title: 'Edit Profile'),

          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),

              child: BlocBuilder<ClientProfileCubit, ClientProfileState>(
                builder: (context, state) {
                  if (state is ClientProfileSuccess) {
                    return Column(
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
                                    state.clientModel.image == null
                                        ? AssetImage(
                                          'assets/images/noun-profile-138926 1.png',
                                        )
                                        : NetworkImage(
                                        state.clientModel.image
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
                                        .pickImage(source: ImageSource.gallery);

                                    if (pickedImage == null) {
                                      // User canceled
                                      return;
                                    }

                                    context
                                        .read<ClientProfileCubit>()
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
                          // controller: nameController,
                          controller:
                              // nameController
                              context.read<ClientProfileCubit>().nameController,
                        ),

                        SizedBox(
                          height: 50.h,
                          child: IntlPhoneField(
                            initialValue:
                                context
                                    .read<ClientProfileCubit>()
                                    .phoneController
                                    .text,

                            // controller: phoneController,
                            // initialValue: phoneController.text,
                            // initialValue:
                            //     context
                            //         .read<ClientProfileCubit>()
                            //         .phoneController
                            //         .text,
                            // initialValue:
                            // context
                            //     .read<ClientSignupCubit>()
                            //     .signUpPhoneNumber
                            //     .text,
                            pickerDialogStyle: PickerDialogStyle(
                              countryNameStyle: TextStyle(color: Colors.black),
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
                              // labelText: 'Phone Number',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFFD0D5DD),
                                  width: 1,
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
                                  .read<ClientProfileCubit>()
                                  .phoneController
                                  .text = phone.completeNumber;
                            },
                          ),
                        ),

                        SizedBox(height: 170.h),

                        CustomElevatedBtn(
                          btnName: 'Update',
                          onPressed: () {
                            context
                                .read<ClientProfileCubit>()
                                .clientProfileUpdate(
                                  context
                                      .read<ClientProfileCubit>()
                                      .nameController
                                      .text,
                                  context
                                      .read<ClientProfileCubit>()
                                      .phoneController
                                      .text,
                                );

                            Navigator.pushNamed(context, Routes.profileScreen);
                          },
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
          ),
        );
      },
    );
  }
}
