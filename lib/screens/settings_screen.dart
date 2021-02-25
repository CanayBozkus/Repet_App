import 'package:flutter/material.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';


class SettingsScreen extends StatelessWidget {
  static const routeName = 'SettingsScreen';
  Map settingsWidgetParams;
  SettingsScreen({@required this.settingsWidgetParams});
  String appbarTitle;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        activeBackButton: true,
        title: settingsWidgetParams['title'],
        context: context,
        reverseColor: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: settingsWidgetParams['widget'],
      ),
      bottomNavigationBar: BaseBottomBar(
        pageNumber: 5,
      ),
    );
  }
}




