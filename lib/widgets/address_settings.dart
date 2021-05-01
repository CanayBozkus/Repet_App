
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/utilities/helpers.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:repetapp/widgets/spinner.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class AddressSettings extends StatefulWidget {
  @override
  _AddressSettingsState createState() => _AddressSettingsState();
}

class _AddressSettingsState extends State<AddressSettings> {
  bool isActive = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
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
    List addresses = context.watch<GeneralProviderData>().currentUser.addresses;
    Map address = addresses != null ? addresses[0] : {};
    AppLocalizations localized = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          BaseShadow(
            child: Container(
              height: 80,
              padding: EdgeInsets.only(left: 45),
              alignment: Alignment.centerLeft,
              child: Text(
                localized.address,
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xff636363),
                ),
              ),
            ),
          ),
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  FormGenerator.settingsPageInput(
                    label: address['buildingNumber'] ?? localized.buildingNumber,
                    onChanged: (value) {
                      activateSaveButton(value.isNotEmpty, 'buildingNumber', value);
                    },
                  ),
                  FormGenerator.settingsPageInput(
                    label: address['apartmentNumber'] ?? localized.apartmentNumber,
                    onChanged: (value) {
                      activateSaveButton(value.isNotEmpty, 'apartmentNumber', value);
                    },
                  ),
                  FormGenerator.settingsPageInput(
                    label: address['streetName'] ?? localized.streetName,
                    onChanged: (value) {
                      activateSaveButton(value.isNotEmpty, 'streetName', value);
                    },
                  ),
                  FormGenerator.settingsPageInput(
                    label: address['city'] ?? localized.city,
                    onChanged: (value) {
                      activateSaveButton(value.isNotEmpty, 'city', value);
                    },
                  ),
                  FormGenerator.settingsPageInput(
                    label: address['zipCode'] ?? localized.zipCode,
                    onChanged: (value) {
                      activateSaveButton(value.isNotEmpty, 'zipCode', value);
                    },
                  ),
                  FormGenerator.settingsPageInput(
                    label: address['country'] ?? localized.country,
                    onChanged: (value) {
                      activateSaveButton(value.isNotEmpty, 'country', value);
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
                        else {
                          bool result = await context.read<GeneralProviderData>().updatePersonalData({'addresses': [updatedValues]});
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
