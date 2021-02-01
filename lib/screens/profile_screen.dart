import 'package:flutter/material.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/widgets/pet_navigator.dart';
import 'package:repetapp/widgets/shadow_divider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = 'ProfileScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Profile',
        context: context,
      ),
      body: Column(
        children: [
          PetNavigator(
            height: height,
            width: width,
            showDetail: true,
          ),
          SizedBox(height: height*0.04,),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 8),
              children: [
                ShadowDivider(),
                DefaultElevation(
                  child: Column(
                    children: [
                      ListTile(
                        contentPadding: EdgeInsets.only(left: width*0.1, right: width*0.05),
                        title: Text(
                          'Kişisel Bilgiler',
                          style: kProfileBuilderTextStyle,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                      ),
                      Divider(height: 3, color: Colors.grey.shade600,),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: width*0.1, right: width*0.05),
                        title: Text('Adreslerim',
                          style: kProfileBuilderTextStyle,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                      ),
                      Divider(height: 3, color: Colors.grey.shade600,),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: width*0.1, right: width*0.05),
                        title: Text('Ödeme Yöntemi',
                          style: kProfileBuilderTextStyle,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                      ),
                      Divider(height: 3, color: Colors.grey.shade600,),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: width*0.1, right: width*0.05),
                        title: Text('Dil',
                          style: kProfileBuilderTextStyle,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                      ),
                      Divider(height: 3, color: Colors.grey.shade600,),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: width*0.1, right: width*0.05),
                        title: Text('Yardım',
                          style: kProfileBuilderTextStyle,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                      ),
                      Divider(height: 3, color: Colors.grey.shade600,),
                      ListTile(
                        contentPadding: EdgeInsets.only(left: width*0.1, right: width*0.05),
                        title: Text('Çıkış',
                          style: kProfileBuilderTextStyle,
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                        onTap: () async {
                          await context.read<ProvidedData>().signOut();
                          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                        },
                      ),
                    ],
                  ),
                ),
                ListTile(
                  contentPadding: EdgeInsets.only(left: width*0.1, right: width*0.05),
                  title: Text('Versiyon 1.0.0',
                    style: kProfileBuilderTextStyle.copyWith(color: Colors.grey.shade400),
                  ),
                ),
                Divider(height: 3, color: Colors.grey.shade400,),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
      ),
    );
  }
}
