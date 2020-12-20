import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/custom_input_field.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/widgets/double_circle_background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  UserModel _newUser = UserModel();

  Widget _listViewContentGenerator(label, icon, onChanged, {obsecure, keyBoardType}){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomInputField(
        label: label,
        icon: icon,
        onChanged: onChanged,
        obsecure: obsecure,
        keyboardType: keyBoardType ?? KeyboardTypes.text,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: DoubleCircleBackground(
            child: Container(
              padding: EdgeInsets.symmetric(
                horizontal: width * 0.1,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.1,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text(
                        'Kayıt Ol',
                        style: TextStyle(
                          fontSize: height * 0.05,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .1,
                  ),
                  Container(
                    height: height*0.5,
                    child: ListView(
                      children: [
                        _listViewContentGenerator('Ad Soyad', FontAwesomeIcons.userAlt, (value)=> _newUser.nameSurname = value,),
                        _listViewContentGenerator('Email', Icons.mail, (value)=> _newUser.email = value, keyBoardType: KeyboardTypes.emailAddress),
                        _listViewContentGenerator('Şifre', Icons.lock_outline, (value)=> _newUser.password = value, obsecure: true),
                        _listViewContentGenerator('Tel No', Icons.phone_android, (value)=> _newUser.phoneNumber = int.parse(value), keyBoardType: KeyboardTypes.number),
                        _listViewContentGenerator('Yaş', Icons.cake_outlined, (value)=> _newUser.age = int.parse(value), keyBoardType: KeyboardTypes.number),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: DefaultElevation(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    height: height*0.09,
                                    padding: EdgeInsets.symmetric(horizontal: 12),
                                    child: Row(
                                      children: [
                                        Icon(FontAwesomeIcons.transgenderAlt, color: Colors.grey,),
                                        SizedBox(width: 12,),
                                        Text(
                                          'Cinsiyet',
                                          style: TextStyle(
                                            color: Color(0xffd0d0d0),
                                            fontWeight: FontWeight.w500,
                                            fontSize: 18.0,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ),
                                Container(
                                  height: height*0.09,
                                  width: 1,
                                  color: Colors.grey.shade400,
                                ),
                                Expanded(
                                  child: Container(
                                    height: height*0.09,
                                    padding: EdgeInsets.symmetric(horizontal: width*0.05),
                                    alignment: Alignment.center,
                                    child: DropdownButton<String>(
                                      isExpanded: true,
                                      underline: Container(),
                                      iconEnabledColor: kPrimaryColor,
                                      value: _newUser.gender,
                                      icon: Icon(Icons.arrow_downward),
                                      onChanged: (String newValue){
                                        setState(() {
                                          _newUser.gender = newValue;
                                        });
                                      },
                                      items: <String>['Female', 'Male', 'Other'].map<DropdownMenuItem<String>>((String value){
                                        return DropdownMenuItem<String>(
                                          child: Text(value),
                                          value: value,
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * .1,
                  ),
                  Material(
                    shadowColor: Colors.grey.shade400,
                    elevation: 10,
                    child: FlatButton(
                      color: kPrimaryColor,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      minWidth: double.infinity,
                      child: Text(
                        'Kayıt Ol',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      onPressed: () async {
                        bool response = await _newUser.createUser();
                        if(response){
                          Navigator.pushNamed(context, LoginScreen.routeName);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                    width: double.infinity,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: 'Hesabınız var mı?  ',
                        style: kDefaultTextStyle,
                        children: [
                          TextSpan(
                            text: 'Giriş Yap',
                            style:
                            kDefaultTextStyle.copyWith(color: Colors.black),
                            recognizer: TapGestureRecognizer()..onTap = (){
                              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
