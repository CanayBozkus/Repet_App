import 'package:flutter/material.dart';
import 'package:repetapp/route_generator.dart';
import 'utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser != null){
      return true;
    }
    return false;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        textTheme: TextTheme(
          bodyText2: TextStyle(
            fontSize: 16.0,
            color: Color(0xFF6f6f6f),
            fontWeight: FontWeight.w600,
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
      initialRoute: isLoggedIn() ? 'MainScreen' : 'LoginScreen',
      onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
