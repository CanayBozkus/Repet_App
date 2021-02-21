import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';

class PetSettings extends StatefulWidget {
  @override
  _PetSettingsState createState() => _PetSettingsState();
}

class _PetSettingsState extends State<PetSettings> {
  bool isActive = false;
  @override
  Widget build(BuildContext context) {
    PetModel currentPet = context.watch<ProvidedData>().pets[context.watch<ProvidedData>().currentShownPetIndex];
    return Container(
      padding: generalScreenPadding,
      child: Column(
        children: [
          Expanded(
            child: Form(
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
                  FormGenerator.settingsPageInput(label: currentPet.name, svg: 'assets/icons/dog.svg',),
                  FormGenerator.settingsPageInput(label: currentPet.species, svg: 'assets/icons/species.svg',),
                  FormGenerator.settingsPageDropdown(
                    categories: ['Male', 'Female'],
                    hint: currentPet.gender,
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
                  FormGenerator.settingsPageInput(label: '${currentPet.weight} kg', svg: 'assets/icons/weight.svg',),
                  FormGenerator.settingsPageInput(label: '${currentPet.year} year ${currentPet.month} month', svg: 'assets/icons/cake.svg',),
                  FormGenerator.settingsPageInput(label: '${currentPet.height} m', svg: 'assets/icons/height.svg',),
                  FormGenerator.settingsPageInput(label: 'Alerji', svg: 'assets/icons/peanut.svg',),
                  FormGenerator.settingsPageInput(label: 'Engel', svg: 'assets/icons/wheelchair.svg',),
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
