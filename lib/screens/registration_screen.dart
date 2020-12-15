import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/custom_input_field.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/widgets/double_circle_background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String name;

  String email;

  String password;

  String phoneNumber;

  String age;

  String gender = 'Female';
  final _auth = FirebaseAuth.instance;
  final _fireStore = FirebaseFirestore.instance;
  Widget _listViewContentGenerator(label, icon, onChanged, {obsecure}){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomInputField(
        label: label,
        icon: icon,
        onChanged: onChanged,
        obsecure: obsecure,
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
                        _listViewContentGenerator('Ad Soyad', FontAwesomeIcons.userAlt, (value)=> name = value,),
                        _listViewContentGenerator('Email', Icons.mail, (value)=> email = value,),
                        _listViewContentGenerator('Şifre', Icons.lock_outline, (value)=> password = value, obsecure: true),
                        _listViewContentGenerator('Tel No', Icons.phone_android, (value)=> phoneNumber = value,),
                        _listViewContentGenerator('Yaş', Icons.cake_outlined, (value)=> age = value,),
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
                                      value: gender,
                                      icon: Icon(Icons.arrow_downward),
                                      onChanged: (String newValue){
                                        setState(() {
                                          gender = newValue;
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
                        try{
                          final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                          if(newUser != null){
                            await _fireStore.collection('UserInfo').add({
                              'name_surname': name,
                              'age': age,
                              'phone_number': phoneNumber,
                              'gender': gender,
                              'id': newUser.user.uid,
                            });
                            Navigator.pushNamed(context, LoginScreen.routeName);
                          }
                        }
                        catch(e){
                          print(e);
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
