import 'package:flutter/material.dart';
import 'package:repetapp/screens/profile_screen.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({String title, BuildContext context})
      : super(
          leading: Container(),
          title: Text(title),
        );
}
