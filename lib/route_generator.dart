import 'package:flutter/material.dart';
import 'package:repetapp/route_generator.dart';
import 'package:repetapp/screens/calendar_screen.dart';
import 'package:repetapp/screens/error_screen.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/screens/main_screen.dart';
import 'package:repetapp/screens/registration_screen.dart';
import 'package:repetapp/screens/training_detail_screen.dart';
import 'package:repetapp/screens/training_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name) {
      case LoginScreen.routeName: return MaterialPageRoute(builder: (_) => LoginScreen());
      case RegistrationScreen.routeName: return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case MainScreen.routeName: return MaterialPageRoute(builder: (_) => MainScreen());
      case CalendarScreen.routeName: return MaterialPageRoute(builder: (_) => CalendarScreen());
      case TrainingScreen.routeName: return MaterialPageRoute(builder: (_) => TrainingScreen());
      case TrainingDetailScreen.routeName: return MaterialPageRoute(builder: (_) => TrainingDetailScreen());
      case LoginScreen.routeName: return MaterialPageRoute(builder: (_) => LoginScreen());
      case RegistrationScreen.routeName: return MaterialPageRoute(builder: (_) => RegistrationScreen());
      default: return MaterialPageRoute(builder: (_) => ErrorScreen());
    }
  }
}
