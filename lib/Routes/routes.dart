// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smarthome/Core/Constant/string.dart';
import 'package:smarthome/Screens/Authentication/Auth_With_Number/auth_number.dart';
import 'package:smarthome/Screens/Authentication/Auth_With_Number/otp_verification.dart';
import 'package:smarthome/Screens/User/Homepage/homepage.dart';

import '../Screens/Authentication/Auth_With_Email/signinpage.dart';
import '../Screens/Authentication/Auth_With_Email/signuppage.dart';
import '../Screens/Splash/onboardingscreen.dart';
import '../Screens/Splash/splashscreen.dart';

class Routes {
  late int initScreen;
  Future<void> checkForOnBordScreen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    initScreen = prefs.getInt("initScreen")!;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      //splash screens
      case splashScreenRoute:
        return MaterialPageRoute(builder: (context) => const SplashScreen());

      case onboardingScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const OnboardingScreen());

      // authentication screens
      case singInScreenRoute:
        return MaterialPageRoute(builder: (context) => const SignInpage());

      case signUpScreenRoute:
        return MaterialPageRoute(builder: (context) => const SignupPage());

      case NumberauthScreenRoute:
        return MaterialPageRoute(builder: (context) => const NumberAuth());

      case otpverificationScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const OtpVerificationPage());

      // main screens
      case homepageScreenRoute:
        return MaterialPageRoute(builder: (context) => const Homepage());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
