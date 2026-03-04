

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_car/core/services/api/dio_consumer.dart';
import 'package:go_car/features/passenger/normal_ride/repository/normal_ride_repo.dart';

import 'core/database/cache/cache_helper.dart';
import 'features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'features/passenger/normal_ride/views/normal_ride_container.dart';

main(){

  WidgetsFlutterBinding.ensureInitialized();
   CacheHelper().init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {


  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:BlocProvider(
          create: (context)=>NormalRideCubit(requestRideRepository:RequestRideRepository(api: DioConsumer(dio: Dio()))),
          child: NormalRideContainer()),
    );
  }
}
