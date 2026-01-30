import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_car/core/database/cache/cache_helper.dart';
import 'package:go_car/core/services/api/dio_consumer.dart';
import 'package:go_car/core/services/api/end_points.dart';
import 'package:go_car/features/common/auth/login/cubit/client_login_cubit/client_login_cubit.dart';
import 'package:go_car/features/common/auth/login/repository/client_login_repository.dart';
import 'package:go_car/features/passenger/normal_ride/cubit/normal_ride_cubit.dart';
import 'package:go_car/features/passenger/normal_ride/repository/normal_ride_repo.dart';
import 'package:go_car/features/passenger/profile/repository/client_profile_repository.dart';
import '../config/app_config.dart';
import '../config/environment.dart';
import '../core/routing/app_routers.dart';
import '../core/routing/routes.dart';
import '../features/common/auth/login/cubit/driver_login_cubit.dart';
import '../features/common/auth/login/repository/driver_login_repository.dart';
import '../features/common/auth/sign_up/cubit/client_signup_cubit.dart';
import '../features/common/auth/sign_up/repository/client_signup_repository.dart';
import '../features/passenger/profile/cubit/client_profile_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CacheHelper().init();
  AppConfig.init(AppConfig(environment: Environment.passenger));
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) => ClientProfileCubit(
            profileRepository: ClientProfileRepository(
              Api: DioConsumer(dio: Dio()),
            ),
          ),
        ),

        BlocProvider(
          create:
              (context) => ClientSignupCubit(
            clientSignupRepository: ClientSignupRepository(
              api: DioConsumer(dio: Dio()),
            ),
          ),
        ),
        BlocProvider(
          create:
              (context) => ClientLoginCubit(
            clientLoginRepository: ClientLoginRepository(
              DioConsumer(dio: Dio()),
              api: DioConsumer(dio: Dio()),
            ),
          ),
        ),
        BlocProvider(
          create:
              (context) => RequestRideCubit(
            requestRideRepository: RequestRideRepository(
              api: DioConsumer(dio: Dio()),
            ),
          ),
        ),
      ],
      child: const PassengerApp(),
    ),
  );
}

class PassengerApp extends StatelessWidget {
  const PassengerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // designSize: const Size(375, 812),
      minTextAdapt: true,

      child: MaterialApp(
        title: 'Go Car',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          fontFamily: 'Cairo',
          dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
        ),
        initialRoute:
        (CacheHelper.sharedPreferences.containsKey(ApiKeys.token) &&
            CacheHelper.sharedPreferences.containsKey(ApiKeys.id))
            //     CacheHelper.sharedPreferences.containsKey(ApiKeys.rememberMe) == true)
            &&
            Environment.passenger == true
            ? Routes.home
            : Routes.onboarding,

        // (ApiKeys.token != null && ApiKeys.rememberMe == true)
        // ? Routes.home
        // : Routes.onboarding,
        onGenerateRoute: AppRouter().generateRoute,
      ),
    );
  }
}
