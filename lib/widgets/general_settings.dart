import 'package:flutter/material.dart';
import 'package:repetapp/l10n/l10n.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/screens/settings_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/address_settings.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/help.dart';
import 'package:repetapp/widgets/language_settings.dart';
import 'package:repetapp/widgets/personal_settings.dart';

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
                      Navigator.pushNamed(context, SettingsScreen.routeName, arguments:  {
                        'title': 'Personal Info',
                        'widget': PersonalSettings(),
                      });
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
                      Navigator.pushNamed(context, SettingsScreen.routeName, arguments: {
                        'title': 'Addresses',
                        'widget': AddressSettings(),
                      });
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
                      Navigator.pushNamed(context, SettingsScreen.routeName, arguments:  {
                        'title': 'Help',
                        'widget': Help(),
                      });
                    },
                  ),
                ),
                BaseShadow(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 40, right: 10),
                    title: Text(
                      'Dil - ${L10n.languages[context.watch<GeneralProviderData>().locale.toLanguageTag()]}',
                      style: kProfileBuilderTextStyle,
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                    onTap: (){
                      Navigator.pushNamed(context, SettingsScreen.routeName, arguments:  {
                        'title': 'Language',
                        'widget': LanguageSettings(),
                      });
                    },
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
                      await context.read<GeneralProviderData>().signOut();
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