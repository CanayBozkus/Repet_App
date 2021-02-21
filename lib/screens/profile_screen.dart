import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/screens/pet_registration_screen.dart';
import 'package:repetapp/screens/settings_screen.dart';
import 'package:repetapp/screens/training_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:repetapp/widgets/general_settings.dart';
import 'package:repetapp/widgets/pet_navigator.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repetapp/widgets/pet_settings.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = 'ProfileScreen';
  final FormGenerator _formGenerator = FormGenerator();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    PetModel currentPet = context.watch<ProvidedData>().pets[context.watch<ProvidedData>().currentShownPetIndex];
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Profile',
        context: context,
        reverseColor: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.pushNamed(context, SettingsScreen.routeName, arguments:  {
                'title': 'Settings',
                'widget': GeneralSettings(),
              });
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
                                    child: BaseShadow(
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
                                    child: BaseShadow(
                                      child: Container(
                                        width: 60,
                                        height: 40,
                                        child: FlatButton(
                                          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          onPressed: (){
                                            Navigator.pushNamed(context, SettingsScreen.routeName, arguments:  {
                                              'title': 'Profile',
                                              'widget': PetSettings(),
                                            });
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
                                  FormGenerator.settingsPageInput(label: currentPet.name, svg: 'assets/icons/dog.svg', isEnabled: false),
                                  FormGenerator.settingsPageInput(label: currentPet.species, svg: 'assets/icons/species.svg', isEnabled: false),
                                  FormGenerator.settingsPageInput(label: currentPet.gender, svg: 'assets/icons/gender.svg', isEnabled: false),
                                  FormGenerator.settingsPageInput(label: '${currentPet.weight} kg', svg: 'assets/icons/weight.svg', isEnabled: false),
                                  FormGenerator.settingsPageInput(label: '${currentPet.year} year ${currentPet.month} month', svg: 'assets/icons/cake.svg', isEnabled: false),
                                  FormGenerator.settingsPageInput(label: '${currentPet.height} m', svg: 'assets/icons/height.svg', isEnabled: false),
                                  FormGenerator.settingsPageInput(label: 'Alerji', svg: 'assets/icons/peanut.svg', isEnabled: false),
                                  FormGenerator.settingsPageInput(label: 'Engel', svg: 'assets/icons/wheelchair.svg', isEnabled: false),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 40,),
                      BaseShadow(
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
                      BaseShadow(
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
        width: width,
        pageNumber: 5,
      ),
    );
  }
}
