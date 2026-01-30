import 'dart:math' as math;

import 'package:curved_labeled_gradient_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_gradient_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../core/routing/routes.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  const BottomNavigationBarWidget({super.key, required this.currentIndex});
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 60.h,
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
                  ? SvgPicture.asset("assets/images/noun_calendar1.svg")
                  : SvgPicture.asset(
                    "assets/images/noun_calendar.svg",
                    colorFilter: const ColorFilter.mode(
                      Color(0xffABB7C2),
                      BlendMode.srcIn,
                    ),
                  ),

          label: currentIndex == 1 ? 'Calendar' : '',
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
        CurvedNavigationBarItem(
          child:
              currentIndex == 2
                  ? SvgPicture.asset("assets/images/noun_wallet1.svg")
                  : SvgPicture.asset(
                    "assets/images/noun_wallet.svg",
                    colorFilter: const ColorFilter.mode(
                      Color(0xffABB7C2),
                      BlendMode.srcIn,
                    ),
                  ),

          label: currentIndex == 2 ? 'wallet' : '',
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
        CurvedNavigationBarItem(
          child:
              currentIndex == 3
                  ? SvgPicture.asset("assets/images/noun_profile1.svg")
                  : SvgPicture.asset(
                    "assets/images/noun_profile.svg",
                    colorFilter: const ColorFilter.mode(
                      Color(0xffABB7C2),
                      BlendMode.srcIn,
                    ),
                  ),

          label: currentIndex == 3 ? 'Profile' : '',
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
            Navigator.pushNamed(context, Routes.home);

            break;

          case 1:
            Navigator.pushNamed(context, Routes.passengerScheduleRide);

            break;

          case 2:
            Navigator.pushNamed(context, Routes.noSavedCardScreen);

            break;

          case 3:
            Navigator.pushNamed(context, Routes.profileScreen);

            break;
        }
      },
    );
  }
}

gradientText(text) {
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
