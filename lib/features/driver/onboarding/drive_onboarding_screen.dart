import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_car/core/routing/routes.dart';

class DriverOnboardingScreen extends StatefulWidget {
  const DriverOnboardingScreen({super.key});

  @override
  State<DriverOnboardingScreen> createState() => _DriverOnboardingScreenState();
}

class _DriverOnboardingScreenState extends State<DriverOnboardingScreen> {
  PageController pageController = PageController();
  int currentPageIndex = 0;

  List<Map<String, String>> onboardingPagesList = [
    {
      'imagePath': 'assets/images/girl_taxi_driver.png',
      'title': 'Choose the best ride nearby you to accept.',
      'description':
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered but the There are many variations of passages.',

      'animationImg': 'assets/images/first_onboarding_button.svg',
    },
    {
      'imagePath': 'assets/images/man_taxi_driver.png',
      'title': 'All you have mark your location and find all requests around.',
      'description':
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered but the There are many variations of passages.',
      'animationImg': 'assets/images/second_onboarding_button.svg',
    },
    {
      'imagePath': 'assets/images/driver_animation.png',
      'title': 'You can work on your own car from our application',
      'description':
          'There are many variations of passages of Lorem Ipsum available, but the majority have suffered but the There are many variations of passages.',

      'animationImg': 'assets/images/third_onboarding _button.svg',
    },
  ];

  List<Widget> animatedCars = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: 40.h),
        child: Stack(
          children: [
            //-------------------- PageView لعرض الشاشات --------------------//
            PageView.builder(
              itemCount: onboardingPagesList.length,
              controller: PageController(),
              onPageChanged: (index) {
                setState(() {
                  currentPageIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return OnboardingPageItem(
                  imagePath: onboardingPagesList[index]['imagePath']!,
                  title: onboardingPagesList[index]['title']!,
                  description: onboardingPagesList[index]['description']!,
                );
              },
            ),

            //---------------------- top skip button ----------------------//
            Positioned(
              top: 5.h,
              right: 16.w,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, Routes.login);
                },
                child: Text(
                  'SKIP',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF0D3244),
                  ),
                ),
              ),
            ),

            //----------------------   DotsIndicator and cars ----------------------//
            Positioned(
              bottom: 40.h,
              left: 0,
              right: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // النقاط ل
                    Row(
                      children: List.generate(
                        onboardingPagesList.length,
                        (index) => Container(
                          margin: EdgeInsets.symmetric(horizontal: 4.w),
                          width: currentPageIndex == index ? 24.w : 8.w,
                          height: 8.h,
                          decoration: BoxDecoration(
                            color:
                                currentPageIndex == index
                                    ? Color(0xFF266FFF)
                                    : Color(0xFFB0B0B0),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                        ),
                      ),
                    ),

                    //--------------- الصورة المتحركة جنب النقاط ----------------//
                    AnimatedSwitcher(
                      duration: Duration(microseconds: 1000),
                      transitionBuilder: (
                        Widget child,
                        Animation<double> animation,
                      ) {
                        return FadeTransition(
                          opacity: CurvedAnimation(
                            parent: animation,
                            curve: Curves.easeInOutCirc,
                          ),
                          child: child,
                        );
                      },
                      child: SvgPicture.asset(
                        onboardingPagesList[currentPageIndex]['animationImg']!,
                        height: 50,
                        width: 50,
                        key: ValueKey<int>(
                          currentPageIndex,
                        ), // مفتاح لتحديد التغيير
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPageItem extends StatelessWidget {
  final String imagePath;
  final String title;
  final String description;

  const OnboardingPageItem({
    super.key,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50.h),
            child: Image.asset(
              imagePath,
              width: 375.w,
              height: 301.h,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 24.0.w,
              right: 24.0.w,
              bottom: 16.0.h,
            ),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                color: Color(0xFF0D3244),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: 24.0.w,
              right: 24.0.w,
              bottom: 16.0.h,
            ),

            child: Text(
              description,

              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Color(0xFF475467),
                height: 1.5.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
