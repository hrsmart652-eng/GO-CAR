import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart' show BlocProvider;
import 'package:go_car/core/routing/routes.dart';
import 'package:go_car/core/services/api/dio_consumer.dart';
import 'package:go_car/features/common/auth/login/views/login_screen.dart';
import 'package:go_car/features/driver/authentication/sign_up/views/driver_congratulations_screen.dart';
import 'package:go_car/features/driver/authentication/sign_up/views/driver_sign_up_screen.dart';
import 'package:go_car/features/driver/home/views/screens/congrats.dart';
import 'package:go_car/features/driver/home/views/screens/driver_ride_screen.dart';
import 'package:go_car/features/driver/home/views/screens/scheduled_ride_details.dart';
import 'package:go_car/features/driver/onboarding/drive_onboarding_screen.dart';
import 'package:go_car/features/driver/profile/views/driver_edit_profile_screen.dart';
import 'package:go_car/features/driver/profile/views/driver_history.dart';
import 'package:go_car/features/driver/profile/views/driver_reviews.dart';
import 'package:go_car/features/driver/profile/views/driver_settings_screen.dart';
import 'package:go_car/features/driver/wallet/driver_wallet.dart';
import 'package:go_car/features/passenger/Wallet/card_details_screen.dart';
import 'package:go_car/features/passenger/Wallet/card_transactions.dart';
import 'package:go_car/features/passenger/Wallet/customer_cards_screen.dart';
import 'package:go_car/features/passenger/Wallet/no_saved_card_screen.dart';
import 'package:go_car/features/passenger/Wallet/ride_details.dart';
import 'package:go_car/features/passenger/home/views/add_new_card.dart';
import 'package:go_car/features/passenger/home/views/find_driver.dart';
import 'package:go_car/features/passenger/home/views/payment_method.dart';
import 'package:go_car/features/passenger/home/views/show_price.dart';
import 'package:go_car/features/passenger/profile/cubit/client_profile_cubit.dart';
import 'package:go_car/features/passenger/profile/repository/client_profile_repository.dart';
import 'package:go_car/features/passenger/profile/views/edit_profile_screen.dart';
import 'package:go_car/features/passenger/profile/views/history.dart';
import 'package:go_car/features/passenger/profile/views/no_history_screen.dart';
import 'package:go_car/features/passenger/profile/views/points_screen.dart';
import 'package:go_car/features/passenger/profile/views/profile_screen.dart';
import 'package:go_car/features/passenger/profile/views/reviews.dart';
import 'package:go_car/features/passenger/profile/views/settings_screen.dart';
import 'package:go_car/features/passenger/profile/views/support_screen.dart';

import '../../features/common/auth/forget_password/views/change_password.dart';
import '../../features/common/auth/forget_password/views/forget_password.dart';
import '../../features/common/auth/forget_password/views/forget_password_mobile_number.dart';
import '../../features/common/auth/sign_up/views/congratulations_screen.dart';
import '../../features/common/auth/sign_up/views/phone_number_otp.dart';
import '../../features/common/auth/sign_up/views/sign_up_screen.dart';
import '../../features/driver/home/views/screens/driver_home_screen.dart';
import '../../features/driver/home/views/screens/notifications_screen.dart';
import '../../features/driver/profile/views/driver_profile.dart';
import '../../features/passenger/home/views/client_home_screen.dart';
import '../../features/passenger/home/views/notifications.dart';
import '../../features/passenger/home/views/rating.dart';
import '../../features/passenger/home/views/ride_ended.dart';
import '../../features/passenger/onboarding/onboarding_screen.dart';
import '../../features/passenger/schedule_ride/views/passenger_schedule_ride.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case Routes.onboarding:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());

      case Routes.driverOnboarding:
        return MaterialPageRoute(builder: (_) => DriverOnboardingScreen());

      case Routes.login:
        return MaterialPageRoute(builder: (_) => LoginScreen(isDriver: true));

      case Routes.driverProfile:
        return MaterialPageRoute(builder: (_) => DriverProfile());
      //  DriverProfile());

      case Routes.home:
        return MaterialPageRoute(builder: (_) => ClientHomeScreen());

      case Routes.driverHome:
        return MaterialPageRoute(builder: (_) => DriverHomeScreen(false));

      case Routes.signUp:
        return MaterialPageRoute(builder: (_) => SignUpScreen());

      case Routes.driversignUp:
        return MaterialPageRoute(builder: (_) => DriverSignUpScreen());

      case Routes.phoneNumberOtp:
        return MaterialPageRoute(builder: (_) => PhoneNumberOtp());

      case Routes.congratulationsScreen:
        return MaterialPageRoute(builder: (_) => CongratulationsScreen());

      case Routes.driverCongratulations:
        return MaterialPageRoute(builder: (_) => DriverCongratulationsScreen());

      case Routes.forgetPassword:
        return MaterialPageRoute(builder: (_) => ForgetPasswordMobileNumber());

      case Routes.otpPassword:
        return MaterialPageRoute(builder: (_) => ForgetPassword());

      case Routes.changePassword:
        return MaterialPageRoute(builder: (_) => ChangePassword());

      case Routes.passengerScheduleRide:
        return MaterialPageRoute(builder: (_) => PassengerScheduleRide());

      case Routes.noSavedCardScreen:
        return MaterialPageRoute(builder: (_) => NoSavedCardScreen());

      case Routes.customerCardsScreen:
        return MaterialPageRoute(builder: (_) => CustomerCardsScreen());

      case Routes.cardDetailsScreen:
        return MaterialPageRoute(builder: (_) => CardDetailsScreen());

      case Routes.cardTransactions:
        return MaterialPageRoute(builder: (_) => CardTransactions());

      case Routes.rideDetails:
        return MaterialPageRoute(builder: (_) => RideDetails());

      case Routes.ride:
        return MaterialPageRoute(builder: (_) => DriverRideScreen());

      case Routes.notifications:
        return MaterialPageRoute(builder: (_) => NotificationsScreen());

      case Routes.clientNotifications:
        return MaterialPageRoute(builder: (_) => ClientNotifications());

      case Routes.scheduled:
        return MaterialPageRoute(builder: (_) => ScheduledRideDetails());

      case Routes.congrats:
        return MaterialPageRoute(builder: (_) => Congrats());

      case Routes.profileScreen:
        return MaterialPageRoute(builder: (_)=>ProfileScreen());

      case Routes.noHistoryScreen:
        return MaterialPageRoute(builder: (_) => NoHistoryScreen());

      case Routes.historyScreen:
        return MaterialPageRoute(builder: (_) => HistoryScreen());

      case Routes.driverHistory:
        return MaterialPageRoute(builder: (_) => DriverHistory());

      case Routes.reviewsScreen:
        return MaterialPageRoute(builder: (_) => ReviewsScreen());

      case Routes.supportScreen:
        return MaterialPageRoute(builder: (_) => SupportScreen());

      case Routes.editProfileScreen:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());

      case Routes.drivereditProfileScreen:
        return MaterialPageRoute(builder: (_) => DriverEditProfileScreen());

      case Routes.settingsScreen:
        return MaterialPageRoute(builder: (_) => SettingsScreen());

      case Routes.driversettingsScreen:
        return MaterialPageRoute(builder: (_) => DriverSettingsScreen());

      case Routes.addNewCard:
        return MaterialPageRoute(builder: (_) => AddNewCard());

      case Routes.rating:
        return MaterialPageRoute(builder: (_) => Rating());

      case Routes.rideEnded:
        return MaterialPageRoute(builder: (_) => RideEnded());

      case Routes.showPrice:
        return MaterialPageRoute(builder: (_) => ShowPrice());

      case Routes.driverWallet:
        return MaterialPageRoute(builder: (_) => DriverWallet());

      case Routes.findDriver:
        return MaterialPageRoute(builder: (_) => FindDriver());

      case Routes.driverReviews:
        return MaterialPageRoute(builder: (_) => DriverReviews());

      case Routes.paymentMethod:
        return MaterialPageRoute(builder: (_) => PaymentMethod());

      default:
        // Unknown route
        return MaterialPageRoute(
          builder:
              (_) => Scaffold(
                body: Center(
                  child: Text('No route defined for ${settings.name}'),
                ),
              ),
        );
    }
  }
}
