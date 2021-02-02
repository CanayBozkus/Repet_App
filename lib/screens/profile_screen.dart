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
        reverseColor: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){},
            color: Colors.white,
            iconSize: 30,
          )
        ],
      ),
      body: Stack(
        children: [
          Container(
            height: 160,
            color: kPrimaryColor,
          ),
          Padding(
            padding: generalScreenPadding,
            child: Column(
              children: [
                PetNavigator(
                  height: height,
                  width: width,
                  showDetail: false,
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    children: [
                      DefaultElevation(
                        child: Container(
                          padding: EdgeInsets.symmetric(vertical: 8),
                          alignment: Alignment.center,
                          child: Text(
                            'General',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w800
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 5,
      ),
    );
  }
}
