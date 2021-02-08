import 'package:flutter/material.dart';
import 'package:repetapp/screens/calendar_screen.dart';
import 'package:repetapp/screens/forum_screen.dart';
import 'package:repetapp/screens/leaderboard_screen.dart';
import 'package:repetapp/screens/main_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repetapp/screens/profile_screen.dart';
import 'package:repetapp/screens/training_screen.dart';

const bottomNavigationBarRoutes = {
  1:MainScreen.routeName,
  2:CalendarScreen.routeName,
  3:LeaderBoardScreen.routename,
  4:ForumScreen.routeName,
  5:ProfileScreen.routeName,
};

const bottomNavigationBarIcons = {
  1:Icons.home_outlined,
  2:Icons.date_range,
  3:FontAwesomeIcons.trophy,
  4:Icons.messenger_rounded,
  5:FontAwesomeIcons.userAlt,
};

enum TrainingStatus {
  repeat,
  done,
  notStarted,
}

enum KeyboardTypes {
  emailAddress,
  number,
  text,
}

const keyBoards = {
  KeyboardTypes.emailAddress: TextInputType.emailAddress,
  KeyboardTypes.text: TextInputType.text,
  KeyboardTypes.number: TextInputType.number,
};

enum SettingsWidget {
  generalSettings,
  personalSettings,
  addressSettings,
  help,
}

const kPrimaryColor = Color(0xFFFDA15A);

const generalScreenPadding = EdgeInsets.symmetric(horizontal: 20);

const allergies = [
  'Kaşıntılı cilt',
  'Hapşırma',
  'Deri Döküntüleri',
  'Pullu veya yağlı cilt',
  'Pigmentli Cilt',
  'Göz Akıntısı',
];

const disabilities = [
  'Körlük',
  'Sağırlık',
  'Felç',
  'Epilepsi',
  'Astım',
  'Nöbetler',
];

const kTextFieldLabelStyle = TextStyle(
  color: kPrimaryColor,
);

const kDefaultTextStyle = TextStyle(
  fontSize: 16.0,
  color: kPrimaryColor,
  fontWeight: FontWeight.w500,
);

const kProfileBuilderTextStyle = TextStyle(
    color: Color(0xff636363),
    fontWeight: FontWeight.w700
);
