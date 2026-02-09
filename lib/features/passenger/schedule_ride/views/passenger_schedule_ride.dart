import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/passenger/profile/widgets/custom_profile_text.dart';
import 'package:go_car/features/passenger/schedule_ride/views/under_review.dart';
import 'package:go_car/features/passenger/schedule_ride/views/widgets/schedule_ride.dart';
import '../../home/widgets/bottom_navigation_bar.dart';
import 'accepted_ride_screen.dart';

class PassengerScheduleRide extends StatefulWidget {
  const PassengerScheduleRide({super.key});

  @override
  State<PassengerScheduleRide> createState() => _PassengerScheduleRideState();
}

class _PassengerScheduleRideState extends State<PassengerScheduleRide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Stack(
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: 16.0.w,
                      right: 16.0.w,
                      top: 30.0.h,
                      bottom: 15.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomProfileText(text:"Schedule your upcoming ride!",color:const Color(0xff0D3244)),
                        SizedBox(height: 20.h),
                        // Upcoming rides
                        CustomProfileText(text: "Upcoming rides!",color:const Color(0xff0D3244)),

                        SizedBox(height: 15),
                        RequestResponse(
                          image: Image.asset(
                            "assets/images/review_request.png",
                          ),
                          title: '#1235 request under review..',
                          content: 'please be patient...',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UnderReview(),
                              ),
                            );
                          },
                        ),
                        SizedBox(height: 10),
                        RequestResponse(
                          image: Image.asset("assets/images/accepted.png"),
                          title: '#1235 request has been Accepted .',
                          content: 'please be on time...',
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AcceptedRideScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  ScheduleRide(),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBarWidget(currentIndex: 1),
    );
  }
}

class RequestResponse extends StatelessWidget {
  final Image image;
  final String title;
  final String content;
  final VoidCallback onTap;

  const RequestResponse({
    super.key,
    required this.image,
    required this.title,
    required this.content,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.h,
        width: 332.w,
        decoration: BoxDecoration(color: Color(0xfff3f6fb)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Row(
            children: [
              image,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w700,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                    Text(
                      content,
                      style: TextStyle(
                        color: Color(0xff475467),
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
