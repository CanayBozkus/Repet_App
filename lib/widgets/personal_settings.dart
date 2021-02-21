import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/base_button.dart';

class PersonalSettings extends StatefulWidget {
  @override
  _PersonalSettingsState createState() => _PersonalSettingsState();
}

class _PersonalSettingsState extends State<PersonalSettings> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

  bool isActive = false;

  @override
  Widget build(BuildContext context) {
    UserModel user = context.watch<ProvidedData>().currentUser;
    return Container(
      child: Column(
        children: [
          Container(
            height: 140,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  child: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    height: 70,
                  ),
                  radius: 35,
                ),
                SizedBox(width: 20,),
                Text(
                  user.nameSurname,
                  style: TextStyle(
                    fontSize: 26,
                    color: Color(0xff636363),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  FormGenerator.settingsPageInput(
                    label: user.nameSurname,
                    svg: 'assets/icons/account.svg',
                    onChanged: (String value){
                      if(value.isNotEmpty){
                        setState(() {
                          isActive = true;
                        });
                      }
                      else {
                        setState(() {
                          isActive = false;
                        });
                      }
                    },
                    validator: FormGenerator.nameValidatorGenerator('a valid')
                  ),
                  FormGenerator.settingsPageInput(
                    label: user.email,
                    svg: 'assets/icons/email.svg',
                    onChanged: (String value){
                      if(value.isNotEmpty){
                        setState(() {
                          isActive = true;
                        });
                      }
                      else {
                        setState(() {
                          isActive = false;
                        });
                      }
                    },
                    validator: FormGenerator.mailValidator,
                  ),
                  FormGenerator.settingsPageInput(
                    label: user.phoneNumber == null ? 'Phone Number' : user.phoneNumber.toString(),
                    keyboardType: KeyboardTypes.number,
                    svg: 'assets/icons/cellphone.svg',
                    onChanged: (String value){
                      if(value.isNotEmpty){
                        setState(() {
                          isActive = true;
                        });
                      }
                      else {
                        setState(() {
                          isActive = false;
                        });
                      }
                    }
                  ),
                  FormGenerator.settingsPageInput(
                    label: user.age.toString(),
                    svg: 'assets/icons/cake.svg',
                    keyboardType: KeyboardTypes.number,
                    onChanged: (String value){
                      if(value.isNotEmpty){
                        setState(() {
                          isActive = true;
                        });
                      }
                      else {
                        setState(() {
                          isActive = false;
                        });
                      }
                    },
                  ),
                  FormGenerator.settingsPageDropdown(
                    categories: ['Male', 'Female'],
                    hint: user.gender,
                    svg: 'assets/icons/gender.svg',
                    onChanged: (value) {
                      if(value.isNotEmpty){
                        setState(() {
                          isActive = true;
                        });
                      }
                      else {
                        setState(() {
                          isActive = false;
                        });
                      }
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please select a gender!';
                      }
                    },
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: BaseButton(
                      text: 'Save',
                      width: 100,
                      onPressed: isActive ? (){

                      } : null,
                    ),
                  ),
                ],
              ),
            ),
          ),

        ],
      ),
    );
  }
}