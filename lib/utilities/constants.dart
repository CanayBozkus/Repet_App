import 'package:flutter/material.dart';
import 'package:repetapp/screens/calendar_screen.dart';
import 'package:repetapp/screens/leaderboard_screen.dart';
import 'package:repetapp/screens/main_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repetapp/screens/training_screen.dart';

const bottomNavigationBarRoutes = {
  1:MainScreen.routeName,
  2:CalendarScreen.routeName,
  3:LeaderBoardScreen.routename,
  4:null,
  5:TrainingScreen.routeName,
};

const bottomNavigationBarIcons = {
  1:Icons.home_outlined,
  2:Icons.date_range,
  3:FontAwesomeIcons.trophy,
  4:Icons.messenger_rounded,
  5:Icons.school,
};

enum TrainingStatus {
  repeat,
  done,
  notStarted,
}

const kPrimaryColor = Color(0xFFFDA15A);

const kTextFieldDecoration = InputDecoration(
  labelText: 'Email',
  labelStyle: TextStyle(
    color: Color(0xffd0d0d0),
    fontWeight: FontWeight.w500,
    fontSize: 18.0,
  ),
  border: InputBorder.none,
  filled: true,
  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.mail_outline,
  ),
);

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
