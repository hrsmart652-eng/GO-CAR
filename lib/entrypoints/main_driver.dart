import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/dio_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/common/auth/login/cubit/driver_login_cubit.dart';
import 'package:go_car/features/common/auth/login/repository/driver_login_repository.dart';
import 'package:go_car/features/driver/authentication/sign_up/cubit/driver_signup_cubit.dart';
import 'package:go_car/features/driver/authentication/sign_up/repositories/driver_signup_repository.dart';
import 'package:go_car/features/driver/home/cubit/driver_ride_cubit.dart';
import 'package:go_car/features/driver/home/cubit/driver_shift_cubit.dart';
import 'package:go_car/features/driver/home/cubit/new_trip_cubit.dart';
import 'package:go_car/features/driver/home/repository/driver_ride_repository.dart';
import 'package:go_car/features/driver/home/repository/driver_shift_repository.dart';
import 'package:go_car/features/driver/home/repository/new_trip_repository.dart';
import 'package:go_car/features/driver/profile/cubit/driver_profile_cubit.dart';
import 'package:go_car/features/driver/profile/cubit/driver_reviews_cubit.dart';
import 'package:go_car/features/driver/profile/repositories/driver_profile_repository.dart';
import 'package:go_car/features/driver/profile/repositories/driver_reviews_repository.dart';

import '../config/app_config.dart';
import '../config/environment.dart';
import '../core/routing/app_routers.dart';
import '../core/routing/routes.dart';

void main() async {
  AppConfig.init(AppConfig(environment: Environment.driver));
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => DriverLoginCubit(
                DriverLoginRepository(DioConsumer(dio: Dio())),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverSignUpCubit(
                DriverSignupRepository(Api: DioConsumer(dio: Dio())),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverShiftCubit(
                DriverShiftRepository(api: DioConsumer(dio: Dio())),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverRideCubit(
                DriverRideRepository(api: DioConsumer(dio: Dio())),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverProfileCubit(
                DriverProfileRepository(Api: DioConsumer(dio: Dio())),
              ),
        ),
        BlocProvider(
          create:
              (context) => DriverReviewsCubit(
                DriverReviewsRepository(Api: DioConsumer(dio: Dio())),
              ),
        ),
        BlocProvider(
          create:
              (context) =>
                  NewTripCubit(NewTripRepository(Api: DioConsumer(dio: Dio()))),
        ),
      ],
      child: DriverApp(),
    ),
  );
}

class DriverApp extends StatelessWidget {
  const DriverApp({super.key});

  @override
  Widget build(BuildContext context) {
    // bool isDriver = true;
    return ScreenUtilInit(
      // designSize: const Size(375, 812),
      minTextAdapt: true,

      child: MaterialApp(
        title: 'Go Car',

        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cairo',
          dialogTheme: DialogThemeData(backgroundColor: Colors.white),
        ),
        initialRoute:
            // (CacheHelper.sharedPreferences.containsKey(ApiKeys.token) &&
            //             CacheHelper.sharedPreferences.containsKey(ApiKeys.id)) &&
            //             // ApiKeys.rememberMe == true) &&
            //         Environment.driver == true
            //     ? Routes.driverHome
            //     : Routes.driverOnboarding,
            (CacheHelper.sharedPreferences.containsKey(ApiKeys.token) &&
                    CacheHelper.sharedPreferences.containsKey(ApiKeys.id) &&
                    (CacheHelper.sharedPreferences.getBool('rememberMe') ==
                            true ??
                        false) &&
                    Environment.driver == true)
                ? Routes.driverHome
                : Routes.driverOnboarding,

        onGenerateRoute: AppRouter().generateRoute,
      ),
    );
  }
}
