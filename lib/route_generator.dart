import 'package:flutter/material.dart';
import 'package:repetapp/route_generator.dart';
import 'package:repetapp/screens/calendar_screen.dart';
import 'package:repetapp/screens/error_screen.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/screens/main_screen.dart';
import 'package:repetapp/screens/registration_screen.dart';
import 'package:repetapp/screens/training_screen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings){
    final args = settings.arguments;

    switch(settings.name) {
      case 'LoginScreen': return MaterialPageRoute(builder: (_) => LoginScreen());
      case 'RegistrationScreen': return MaterialPageRoute(builder: (_) => RegistrationScreen());
      case 'MainScreen': return MaterialPageRoute(builder: (_) => MainScreen());
      case 'CalendarScreen': return MaterialPageRoute(builder: (_) => CalendarScreen());
      case 'TrainingScreen': return MaterialPageRoute(builder: (_) => TrainingScreen());
      default: return MaterialPageRoute(builder: (_) => ErrorScreen());
    }
  }
}
