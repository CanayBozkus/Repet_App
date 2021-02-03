import 'package:flutter/material.dart';
import 'package:repetapp/screens/profile_screen.dart';
import 'package:repetapp/utilities/constants.dart';

class BaseAppBar extends AppBar {
  BaseAppBar({@required String title, @required BuildContext context, List<Widget> actions, bool reverseColor = false, bool activeBackButton = false})
      : super(
          leading: activeBackButton ? null : Container(),
          title: Text(
            title,
            style: Theme.of(context).appBarTheme.textTheme.headline6.copyWith(color: reverseColor ? Colors.white : kPrimaryColor),
          ),
          actions: actions,
          backgroundColor: reverseColor ? kPrimaryColor : Colors.white,
          iconTheme: IconThemeData(
              color: reverseColor ? Colors.white : kPrimaryColor,
              size: 28
          ),
        );
}
