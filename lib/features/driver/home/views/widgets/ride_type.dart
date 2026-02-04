import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RideType extends StatefulWidget {
  final Function(int) onIndexChanged;
  const RideType({super.key, required this.onIndexChanged});

  @override
  State<RideType> createState() => _RideTypeState();
}

class _RideTypeState extends State<RideType> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildTabItem('Normal ride', 0),
          _buildTabItem('Scheduled', 1),
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
        widget.onIndexChanged(index); // Notify parent of index change
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: TextStyle(
                color: isSelected ? Color(0xff266FFF) : Colors.grey,
                fontSize: 14.sp,

                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                decorationColor: Color(0xff266FFF),
                decorationThickness: 2,
              ),
            ),
            if (isSelected)
              Container(
                margin: EdgeInsets.only(top: 4.h),
                height: 2.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: Color(0xff266FFF),
                  borderRadius: BorderRadius.circular(1.h),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
