import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/routing/routes.dart';
import '../../normal_ride/views/normal_ride_container.dart';
import '../../profile/cubit/client_profile_cubit.dart';
import '../../profile/cubit/client_profile_state.dart';
import '../widgets/bottom_navigation_bar.dart';

class ClientHomeScreen extends StatefulWidget {
  const ClientHomeScreen({super.key});

  @override
  State<ClientHomeScreen> createState() => _ClientHomeScreenState();
}

class _ClientHomeScreenState extends State<ClientHomeScreen> {
  ScrollPosition? currentScrollPosition;
  List<Widget> images = [
    Image.asset('assets/images/ads.png', fit: BoxFit.cover),
    Image.asset("assets/images/ads.png", fit: BoxFit.cover),
    Image.asset("assets/images/ads.png", fit: BoxFit.cover),
    Image.asset("assets/images/ads.png", fit: BoxFit.cover),
    Image.asset("assets/images/ads.png", fit: BoxFit.cover),
  ];

  final CarouselSliderController _controller = CarouselSliderController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClientProfileCubit, ClientProfileState>(
      listener: (context, state) {
        if (state is ClientProfileFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        } else if (state is ClientProfileSuccess) {
          // how get data for client

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(content: Text('Welcome ${state.clientModel.fullName}')),
          // );
        }
      },
      builder: (context, state) {
        state is ClientProfileInitial
            ? context.read<ClientProfileCubit>().getClientProfile()
            : null;
        return Scaffold(
          backgroundColor: Colors.white,
          body: SafeArea(
            child: SingleChildScrollView(
               child: Column(
                 children: [
                   Padding(
                     padding: EdgeInsets.only(
                       left: 16.0.w,
                       right: 16.0.w,
                       top: 30.0.h,
                       bottom: 15.h,
                     ),
                     child: Column(
                       children: [
                         Row(
                           children: [
                             BlocBuilder<ClientProfileCubit, ClientProfileState>(
                               builder: (context, state) {
                                 if (state is ClientProfileSuccess) {
                                   print(
                                     "Good Morning ${state.clientModel.fullName}.............!!",
                                   );

                                   return Column(
                                     children: [
                                       Text(
                                         "Good Morning ${state.clientModel.fullName}.!!",
                                         style: TextStyle(
                                           fontSize: 18.sp,
                                           fontWeight: FontWeight.w700,
                                           color: const Color(0xff0D3244),
                                         ),
                                       ),
                                     ],
                                   );
                                 } else {
                                   return Text(
                                     "Good Morning...",
                                     style: TextStyle(
                                       fontSize: 18.sp,
                                       fontWeight: FontWeight.w700,
                                       color: const Color(0xff0D3244),
                                     ),
                                   );
                                 }
                               },
                             ),
                             const Spacer(),

                             IconButton(
                               onPressed: () {
                                 Navigator.pushNamed(
                                   context,
                                   Routes.clientNotifications,
                                 );
                               },
                               icon: Icon(Icons.notifications, size: 30),
                             ),
                             // SvgPicture.asset(
                             //   "assets/images/notifications.svg",
                             //   width: 20.17.w,
                             //   height: 21.5.h,
                             // ),
                           ],
                         ),
                         SizedBox(height: 20.h),

                         // Custom carousel slider *****************************************
                         SizedBox(
                           height: 116.h,
                           width: double.infinity,
                           child: CarouselSlider(
                             items:
                                 images
                                     .map(
                                       (img) => Container(
                                         width: 242.w, // Increased width
                                         height: 98.h, // Increased height
                                         decoration: BoxDecoration(
                                           borderRadius:
                                               BorderRadius.circular(12.r),
                                         ),
                                         child: ClipRRect(
                                           borderRadius:
                                               BorderRadius.circular(12.r),
                                           child: img,
                                         ),
                                       ),
                                     )
                                     .toList(),
                             carouselController: _controller,
                             options: CarouselOptions(
                               height: 116.h,
                               viewportFraction: 0.7, // قلل الفاصل بين الصور
                               enlargeCenterPage: true,
                               enlargeStrategy:
                                   CenterPageEnlargeStrategy.scale,
                               onPageChanged: (index, reason) {
                                 setState(() {
                                   currentIndex = index;
                                 });
                               },
                             ),
                           ),
                         ),
                         SizedBox(height: 15.h),
                         // Custom dot indicators   ****************************************
                         Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: List.generate(images.length, (index) {
                             final bool isActive = currentIndex == index;
                             return GestureDetector(
                               onTap: () => _controller.animateToPage(index),
                               child: AnimatedContainer(
                                 duration: const Duration(milliseconds: 300),
                                 margin: EdgeInsets.symmetric(
                                   horizontal: 3.w,
                                 ),
                                 height: 6.h,
                                 width: 6.w,
                                 decoration: BoxDecoration(
                                   color:
                                       isActive
                                           ? const Color(0xff0D3244)
                                           : const Color(0xffD9D9D9),
                                   borderRadius: BorderRadius.circular(
                                     100.r,
                                   ),
                                 ),
                               ),
                             );
                           }),
                         ),
                         // List of cars and names   ****************************************
                       ],
                     ),
                   ),

                   // Current location   ****************************************
                   SizedBox(
                       height:700.h,
                       child: NormalRideContainer()),
                 ],
               ),
            ),
          ),
          bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 0),
        );
      },
    );
  }
}
