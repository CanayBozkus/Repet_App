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
  3:LeaderBoardScreen.routeName,
  4:ForumScreen.routeName,
  5:ProfileScreen.routeName,
};

const bottomNavigationBarIcons = {
  1: 'assets/icons/home.svg',
  2: 'assets/icons/calendar.svg',
  3: 'assets/icons/trophy.svg',
  4: 'assets/icons/forum.svg',
  5: 'assets/icons/account.svg',
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
  pet,
}

enum Remainders {
  feeding,
  water,
  playing,
  grooming,
  walking,
}

const remainderSvgColors = {
  Remainders.feeding: Color(0xfff87024),
  Remainders.grooming: Color(0xff883404),
  Remainders.playing: Color(0xff79c624),
  Remainders.walking: Color(0xff79c619),
  Remainders.water: Color(0xff04a3ff),
};

const remainderIcons = {
  Remainders.feeding: 'assets/icons/feeding.svg',
  Remainders.grooming: 'assets/icons/grooming.svg',
  Remainders.playing: 'assets/icons/playing.svg',
  Remainders.walking: 'assets/icons/walking.svg',
  Remainders.water: 'assets/icons/water.svg',
};

const remainderTitles = {
  Remainders.feeding: 'Feeding',
  Remainders.grooming: 'Grooming',
  Remainders.playing: 'Playing',
  Remainders.walking: 'Walking',
  Remainders.water: 'Water',
};

const kPrimaryColor = Color(0xFFFDA15A);
const kColorRed = Color(0xffef1111);
const kColorGreen = Color(0xff79c624);
const kGreyTextColor = Color(0xff636363);
const kColorBlue = Color(0xff32a7f2);

const generalScreenPadding = EdgeInsets.symmetric(horizontal: 20);

enum ForumCategories {
  food,
  care,
  training,
  social,
}

const kForumCategoryTitles = {
  ForumCategories.care : 'Care',
  ForumCategories.food: 'Food',
  ForumCategories.social: 'Social',
  ForumCategories.training: 'Training',
};

const kBlogPageCategoryImages = {
  ForumCategories.food: 'assets/icons/bowl.svg',
  ForumCategories.care: 'assets/icons/hand-heart.svg',
  ForumCategories.training: 'assets/icons/school.svg',
  ForumCategories.social: 'assets/icons/heart-multiple.svg',
};

const kBlogPageCategoryColors = {
  ForumCategories.food: Color(0xfffd3c1d),
  ForumCategories.care: Color(0xff5adb78),
  ForumCategories.training: Color(0xff2f6cf5),
  ForumCategories.social: Color(0xfffda15a),
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

const vaccines = [
  'İç Parazit',
  'Dış Parazit',
  'Kuduz Aşısı',
  'Borrelia Burgdorferi',
  'Parainfluenza Aşısı',
  'Coronavirus',
  'Leptospirozis Aşısı',
  'Bordatella Bronchiceptica Aşısı',
  'Mantar Aşısı',
  'Karma',
  'Bronşin Aşısı',
  'Lyme Aşısı',
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
    color: kGreyTextColor,
    fontWeight: FontWeight.w700
);

const kSettingsInputLabelStyle = TextStyle(
  fontSize: 16,
  color: kGreyTextColor,
  fontWeight: FontWeight.w700,
);
