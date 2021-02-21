
import 'package:flutter/material.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_shadow.dart';

class AddressSettings extends StatelessWidget {
  final FormGenerator _formGenerator = FormGenerator();
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
              child: ListView(
                children: [
                  FormGenerator.settingsPageInput(label: 'Daire veya Bina No',),
                  FormGenerator.settingsPageInput(label: 'Sokak Adı',),
                  FormGenerator.settingsPageInput(label: 'İlce',),
                  FormGenerator.settingsPageInput(label: 'Şehir',),
                  FormGenerator.settingsPageInput(label: 'Posta Kodu',),
                  FormGenerator.settingsPageInput(label: 'Ülke',),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
