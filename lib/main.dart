import 'package:flutter/material.dart';
import 'package:repetapp/route_generator.dart';
import 'utilities/constants.dart';

void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 16.0,
            color: kPrimaryColor,
            fontWeight: FontWeight.w500,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
      ),
      initialRoute: 'MainScreen',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
