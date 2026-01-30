import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class NoScheduledTrips extends StatelessWidget {
  const NoScheduledTrips({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(10),
            width: 100.w,
            child: Image.asset('assets/images/schedule.png', fit: BoxFit.fill),
          ),
          Text(
            'Unfortunately,\n there are no scheduled trips',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
