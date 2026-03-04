import 'package:flutter/material.dart';

import '../../../../../config/environment.dart';
import '../../cubit/scheduled_ride_cubit.dart';

class SchduleRideType extends StatelessWidget {
  const SchduleRideType({super.key, required this.scheduledRideCubit});

  final ScheduledRideCubit scheduledRideCubit;

  @override
  Widget build(BuildContext context) {

    return Row(
      children: [

        Expanded(
          child: RadioListTile<RideType>(
            title: const Text("One-way"),
            value: RideType.oneWay,
            groupValue: scheduledRideCubit.selectedRideType,
            onChanged: (value) {
              if (value != null) {
                scheduledRideCubit.changeRideType(value);
              }
            },
            activeColor: const Color(0xFF266FFF),
          ),
        ),

        Expanded(
          child: RadioListTile<RideType>(
            title: const Text("Return"),
            value: RideType.returnRide,
            groupValue: scheduledRideCubit.selectedRideType,
            onChanged: (value) {
              if (value != null) {
                scheduledRideCubit.changeRideType(value);
              }
            },
            activeColor: const Color(0xFF266FFF),
          ),
        ),

      ],
    );
  }
}
