import 'package:flutter/material.dart';
import 'package:repetapp/screens/profile_screen.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({String title, BuildContext context})
      : super(
          title: Text(title),
          actions: [
            IconButton(
              icon: Icon(
                Icons.menu,
              ),
              onPressed: () {
                Navigator.pushNamed(context, ProfileScreen.routeName);
              },
            ),
            SizedBox(
              width: 15.0,
            ),
          ],
        );
}
