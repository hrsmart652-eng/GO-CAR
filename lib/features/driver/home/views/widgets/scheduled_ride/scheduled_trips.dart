import 'package:flutter/material.dart';
import 'package:go_car/features/driver/home/views/widgets/scheduled_ride/scheduled_details.dart';

class ScheduledTrips extends StatefulWidget {
  const ScheduledTrips({super.key});

  @override
  State<StatefulWidget> createState() {
    return _ScheduledTripsState();
  }
}

class _ScheduledTripsState extends State<ScheduledTrips> {
  @override
  Widget build(BuildContext context) {
    return Container(child: ScheduledDetails());
  }
}
