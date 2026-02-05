import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/widgets/custom_elevated_btn.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_cubit.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_state.dart';
import 'package:go_car/features/passenger/profile/widgets/custom_edit_profile_body.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_text_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // late StreamSubscription<ClientProfileState> _profileStateSubscription;
  late ClientProfileCubit clientProfileCubit;

  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  // String? completePhoneNumber;

  // @override
  // void dispose() {
  //   _profileStateSubscription.cancel();
  //   super.dispose();
  // }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    clientProfileCubit = context.read<ClientProfileCubit>();
      clientProfileCubit.getClientProfile();
  }
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientProfileCubit, ClientProfileState>(
      listener: (context, state) {
        if (state is ClientProfileFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        }

        if (state is ClientProfileSuccess) {
          clientProfileCubit.nameController.text = state.clientModel.fullName ?? '';
          clientProfileCubit.phoneController.text = state.clientModel.phoneNumber ?? '';
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Profile updated successfully'))


          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<ClientProfileCubit>();

        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: const Color(0xffFCFCFD),
          appBar: customAppBar(title: 'Edit Profile'),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: CustomEditProfileBody(state, cubit,context),
          ),
        );
      },
    );
  }


}
