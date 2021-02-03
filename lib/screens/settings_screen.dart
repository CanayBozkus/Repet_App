import 'package:flutter/material.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  static const routeName = 'SettingsScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: BaseAppBar(
        activeBackButton: true,
        title: 'Settings',
        context: context,
        reverseColor: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 30),
        child: ListView(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, -2), // changes position of shadow
                  ),
                ],
              ),
              child: Column(
                children: [
                  DefaultElevation(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 40, right: 10),
                      title: Text(
                        'Kişisel Bilgiler',
                        style: kProfileBuilderTextStyle,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                      onTap: (){},
                    ),
                  ),
                  DefaultElevation(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 40, right: 10),
                      title: Text(
                        'Adreslerim',
                        style: kProfileBuilderTextStyle,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                      onTap: (){},
                    ),
                  ),
                  DefaultElevation(
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
                  DefaultElevation(
                    child: ListTile(
                      contentPadding: EdgeInsets.only(left: 40, right: 10),
                      title: Text(
                        'Yardım',
                        style: kProfileBuilderTextStyle,
                      ),
                      trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                      onTap: (){},
                    ),
                  ),
                  DefaultElevation(
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
                  DefaultElevation(
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
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 5,
      ),
    );
  }
}
