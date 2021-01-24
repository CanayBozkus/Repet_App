import 'package:flutter/material.dart';
import 'package:repetapp/widgets/base_checkbox.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'constants.dart';

class FormGenerator{

  String _mailValidator(String value){
    if(value.isEmpty){
      return 'Please enter a email!';
    }
    if(!value.contains('@')){
      return 'Invalid email.';
    }
    return null;
  }

  String _passwordValidator(String value){
    if(value.isEmpty){
      return 'Please enter a password!';
    }
    if(value.length < 8){
      return 'Password cannot less than 8 character.';
    }
    return null;
  }

  String _nameValidator(String value){
    if(value.isEmpty){
      return 'Please enter your name!';
    }
    if(value.contains(RegExp(r'[0-9]'))){
      return 'Name cannot contain number.';
    }
    return null;
  }

  Widget addInput({String label, KeyboardTypes keyboard, bool obsecure, Function validator, Function onsaved, Function onchanged}){
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
          onChanged: onchanged,
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
            validator: _mailValidator,
          ),
          this.addInput(label: 'Password', keyboard: KeyboardTypes.text, obsecure: true,
            onsaved: (String value){
              userModel.password = value;
            },
            validator: _passwordValidator,
            onchanged: (value)=> userModel.password=value,
          ),
          this.addInput(label: 'Password', keyboard: KeyboardTypes.text, obsecure: true,
            validator: (String value){
              if(value != userModel.password){
                print(value);
                print(userModel.password);
                return "Passwords does not match!";
              }
              return null;
            },
          ),
          this.addInput(label: 'Name', keyboard: KeyboardTypes.text,
            onsaved: (String value){
              userModel.nameSurname = value;
            },
            validator: _nameValidator,
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

  Widget petRegisterForm({@required final petModel, @required final key, stateController}){
    return Form(
      key: key,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 2),
        children: [
         /* Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              DefaultElevation(
                isCircular: true,
                child: FlatButton(
                  onPressed: (){
                    stateController(() {
                      isDog = !isDog;
                    });
                  },
                  shape: CircleBorder(),
                  child: Container(
                    width: width * 0.3,
                    height: width * 0.3,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      'assets/icons/dog.svg',
                      color: isDog ? Color(0xffba892b) : Color(0xffd0d0d0),
                    ),
                  ),
                ),
              ),
              DefaultElevation(
                isCircular: true,
                child: FlatButton(
                  onPressed: (){
                    setState(() {
                      isDog = !isDog;
                    });
                  },
                  shape: CircleBorder(),
                  child: Container(
                    width: width * 0.3,
                    height: width * 0.3,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      'assets/icons/cat.svg',
                      color: !isDog ? Color(0xffba892b) : Color(0xffd0d0d0),
                    ),
                  ),
                ),
              ),
            ],
          ),*/
          this.addInput(label: 'Name', keyboard: KeyboardTypes.text,
            onsaved: (String value){
              petModel.name = value;
            },
            validator: _nameValidator,
          ),
          this.addInput(label: 'Cinsiyet', keyboard: KeyboardTypes.text,
            onsaved: (String value){
              petModel.name = value;
            },
            validator: _nameValidator,
          ),
          this.addInput(label: 'Ağırlık / kg', keyboard: KeyboardTypes.number,
            onsaved: (String value){
              petModel.name = value;
            },
            validator: (String value){},
          ),
          this.addInput(label: 'Boy / metre', keyboard: KeyboardTypes.number,
            onsaved: (String value){
              petModel.name = value;
            },
            validator: (String value){},
          ),
          Row(
            children: [
              Expanded(
                child: this.addInput(label: 'Yıl', keyboard: KeyboardTypes.number,
                  onsaved: (String value){
                    petModel.name = value;
                  },
                  validator: (String value){},
                ),
              ),
              Expanded(
                child: this.addInput(label: 'Ay', keyboard: KeyboardTypes.number,
                  onsaved: (String value){
                    petModel.name = value;
                  },
                  validator: (String value){},
                ),
              ),
            ],
          ),
          SizedBox(height: 8,),

          SizedBox(height: 3,),

          SizedBox(height: 3,),

        ],
      ),
    );
  }
}
