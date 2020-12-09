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
      initialRoute: 'MainScreen',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
