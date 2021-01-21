import 'package:flutter/material.dart';
import 'constants.dart';

class FormGenerator{
  final GlobalKey<FormState> formKey;
  FormGenerator({@required this.formKey});

  final _inputFieldTypes = {
    'email':{'label':'Mail', 'keyboard': KeyboardTypes.emailAddress, 'obsecure': false},
    'password':{'label':'Mail', 'keyboard': KeyboardTypes.emailAddress, 'obsecure': false},
  };

  Widget addInput({String label, KeyboardTypes keyboard, bool obsecure}){
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: kPrimaryColor,
          ),
        ),
      ),
      style: TextStyle(
        fontSize: 18.0,
      ),
      keyboardType: keyBoards[keyboard] ?? TextInputType.text,
      obscureText: obsecure ?? false,
    );
  }

  Widget userRegisterForm(){
    return Form(
      key: formKey,
      child: ListView(
        children: [
          this.addInput(label: 'Mail', keyboard: KeyboardTypes.emailAddress),
          this.addInput(label: 'Password', keyboard: KeyboardTypes.text, obsecure: true),
          this.addInput(label: 'Password', keyboard: KeyboardTypes.text, obsecure: true),
          this.addInput(label: 'Name', keyboard: KeyboardTypes.text),
        ],
      ),
    );
  }
}
