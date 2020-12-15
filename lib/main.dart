import 'package:flutter/material.dart';
import 'package:repetapp/route_generator.dart';
import 'utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  void initialize() async {
    await Firebase.initializeApp();
  }
  @override
  Widget build(BuildContext context) {
    initialize();
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 16.0,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(
            color: kPrimaryColor,
            size: 28
          ),
          textTheme: TextTheme(
            headline6: TextStyle(
              color: kPrimaryColor,
              fontSize: 20.0,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      initialRoute: 'RegistrationScreen',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
