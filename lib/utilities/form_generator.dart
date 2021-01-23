import 'package:flutter/material.dart';
import 'package:repetapp/widgets/base_checkbox.dart';
import 'constants.dart';

class FormGenerator{

  Widget addInput({String label, KeyboardTypes keyboard, bool obsecure, Function validator, Function onsaved}){
    FocusNode focusNode = FocusNode();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Material(
        elevation: 3,
        borderRadius: BorderRadius.circular(10.0),
        child: TextFormField(
          decoration: InputDecoration(
            labelText: label,

            focusColor: kPrimaryColor,
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
        padding: EdgeInsets.symmetric(horizontal: 2),
        children: [
          this.addInput(label: 'Mail', keyboard: KeyboardTypes.emailAddress,
            onsaved: (String value){
              userModel.email = value;
            },
            validator: (String value){
              if(value.isEmpty){
                return 'Please enter a email!';
              }
              if(!value.contains('@')){
                return 'Invalid email.';
              }
              return null;
            },
          ),
          this.addInput(label: 'Password', keyboard: KeyboardTypes.text, obsecure: true,
            onsaved: (String value){
              userModel.password = value;
            },
            validator: (String value){
              if(value.isEmpty){
                return 'Please enter a password!';
              }
              if(value.length < 8){
                return 'Password cannot less than 8 character.';
              }
              return null;
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
            },
            validator: (String value){
              if(value.isEmpty){
                return 'Please enter your name!';
              }
              if(value.contains(RegExp(r'[0-9]'))){
                return 'Name cannot contain number.';
              }
              return null;
            },
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: BaseCheckBox(
                  value: userModel.newsSetterConfirmation,
                  onChanged: (value){
                    stateController((){
                      userModel.newsSetterConfirmation = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Text(
                  "Repet\’in bana özel kampanya, tanıtım ve fırsatlarından haberdar olmak istiyorum",
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
          SizedBox(height: 3,),
          RichText(
            text: TextSpan(
              text: "Üye olmakla ",
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF6f6f6f),
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: "Kullanım koşullarını ",
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
                TextSpan(
                    text: "onaylamış olursunuz."
                )
              ],
            ),
          ),
          SizedBox(height: 3,),
          RichText(
            text: TextSpan(
              text: "Kişisel verilerinize dair Aydınlatma Metni için  ",
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF6f6f6f),
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                    text: "tıklayınız.",
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
