import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_state.dart';
import '../widgets/normal_ride_body.dart';
import '../widgets/normal_ride_images_horzenital.dart';


class NormalRideContainer extends StatelessWidget {
  const NormalRideContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NormalRideCubit, RequestRideState>(
      listener: (context, state) {
        if (state is RequestRideLoading) {
       Scaffold(body:Center(child:CircularProgressIndicator(),),);
        }
        if (state is RequestRideFailure) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errMessage)));
        } else if (state is RequestRideSuccess) {
          // how get data for client
         // showSnackBar(context,message:'Request Sent Completed ');
        }
      },
      builder: (context, state){
        final normalCubit =NormalRideCubit.get(context);
        return Column(
          children: [
            NormalRidetImagesHorizetal(normalCubit: normalCubit),
            NormalRidetBody(normalCubit:normalCubit, context: context)
          ],
        );
      },
    );
  }
}
