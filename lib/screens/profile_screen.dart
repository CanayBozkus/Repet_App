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
import 'package:flutter_svg/flutter_svg.dart';

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
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.add,
          color: kPrimaryColor,
          size: 45,
        ),
        backgroundColor: Colors.white,
        onPressed: (){},
      ),
      body: Stack(
        children: [
          Container(
            height: 160,
            color: kPrimaryColor,
          ),
          Column(
            children: [
              Padding(
                padding: generalScreenPadding,
                child: PetNavigator(
                  height: height,
                  width: width,
                  showDetail: false,
                ),
              ),
              SizedBox(height: 10,),
              Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  children: [
                    Padding(
                      padding: generalScreenPadding,
                      child: Column(
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
                          DefaultElevation(
                            child: ListTile(
                              leading: SvgPicture.asset(
                                'assets/icons/dog.svg',
                                height: 30,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                'Rıfkı',
                                style: TextStyle(
                                  fontWeight: FontWeight.w500
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          DefaultElevation(
                            child: ListTile(
                              leading: SvgPicture.asset(
                                'assets/icons/species.svg',
                                height: 30,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                'Pug',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          DefaultElevation(
                            child: ListTile(
                              leading: SvgPicture.asset(
                                'assets/icons/gender.svg',
                                height: 25,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                'Male',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          DefaultElevation(
                            child: ListTile(
                              leading: SvgPicture.asset(
                                'assets/icons/weight.svg',
                                height: 25,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                '9.5 kg',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          DefaultElevation(
                            child: ListTile(
                              leading: SvgPicture.asset(
                                'assets/icons/cake.svg',
                                height: 30,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                '1 year 8 month',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          DefaultElevation(
                            child: ListTile(
                              leading: SvgPicture.asset(
                                'assets/icons/height.svg',
                                height: 30,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                '123 cm',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          DefaultElevation(
                            child: ListTile(
                              leading: SvgPicture.asset(
                                'assets/icons/peanut.svg',
                                height: 30,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                'Alerji',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                          DefaultElevation(
                            child: ListTile(
                              leading: SvgPicture.asset(
                                'assets/icons/wheelchair.svg',
                                height: 30,
                                color: kPrimaryColor,
                              ),
                              title: Text(
                                'Engel',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                              trailing: Icon(Icons.arrow_forward_ios),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 40,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          'Training',
                          style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 4,
                            blurRadius: 3,
                            offset: Offset(0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          'Diseases',
                          style: TextStyle(
                              fontWeight: FontWeight.w500
                          ),
                        ),
                        trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                      ),
                    ),
                    SizedBox(height: 50,),
                  ],
                ),
              ),
            ],
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
