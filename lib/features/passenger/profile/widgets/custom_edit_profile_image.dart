import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_cubit.dart';
import 'package:go_car/features/passenger/profile/model/client_model.dart';
import 'package:image_picker/image_picker.dart';

import '../cubit/client_profile_state.dart';

class CustomEditProfileImage extends StatelessWidget {
  const CustomEditProfileImage({
    super.key,
    required this.clientProfileCubit, required this.clientModel
  });

  final ClientProfileCubit clientProfileCubit;
  final ClientModel clientModel;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        SizedBox(
          width: 141.w,
          height: 141.h,
          child: BlocBuilder<ClientProfileCubit, ClientProfileState > (
        builder: (context, state) {
          String imageUrl =clientModel.image ?? "";

          if (state is ClientProfileImageSuccess) {
            imageUrl = state.client.image ?? "";
          }

          final bool isLoading =
          state is ClientProfileImageLoading;

          return Stack(
            alignment: Alignment.center,
            children: [

              CircleAvatar(
                radius: 50.r,
                backgroundImage: imageUrl.isEmpty
                    ? const AssetImage(
                  'assets/images/noun-profile-138926 1.png',
                )
                    : NetworkImage(imageUrl)
                as ImageProvider,
              ),

              if (isLoading)
                Container(
                  width: 100.r,
                  height: 100.r,
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.4),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  ),
                ),
            ],
          );
        },
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
                clientProfileCubit.setProfilePic(pickedImage);
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
    );
  }
}
