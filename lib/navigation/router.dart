import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:maosul/helper/app_styles.dart';
import 'package:maosul/helper/route_argument.dart';
import 'package:maosul/messaging/ChatScreen.dart';
import 'package:maosul/screens/home.dart';
import 'package:maosul/screens/login.dart';
import 'package:maosul/screens/otp_verify.dart';
import 'package:maosul/screens/register.dart';
import 'package:maosul/screens/splash.dart';

import 'route_paths.dart' as routes;

Route<dynamic> generateRoute(RouteSettings settings) {
  final args = settings.arguments;
  print("###############\t settings.argument \t ###############");
  print(args);
  print("###############\t settings.argumentr \t ###############");
  switch (settings.name) {
    case routes.SplashRoute:
      return MaterialPageRoute(
        builder: (_) => Splash(),
      );
    case routes.LoginRoute:
      return MaterialPageRoute(
        builder: (_) => Login(),
      );

    case routes.RegisterRoute:
      print(settings.name);
      return MaterialPageRoute(
        builder: (_) => Register(),
      );
    case routes.OtpVerifyRoute:
      print(settings.name);
      return MaterialPageRoute(
        builder: (_) => OtpVerify(
          routeArgument: RouteArgument(param: args),
        ),
      );
    case routes.ChatScreenRoute:
      print(settings.name);
      return MaterialPageRoute(
        builder: (_) => ChatScreen(
          routeArgument: RouteArgument(param: args),
        ),
      );
    case routes.HomeRoute:
      print(settings.name);
      return MaterialPageRoute(
        builder: (_) => Home(
          routeArgument: RouteArgument(param: AppStyles.appArName),
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => Home(
          routeArgument: RouteArgument(param: AppStyles.appArName),
        ),
      );
  }
}
