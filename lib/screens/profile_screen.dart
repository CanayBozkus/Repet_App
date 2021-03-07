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
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repetapp/widgets/pet_settings.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = 'ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FormGenerator _formGenerator = FormGenerator();

  final List expansionPanelExpansionValues = [false, false];

  @override
  Widget build(BuildContext context) {
    PetModel currentPet = context.watch<GeneralProviderData>().pets[context.watch<GeneralProviderData>().currentShownPetIndex];
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
          Navigator.pushNamed(context, PetRegistrationScreen.routeName, arguments: context.read<GeneralProviderData>().currentUser);
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
                                  BaseShadow(
                                    child: ExpansionPanelList(
                                      elevation: 0,
                                      dividerColor: Colors.grey.shade400,
                                      expandedHeaderPadding: EdgeInsets.zero,
                                      expansionCallback: (int index, bool isExpanded){
                                        setState(() {
                                          expansionPanelExpansionValues[index] = !expansionPanelExpansionValues[index];
                                        });
                                      },
                                      children: [
                                        ExpansionPanel(
                                          isExpanded: expansionPanelExpansionValues[0],
                                          canTapOnHeader: true,
                                          headerBuilder: (BuildContext context, bool isExpanded) {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(18.0),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/peanut.svg',
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  'Allergy',
                                                  style: kSettingsInputLabelStyle,
                                                )
                                              ],
                                            );
                                          },
                                          body: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ...currentPet.allergies.map((e){
                                                  return Container(
                                                    margin: EdgeInsets.symmetric(vertical: 5),
                                                    child: Text(
                                                      e,
                                                      style: kSettingsInputLabelStyle,
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  );
                                                }).toList(),
                                              ],
                                            ),
                                          ),
                                        ),
                                        ExpansionPanel(
                                          isExpanded: expansionPanelExpansionValues[1],
                                          canTapOnHeader: true,
                                          headerBuilder: (BuildContext context, bool isExpanded) {
                                            return Row(
                                              children: [
                                                Padding(
                                                  padding: EdgeInsets.all(14.0),
                                                  child: SvgPicture.asset(
                                                    'assets/icons/wheelchair.svg',
                                                    color: kPrimaryColor,
                                                  ),
                                                ),
                                                Text(
                                                  'Disability',
                                                  style: kSettingsInputLabelStyle,
                                                )
                                              ],
                                            );
                                          },
                                          body: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(horizontal: 20),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ...currentPet.disabilities.map((e){
                                                  return Container(
                                                    margin: EdgeInsets.symmetric(vertical: 5),
                                                    child: Text(
                                                      e,
                                                      style: kSettingsInputLabelStyle,
                                                      textAlign: TextAlign.start,
                                                    ),
                                                  );
                                                }).toList(),
                                              ],
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
        pageNumber: 5,
      ),
    );
  }
}
