import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../config/app_config.dart';
import '../../../../../config/environment.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_elevated_btn.dart';
import '../../../../../core/widgets/custom_text_field.dart';
import '../../../../passenger/profile/cubit/client_profile_cubit.dart';
import '../cubit/client_login_cubit/client_login_cubit.dart';
import '../cubit/driver_login_cubit.dart';
import '../cubit/driver_login_state.dart';

class LoginScreen extends StatefulWidget {
  final flavor = AppConfig.instance.environment;
  final bool isDriver;

  LoginScreen({super.key, required this.isDriver});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isPasswordVisible = true;
  bool isRememberMeChecked = false;

  @override
  void initState() {
    super.initState();
    _loadSavedLoginData();
  }

  /// Load saved login data from SharedPreferences
  Future<void> _loadSavedLoginData() async {
    final prefs = await SharedPreferences.getInstance();
    final isDriver = widget.flavor == Environment.driver;

    setState(() {
      isRememberMeChecked = prefs.getBool('rememberMe') ?? false;

      if (isRememberMeChecked) {
        if (isDriver) {
          context.read<DriverLoginCubit>().signInEmail.text =
              prefs.getString('driverEmail') ?? '';
          context.read<DriverLoginCubit>().signInPassword.text =
              prefs.getString('driverPassword') ?? '';
        } else {
          context.read<ClientLoginCubit>().emailController.text =
              prefs.getString('clientEmail') ?? '';
          context.read<ClientLoginCubit>().passwordController.text =
              prefs.getString('clientPassword') ?? '';
        }
      }
    });
  }

  /// Save login data to SharedPreferences
  Future<void> _saveLoginData(bool isDriver) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('rememberMe', isRememberMeChecked);

    if (isRememberMeChecked) {
      if (isDriver) {
        await prefs.setString(
          'driverEmail',
          context.read<DriverLoginCubit>().signInEmail.text,
        );
        await prefs.setString(
          'driverPassword',
          context.read<DriverLoginCubit>().signInPassword.text,
        );
      } else {
        await prefs.setString(
          'clientEmail',
          context.read<ClientLoginCubit>().emailController.text,
        );
        await prefs.setString(
          'clientPassword',
          context.read<ClientLoginCubit>().passwordController.text,
        );

      }
    } else {
      await prefs.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDriverBloc = widget.flavor == Environment.driver;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: customAppBar(title: "Login"),
      body:
      isDriverBloc
          ? BlocConsumer<DriverLoginCubit, DriverLoginState>(
        listener: (context, state) {
          if (state is DriverSignInSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign in Success')),
            );
            // context.read<DriverProfileCubit>().getDriverProfile().then((
            //   _,
            // ) {
            Navigator.pushNamed(context, Routes.driverHome);
            // });
          } else if (state is DriverSignInFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          return _buildLoginForm(context, state, isDriverBloc);
        },
      )
          : BlocConsumer<ClientLoginCubit, ClientLoginState>(
        listener: (context, state) {
          if (state is ClientLoginSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Sign in Success')),
            );
            context.read<ClientProfileCubit>().getClientProfile().then((_,) {
              Navigator.pushNamed(context, Routes.home);
            });
          } else if (state is ClientLoginFailure) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errMessage)));
          }
        },
        builder: (context, state) {
          return _buildLoginForm(context, state, isDriverBloc);
        },
      ),
    );
  }

  Widget _buildLoginForm(BuildContext context, state, bool isDriverBloc) {
    // pick the correct controllers depending on role
    final emailController =
    isDriverBloc
        ? context.read<DriverLoginCubit>().signInEmail
        : context.read<ClientLoginCubit>().emailController;

    final passwordController =
    isDriverBloc
        ? context.read<DriverLoginCubit>().signInPassword
        : context.read<ClientLoginCubit>().passwordController;

    return SingleChildScrollView(
      padding: EdgeInsets.only(top: 35.0.w, right: 16.w, left: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          //------------------ logo and app name ---------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/images/logo.png', width: 50.w, height: 50.h),
              Text(
                'Go Car',
                style: TextStyle(
                  fontSize: 25.sp,
                  fontWeight: FontWeight.w700,
                  color: const Color(0xFF266FFF),
                ),
              ),
            ],
          ),
          SizedBox(height: 40.h),

          //------------------ welcome text ------------------
          Text(
            'Hello Again!',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0D3244),
            ),
          ),
          SizedBox(height: 14.h),
          Text(
            'Welcome back you\'ve been missed',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF475467),
            ),
          ),
          SizedBox(height: 30.h),

          //------------------ email ------------------
          CustomTextField(controller: emailController, fieldTitle: 'Email'),

          //------------------ password ------------------
          CustomTextField(
            controller: passwordController,
            fieldTitle: 'Password',
            isTextSecure: isPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              icon: Icon(
                isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                color: const Color(0xFF98A2B3),
              ),
            ),
          ),
          SizedBox(height: 20.h),

          //------------------ forgot password ------------------
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, Routes.forgetPassword);
              },
              child: Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF475467),
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),

          //------------------ remember me ------------------
          Row(
            children: [
              Checkbox(
                value: isRememberMeChecked,
                onChanged: (value) {
                  setState(() {
                    isRememberMeChecked = value!;
                  });
                },
                activeColor: const Color(0xFF266FFF),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Remember me',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  Text(
                    'Save my login details for next time.',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF667085),
                    ),
                  ),
                ],
              ),
            ],
          ),

          //------------------ login button ------------------
          SizedBox(height: 30.h),
          state is DriverSignInLoading || state is ClientLoginLoading
              ? const CircularProgressIndicator()
              : CustomElevatedBtn(
            btnName: 'Login',
            onPressed: () async {
              if (isDriverBloc) {
                context.read<DriverLoginCubit>().signIn();
              } else {
                context.read<ClientLoginCubit>().logIn();
              }
              await _saveLoginData(isDriverBloc);
            },
          ),
          SizedBox(height: 24.h),

          //------------------ dont have account ------------------
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Don\'t have an account?',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              TextButton(
                onPressed: () {
                  if (isDriverBloc) {
                    Navigator.pushNamed(context, Routes.driversignUp);
                  } else {
                    Navigator.pushNamed(context, Routes.signUp);
                  }
                },
                child: Text(
                  'SignUp',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF266FFF),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
