import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/spinner.dart';
import 'dart:async';

class PetSettings extends StatefulWidget {
  @override
  _PetSettingsState createState() => _PetSettingsState();
}

class _PetSettingsState extends State<PetSettings> {
  bool isActive = false;
  bool isUpdating = false;
  Map<String, dynamic> updatedValues = {};
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();

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
    PetModel currentPet = context.watch<ProvidedData>().pets[context.watch<ProvidedData>().currentShownPetIndex];
    return Container(
      padding: generalScreenPadding,
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
                children: [
                  BaseShadow(
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
                  FormGenerator.settingsPageInput(
                    label: currentPet.name,
                    svg: 'assets/icons/dog.svg',
                    onChanged: (value) {
                      activateSaveButton(value.isNotEmpty, 'name', value);
                    },
                    validator: (value) {
                      if(value.contains(RegExp(r'[0-9]'))){
                        return 'Name cannot contain number.';
                      }
                      return null;
                    },
                  ),
                  FormGenerator.settingsPageInput(
                    label: currentPet.species,
                    svg: 'assets/icons/species.svg',
                    onChanged: (value) {
                      activateSaveButton(value.isNotEmpty, 'species', value);
                    },
                    validator: (value) {
                      if(value.contains(RegExp(r'[0-9]'))){
                        return 'Species cannot contain number.';
                      }
                      return null;
                    },
                  ),
                  FormGenerator.settingsPageDropdown(
                    categories: ['Male', 'Female'],
                    hint: currentPet.gender,
                    svg: 'assets/icons/gender.svg',
                    onChanged: (value) {
                      activateSaveButton(value.isNotEmpty, 'gender', value);
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  FormGenerator.settingsPageInput(
                    label: '${currentPet.weight} kg',
                    svg: 'assets/icons/weight.svg',
                    keyboardType: KeyboardTypes.number,
                    onChanged: (String value) {
                      activateSaveButton(value.isNotEmpty, 'weight', value.isNotEmpty ? double.parse(value) : 0);
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded( 
                        child: FormGenerator.settingsPageInput(
                          label: '${currentPet.year} year',
                          svg: 'assets/icons/cake.svg',
                          keyboardType: KeyboardTypes.number,
                          onChanged: (value) {
                            activateSaveButton(value.isNotEmpty, 'year', value.isNotEmpty ? int.parse(value) : 0);
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a gender!';
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: FormGenerator.settingsPageInput(
                          label: '${currentPet.month} month',
                          keyboardType: KeyboardTypes.number,
                          onChanged: (value) {
                            activateSaveButton(value.isNotEmpty, 'month', value.isNotEmpty ? int.parse(value) : 0);
                          },
                          validator: (value) {
                            if (value == null) {
                              return 'Please select a gender!';
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                  FormGenerator.settingsPageInput(
                    label: '${currentPet.height} m',
                    keyboardType: KeyboardTypes.number,
                    svg: 'assets/icons/height.svg',
                    onChanged: (value) {
                      activateSaveButton(value.isNotEmpty, 'height', value.isNotEmpty ? double.parse(value) : 0);
                    },
                    validator: (value) {
                      return null;
                    },
                  ),
                  FormGenerator.settingsPageInput(
                    label: 'Alerji',
                    svg: 'assets/icons/peanut.svg',
                    disableKeyboard: true,
                  ),
                  FormGenerator.settingsPageInput(
                    label: 'Engel',
                    svg: 'assets/icons/wheelchair.svg',
                    disableKeyboard: true,
                  ),
                  SizedBox(height: 20,),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: isUpdating ? Spinner() : BaseButton(
                      text: 'Save',
                      width: 100,
                      onPressed: isActive ? () async {
                        FocusScope.of(context).unfocus();
                        if(_formKey.currentState.validate()){
                          bool result = await context.read<ProvidedData>().updatePetData(updatedValues);
                          setState(() {
                            isUpdating = true;
                          });
                          if(result){
                            updatedValues = {};
                            _formKey.currentState.reset();
                          }
                          //TODO: error popupı göster, giriş sayfasındaki popupı genel hale getirerek kullan
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
