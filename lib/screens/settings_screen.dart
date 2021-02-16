import 'package:flutter/material.dart';
import 'package:repetapp/screens/error_screen.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/address_settings.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/general_settings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/widgets/help.dart';
import 'package:repetapp/widgets/personal_settings.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = 'SettingsScreen';
  SettingsWidget settingsWidgetName;
  SettingsScreen({@required this.settingsWidgetName});
  String appbarTitle;
  Widget _selectSettingsWidget(){
    switch(settingsWidgetName){
      case SettingsWidget.generalSettings:
        appbarTitle = 'Settings';
        return GeneralSettings();
        break;
      case SettingsWidget.personalSettings:
        appbarTitle = 'Personal Info';
        return PersonalSettings();
        break;
      case SettingsWidget.addressSettings:
        appbarTitle = 'Address';
        return AddressSettings();
      case SettingsWidget.help:
        appbarTitle = 'Help';
        return Help();
      default:
        appbarTitle = 'Error';
        return ErrorScreen();
    }
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Widget selectedWidget = _selectSettingsWidget();
    return Scaffold(
      appBar: BaseAppBar(
        activeBackButton: true,
        title: appbarTitle,
        context: context,
        reverseColor: true,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: selectedWidget,
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 5,
      ),
    );
  }
}




