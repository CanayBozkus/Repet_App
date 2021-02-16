import 'package:flutter/material.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/screens/settings_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';

class GeneralSettings extends StatelessWidget {
  const GeneralSettings({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30),
      child: ListView(
        children: [
          BaseShadow(
            child: Column(
              children: [
                BaseShadow(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 40, right: 10),
                    title: Text(
                      'Kişisel Bilgiler',
                      style: kProfileBuilderTextStyle,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                    onTap: (){
                      Navigator.pushNamed(context, SettingsScreen.routeName, arguments: SettingsWidget.personalSettings);
                    },
                  ),
                ),
                BaseShadow(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 40, right: 10),
                    title: Text(
                      'Adreslerim',
                      style: kProfileBuilderTextStyle,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                    onTap: (){
                      Navigator.pushNamed(context, SettingsScreen.routeName, arguments: SettingsWidget.addressSettings);
                    },
                  ),
                ),
                BaseShadow(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 40, right: 10),
                    title: Text(
                      'Ödeme Yöntemi',
                      style: kProfileBuilderTextStyle,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                    onTap: (){},
                  ),
                ),
                BaseShadow(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 40, right: 10),
                    title: Text(
                      'Yardım',
                      style: kProfileBuilderTextStyle,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                    onTap: (){
                      Navigator.pushNamed(context, SettingsScreen.routeName, arguments: SettingsWidget.help);
                    },
                  ),
                ),
                BaseShadow(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 40, right: 10),
                    title: Text(
                      'Dil - Türkçe',
                      style: kProfileBuilderTextStyle,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                    onTap: (){},
                  ),
                ),
                BaseShadow(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 40, right: 10),
                    title: Text(
                      'Çıkış',
                      style: kProfileBuilderTextStyle,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                    onTap:  () async {
                      await context.read<ProvidedData>().signOut();
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    },
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 15,),
        ],
      ),
    );
  }
}