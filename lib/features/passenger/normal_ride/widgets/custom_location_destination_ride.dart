import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/widgets/custom_textt_field.dart';
import '../../schedule_ride/views/widgets/schdule_trip_search_location_destination.dart';

class CustomLocationAndDestinationRide extends StatelessWidget {
  CustomLocationAndDestinationRide({
    super.key,
    this.horizontal,
    this.vertical,
    required this.currentLocCon,
    required this.destinationCon,
    this.enableNavigate=true,
  });

  double? horizontal, vertical;
  TextEditingController currentLocCon;
  TextEditingController destinationCon;
   bool enableNavigate;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: horizontal ?? 16.w,
        vertical: vertical ?? 65.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            child: CustomTextFieldValidator(
              readOnly:true,
              isCurrentLocation: true,
              labelText: "Current Location",
              enableBorder: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Current Location is required";
                }
                return null;
              },
              isPrefixIcon: true,
              enableAddress: false,
              controller: currentLocCon,
              enableTextField: false,
            ),
            onTap:enableNavigate==true? () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => SchduleTripSearchLocationDestination(
                        isCurrentLocation: true,
                      ),
                ),
              );
            }:null,
          ),

          GestureDetector(
            child: CustomTextFieldValidator(
              readOnly: true,
              isCurrentLocation: false,
              enableBorder: true,
              enableAddress: false,
              isPrefixIcon: true,
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return "Destination is required";
                }
                return null;
              },
              labelText: "Where to?",
              controller: destinationCon,
              enableTextField: false,
            ),
            onTap:enableNavigate==true? () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => SchduleTripSearchLocationDestination(
                        isCurrentLocation: false,
                      ),
                ),
              );
            }:null,
          ),

          // TextField(
          //   decoration: InputDecoration(
          //     isDense: true,
          //     labelText: 'Current location',
          //     labelStyle: TextStyle(
          //       color: const Color(0xff475467),
          //       fontSize: 14.sp,
          //       fontWeight: FontWeight.w400,
          //     ),
          //     contentPadding: const EdgeInsets.all(5.0),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8.r),
          //       borderSide: BorderSide.none,
          //     ),
          //     filled: true,
          //     fillColor: Colors.white,
          //     prefixIcon: Icon(
          //       Icons.circle,
          //       color: const Color(0xff5F00FB),
          //       size: 8.w,
          //     ),
          //   ),
          // ),
          // SizedBox(height: 8.h),
          //
          // // Where to   ****************************************
          // TextField(
          //   decoration: InputDecoration(
          //     isDense: true,
          //     labelText: 'Where to?',
          //     labelStyle: TextStyle(
          //       color: const Color(0xff475467),
          //       fontSize: 14.sp,
          //       fontWeight: FontWeight.w400,
          //     ),
          //     contentPadding: const EdgeInsets.all(5.0),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(8.r),
          //       borderSide: BorderSide.none,
          //     ),
          //     filled: true,
          //     fillColor: Colors.white,
          //     prefixIcon: Icon(
          //       Icons.circle,
          //       color: const Color(0xff60BF95),
          //       size: 8.w,
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
