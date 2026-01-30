import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/features/driver/home/views/widgets/scheduled_ride/no_scheduled_trips.dart';
import 'package:go_car/features/driver/home/views/widgets/scheduled_ride/scheduled_trips.dart';

class ScheduledRide extends StatefulWidget {
  const ScheduledRide({super.key});

  @override
  State<ScheduledRide> createState() {
    return _ScheduledRideState();
  }
}

class _ScheduledRideState extends State<ScheduledRide> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabItem('Booked', 0),
                _buildTabItem('Tomorrow', 1),
                _buildTabItem('The day after', 2),
              ],
            ),
          ),
          _selectedIndex == 0
              ? NoScheduledTrips()
              : _selectedIndex == 1
              ? ScheduledTrips()
              : NoScheduledTrips(),
        ],
      ),
    );
  }

  Widget _buildTabItem(String text, int index) {
    bool isSelected = _selectedIndex == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        // width: 100.w,
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? Color(0xffBBD1FB) : Color(0xffEAECF0),
          ),
          color: isSelected ? Color(0xffF5FAFF) : Colors.white,
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Color(0xff266FFF) : Color(0xff475467),
            fontSize: 14.sp,

            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            decorationColor: Color(0xff266FFF),
            decorationThickness: 2,
          ),
        ),
      ),
    );
  }
}
