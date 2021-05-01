import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/utilities/helpers.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/spinner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class PersonalSettings extends StatefulWidget {
  @override
  _PersonalSettingsState createState() => _PersonalSettingsState();
}

class _PersonalSettingsState extends State<PersonalSettings> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool isActive = false;
  bool isUpdating = false;
  Map<String, dynamic> updatedValues = {};

  void activateSaveButton(bool isNotEmpty, String key, value){
    if(isNotEmpty){
      updatedValues[key] = value;
      setState(() {
        isActive = true;
      });
    }
    else {
      updatedValues.remove(key);
      setState(() {
        isActive = updatedValues.isNotEmpty;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    UserModel user = context.watch<GeneralProviderData>().currentUser;
    AppLocalizations localized = AppLocalizations.of(context);
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
                      activateSaveButton(value.isNotEmpty, 'nameSurname', value);
                    },
                    validator: (value) {
                      if(value.contains(RegExp(r'[0-9]'))){
                        return localized.nameCannotContainNumber;
                      }
                      return null;
                    },
                  ),
                  FormGenerator.settingsPageInput(
                    label: user.email,
                    svg: 'assets/icons/email.svg',
                    onChanged: (String value){
                      activateSaveButton(value.isNotEmpty, 'email', value);
                    },
                    validator: (String value){
                      if(value.isEmpty){
                        return null;
                      }
                      if(!value.contains('@')){
                        return localized.invalidEmail;
                      }
                      return null;
                    },
                  ),
                  FormGenerator.settingsPageInput(
                    label: user.phoneNumber == null ? localized.phoneNumber : user.phoneNumber.toString(),
                    keyboardType: KeyboardTypes.number,
                    svg: 'assets/icons/cellphone.svg',
                    onChanged: (String value){
                      activateSaveButton(value.isNotEmpty, 'phoneNumber', value.isNotEmpty ? int.parse(value) : 0);
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  FormGenerator.settingsPageInput(
                    label: user.age.toString(),
                    svg: 'assets/icons/cake.svg',
                    keyboardType: KeyboardTypes.number,
                    onChanged: (String value){
                      activateSaveButton(value.isNotEmpty, 'age', value.isNotEmpty ? int.parse(value) : 0);
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  FormGenerator.settingsPageDropdown(
                    categories: [localized.male, localized.female],
                    hint: user.gender,
                    svg: 'assets/icons/gender.svg',
                    onChanged: (value) {
                      activateSaveButton(value.isNotEmpty, 'gender', value);
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: isUpdating ? Spinner() : BaseButton(
                      text: localized.save,
                      width: 100,
                      onPressed: isActive ? () async {
                        FocusScope.of(context).unfocus();
                        setState(() {
                          isUpdating = true;
                        });
                        bool isConnected = await checkInternetConnection();
                        String password;
                        if(!isConnected){
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: Text(
                                  localized.error,
                                  textAlign: TextAlign.center,
                                ),
                                titleTextStyle: TextStyle(
                                    color: kPrimaryColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w800
                                ),
                                content: Container(
                                  height: 100,
                                  child: Center(
                                    child: Text(localized.noInternetConnection),
                                  ),
                                ),
                              );
                            }
                          );
                          setState(() {
                            isUpdating = false;
                          });
                        }
                        else if(_formKey.currentState.validate()){
                          if(updatedValues.keys.contains('email')){
                            await showDialog(
                              context: context,
                              builder: (context) {
                                final GlobalKey<FormState> _formPasswordKey = new GlobalKey<FormState>();
                                return AlertDialog(
                                  title: Text(
                                    localized.pleaseEnterYourPassword,
                                    textAlign: TextAlign.center,
                                  ),
                                  titleTextStyle: TextStyle(
                                      color: kPrimaryColor,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800
                                  ),
                                  content: Container(
                                    height: 200,
                                    child: Form(
                                      key: _formPasswordKey,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          FormGenerator.addInput(
                                            label: localized.password,
                                            obsecure: true,
                                            validator: (value){
                                              if(value.isEmpty){
                                                return localized.pleaseEnterYourPassword;
                                              }
                                              return null;
                                            },
                                            onsaved: (value){
                                              password = value;
                                            }
                                          ),
                                          BaseButton(
                                            text: localized.continue_,
                                            onPressed: (){
                                              if(_formPasswordKey.currentState.validate()){
                                                _formPasswordKey.currentState.save();
                                                Navigator.pop(context);
                                              }
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }
                            );
                            String errorMsg = await context.read<GeneralProviderData>().updateEmail(updatedValues['email'], password);

                            if(errorMsg != null){
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      localized.failed,
                                      textAlign: TextAlign.center,
                                    ),
                                    titleTextStyle: TextStyle(
                                        color: kPrimaryColor,
                                        fontSize: 22,
                                        fontWeight: FontWeight.w800
                                    ),
                                    content: Container(
                                      height: 100,
                                      child: Text(
                                        errorMsg,
                                        style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  );
                                }
                              );
                              setState(() {
                                isUpdating = false;
                              });
                              return;
                            }
                            updatedValues.remove('email');
                          }

                          bool result = await context.read<GeneralProviderData>().updatePersonalData(updatedValues);
                          if(result){
                            updatedValues = {};
                            _formKey.currentState.reset();
                          }
                          Timer(Duration(seconds: 1), (){
                            setState(() {
                              isUpdating = false;
                            });
                          });
                        }
                        setState(() {
                          isUpdating = false;
                        });
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