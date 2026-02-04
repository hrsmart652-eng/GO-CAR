import 'dart:math' as math;

import 'package:curved_labeled_gradient_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_gradient_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_cubit.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_state.dart';

import '../../../../../core/routing/routes.dart';
import '../screens/driver_home_screen.dart';

class DriverNavigationBarWidget extends StatelessWidget {
  final int currentIndex;

  const DriverNavigationBarWidget({super.key, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return BlocListener<DriverProfileCubit, DriverProfileState>(
      listener: (context, state) {
        if (state is DriverProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        }
      },
      child: CurvedNavigationBar(
        height: 70.h,
        color: Colors.white,
        backgroundColor: Colors.white,
        index: currentIndex,

        items: [
          CurvedNavigationBarItem(
            child:
                currentIndex == 0
                    ? SvgPicture.asset(
                      "assets/images/home.svg",
                      colorFilter: const ColorFilter.mode(
                        Colors.white,
                        BlendMode.srcIn,
                      ),
                    )
                    : SvgPicture.asset("assets/images/home1.svg"),

            label: currentIndex == 0 ? 'Home' : '',
            labelStyle: TextStyle(
              foreground:
                  Paint()
                    ..shader = const LinearGradient(
                      colors: [Color(0xFF183E91), Color(0xFF266FFF)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),

          CurvedNavigationBarItem(
            child:
                currentIndex == 1
                    ? SvgPicture.asset("assets/images/noun_wallet1.svg")
                    : SvgPicture.asset(
                      "assets/images/noun_wallet.svg",
                      colorFilter: const ColorFilter.mode(
                        Color(0xffABB7C2),
                        BlendMode.srcIn,
                      ),
                    ),
            label: currentIndex == 1 ? 'wallet' : '',
            labelStyle: TextStyle(
              foreground:
                  Paint()
                    ..shader = const LinearGradient(
                      colors: [Color(0xFF183E91), Color(0xFF266FFF)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ).createShader(Rect.fromLTWH(0, 0, 150, 70)),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          CurvedNavigationBarItem(
            child:
                currentIndex == 2
                    ? SvgPicture.asset("assets/images/noun_profile1.svg")
                    : SvgPicture.asset(
                      "assets/images/noun_profile.svg",
                      colorFilter: const ColorFilter.mode(
                        Color(0xffABB7C2),
                        BlendMode.srcIn,
                      ),
                    ),
            label: currentIndex == 2 ? 'Profile' : '',
            labelStyle: TextStyle(
              foreground:
                  Paint()
                    ..shader = const LinearGradient(
                      colors: [Color(0xFF183E91), Color(0xFF266FFF)],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topRight,
                    ).createShader(Rect.fromLTWH(0, 0, 200, 70)),
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
        buttonGradient: const LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [Color(0xFF183E91), Color(0xFF266FFF)],
          transform: GradientRotation(85.84 * math.pi / 180),
        ),

        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DriverHomeScreen(true)),
              );

              break;

            case 1:
              Navigator.pushNamed(context, Routes.driverWallet);

              break;

            case 2:
              Navigator.pushNamed(context, Routes.driverProfile);

              break;
          }
        },
      ),
    );
  }
}

GradientText(text) {
  const gradient = LinearGradient(
    begin: Alignment.bottomLeft,
    end: Alignment.topRight,
    colors: [Color(0xFF183E91), Color(0xFF266FFF)],
    transform: GradientRotation(85.84 * math.pi / 180),
  );
  return ShaderMask(
    shaderCallback:
        (bounds) => gradient.createShader(
          Rect.fromLTWH(0, 0, bounds.width, bounds.height),
        ),
    child: Text(
      text,
      style: TextStyle(
        fontSize: 12.sp,
        fontWeight: FontWeight.w700,
        color: Colors.white,
      ),
    ),
  );
}
