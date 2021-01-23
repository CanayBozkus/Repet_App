import 'package:flutter/material.dart';
import 'constants.dart';

class FormGenerator{

  Widget addInput({String label, KeyboardTypes keyboard, bool obsecure, Function validator, Function onsaved}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: kPrimaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5
              ),
            ),
          ),
          style: TextStyle(
            fontSize: 18.0,
          ),
          keyboardType: keyBoards[keyboard] ?? TextInputType.text,
          obscureText: obsecure ?? false,
          validator: validator,
          onSaved: onsaved,
        ),
      ),
    );
  }

  Widget userRegisterForm({@required final userModel, @required final key, stateController}){
    return Form(
      key: key,
      child: ListView(
        children: [
          this.addInput(label: 'Mail', keyboard: KeyboardTypes.emailAddress,
            onsaved: (String value){
              userModel.email = value;
            },
          ),
          this.addInput(label: 'Password', keyboard: KeyboardTypes.text, obsecure: true,
            onsaved: (String value){
              userModel.password = value;
            },
          ),
          this.addInput(label: 'Password', keyboard: KeyboardTypes.text, obsecure: true,
            validator: (String value){
              if(value != userModel.password){
                return "Passwords does not match!";
              }
              return null;
            },
          ),
          this.addInput(label: 'Name', keyboard: KeyboardTypes.text,
            onsaved: (String value){
              userModel.nameSurname = value;
            }
          ),
          Row(
            children: [
              Checkbox(value: userModel.newsSetterConfirmation,
                onChanged: (value){
                  stateController((){
                    userModel.newsSetterConfirmation = value;
                  });
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}
