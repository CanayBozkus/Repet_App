
import 'package:flutter/material.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/base_shadow.dart';

class AddressSettings extends StatefulWidget {
  @override
  _AddressSettingsState createState() => _AddressSettingsState();
}

class _AddressSettingsState extends State<AddressSettings> {
  bool isActive = false;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
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
                'Address',
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
                    label: 'Daire veya Bina No',
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
                  ),
                  FormGenerator.settingsPageInput(
                    label: 'Sokak Adı',
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
                  ),
                  FormGenerator.settingsPageInput(
                    label: 'İlce',
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
                  ),
                  FormGenerator.settingsPageInput(
                    label: 'Şehir',
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
                  ),
                  FormGenerator.settingsPageInput(
                    label: 'Posta Kodu',
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
                  ),
                  FormGenerator.settingsPageInput(
                    label: 'Ülke',
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
