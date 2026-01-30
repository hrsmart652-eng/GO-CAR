import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/features/driver/home/cubit/driver_ride_cubit.dart';
import 'package:go_car/features/driver/home/cubit/driver_ride_state.dart';
import 'package:go_car/features/driver/home/views/widgets/normal_ride/new_ride.dart';

class NormalRide extends StatefulWidget {
  const NormalRide({super.key});

  @override
  State<NormalRide> createState() => _NormalRideState();
}

class _NormalRideState extends State<NormalRide> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DriverRideCubit, DriverRideState>(
      listener:
          (context, state) => {
            if (state is DriverRideFailure)
              {
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text(state.errMessage))),
              },
          },
      builder: (context, state) {
        return NewRide();
      },
    );
  }
}
