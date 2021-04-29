import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:repetapp/l10n/l10n.dart';
import 'package:repetapp/route_generator.dart';
import 'package:repetapp/services/database.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'utilities/constants.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await databaseManager.initializeDatabase();
  runApp(ProviderWrappedMyApp());
}

class ProviderWrappedMyApp extends StatelessWidget {
  final GeneralProviderData providedData = GeneralProviderData();
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => providedData,),
      ],
      child: MyApp(),
    );
  }
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
            fontWeight: FontWeight.w600,
          ),
        ),
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: Colors.white,
          elevation: 0,
          centerTitle: true,
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
      supportedLocales: L10n.all,
      locale: context.watch<GeneralProviderData>().locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
    );
  }
}
