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
const kColorRed = Color(0xffef1111);
const kColorGreen = Color(0xff79c624);

const generalScreenPadding = EdgeInsets.symmetric(horizontal: 20);

const kBlogPageCategoryImages = {
  'Food': 'assets/icons/bowl.svg',
  'Care': 'assets/icons/hand-heart.svg',
  'Training': 'assets/icons/school.svg',
  'Social': 'assets/icons/heart-multiple.svg',
};

const kBlogPageCategoryColors = {
  'Food': Color(0xfffd3c1d),
  'Care': Color(0xff5adb78),
  'Training': Color(0xff2f6cf5),
  'Social': Color(0xfffda15a),
};

enum PetTypes {
  dog,
  cat,
}

const petTypeNames = {
  PetTypes.dog: 'Dog',
  PetTypes.cat: 'Cat',
};

const petTypeNamesReverse = {
  'Dog': PetTypes.dog,
  'Cat': PetTypes.cat,
};

const petTypeImages = {
  PetTypes.dog: 'assets/icons/dog.svg',
  PetTypes.cat: 'assets/icons/cat.svg',
};

const petTypeColors = {
  PetTypes.dog: Color(0xffba892b),
  PetTypes.cat: Color(0xffe86868),
};

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
