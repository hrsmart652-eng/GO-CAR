import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/widgets/custom_elevated_btn.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_cubit.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_state.dart';
import '../../../../core/widgets/custom_app_bar.dart';
import '../../../../core/widgets/custom_text_field.dart';
import '../widgets/custom_edit_profile_image.dart';
import '../widgets/custom_edit_profile_phone.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late ClientProfileCubit clientProfileCubit;
  @override
  void initState() {
    super.initState();
    clientProfileCubit = ClientProfileCubit.of(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientProfileCubit, ClientProfileState>(
      listener: (context, state) {
        if (state is ClientProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        } else if (state is ClientProfileLoading) {
            Center(child: CircularProgressIndicator(color: Colors.red));
        }
      },
      builder: (context, state){
        if( state is ClientProfileSuccess){
         return Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Color(0xffFCFCFD),
            appBar: customAppBar(title: 'Edit Profile'),
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 30.h),
                  CustomEditProfileImage(clientProfileCubit: clientProfileCubit,clientModel:state.clientModel),

                  SizedBox(height: 30.h),

                  CustomTextField(
                    fieldTitle: 'Full name',
                    // controller: nameController,
                    controller: clientProfileCubit.nameController,
                  ),

                  CustomEditProfilePhone(clientProfileCubit: clientProfileCubit),
                  SizedBox(height: 170.h),
                  CustomElevatedBtn(
                    btnName: 'Update',
                    onPressed: () {
                      clientProfileCubit.clientProfileUpdate(
                        clientProfileCubit.nameController.text,
                        clientProfileCubit.phoneController.text,
                      );
                      Navigator.pushNamed(context,Routes.profileScreen);
                    },
                  ),
                ],
              ),
            ),
          );
        }else if(state is ClientProfileFailure){
          return  Container(child: Text('no Data', style: TextStyle(fontSize: 20),),
            color: Colors.red,);
        }
        return const SizedBox();
      },
    );
  }
}


