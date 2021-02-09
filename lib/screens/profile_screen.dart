import 'package:flutter/material.dart';
import 'package:repetapp/screens/pet_registration_screen.dart';
import 'package:repetapp/screens/settings_screen.dart';
import 'package:repetapp/screens/training_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/widgets/pet_navigator.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = 'ProfileScreen';
  final FormGenerator _formGenerator = FormGenerator();
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
            onPressed: (){
              Navigator.pushNamed(context, SettingsScreen.routeName, arguments: SettingsWidget.generalSettings);
            },
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
        onPressed: (){
          Navigator.pushNamed(context, PetRegistrationScreen.routeName, arguments: context.read<ProvidedData>().currentUser);
        },
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Stack(
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
                    showDetail: false,
                  ),
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.symmetric(vertical: 5),
                    children: [
                      Form(
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              child: Stack(
                                children: [
                                  Padding(
                                    padding: generalScreenPadding.add(EdgeInsets.only(top: 8)),
                                    child: DefaultElevation(
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
                                  ),
                                  Positioned(
                                    right: 8,
                                    child: Material(
                                      elevation: 5,
                                      child: Container(
                                        width: 60,
                                        height: 40,
                                        child: FlatButton(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          onPressed: (){
                                          },
                                          padding: EdgeInsets.zero,
                                          child: Icon(FontAwesomeIcons.solidEdit, size: 24,),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: generalScreenPadding,
                              child: Column(
                                children: [
                                  _formGenerator.settingsPageInput(label: 'Rıfkı', svg: 'assets/icons/dog.svg', isEnabled: false),
                                  _formGenerator.settingsPageInput(label: 'Pug', svg: 'assets/icons/species.svg', isEnabled: false),
                                  _formGenerator.settingsPageInput(label: 'Male', svg: 'assets/icons/gender.svg', isEnabled: false),
                                  _formGenerator.settingsPageInput(label: '9.5 kg', svg: 'assets/icons/weight.svg', isEnabled: false),
                                  _formGenerator.settingsPageInput(label: '1 year 8 month', svg: 'assets/icons/cake.svg', isEnabled: false),
                                  _formGenerator.settingsPageInput(label: '123 cm', svg: 'assets/icons/height.svg', isEnabled: false),
                                  _formGenerator.settingsPageInput(label: 'Alerji', svg: 'assets/icons/peanut.svg', isEnabled: false),
                                  _formGenerator.settingsPageInput(label: 'Engel', svg: 'assets/icons/wheelchair.svg', isEnabled: false),
                                ],
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
                          onTap: (){
                            Navigator.pushNamed(context, TrainingScreen.routeName);
                          },
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
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 5,
      ),
    );
  }
}
