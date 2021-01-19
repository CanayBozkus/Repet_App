import 'package:flutter/material.dart';
import 'package:repetapp/screens/main_screen.dart';
import 'package:repetapp/screens/registration_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/button_leading_svg.dart';
import 'package:repetapp/widgets/base_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = 'LoginScreen';
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
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
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: height * 0.30,
                  width: double.infinity,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/paw.svg',
                        color: kPrimaryColor,
                        height: height*0.15,
                      ),
                      SizedBox(height: height*0.02,),
                      Text(
                        'RePet',
                        style: TextStyle(
                          fontSize: height*0.05,
                          fontWeight: FontWeight.w700,
                          color: kPrimaryColor,
                        ),
                      )
                    ],
                  )
                ),
                BaseInputField(
                  label: 'Email',
                  keyboardType: KeyboardTypes.emailAddress,
                  onChanged: (value) {
                    email = value;
                  },
                ),
                SizedBox(height: height*0.035,),
                BaseInputField(
                  label: 'Password',
                  onChanged: (value) {
                    password = value;
                  },
                  obsecure: true,
                ),
                SizedBox(height: height*0.035,),
                Material(
                  shadowColor: Colors.grey.shade400,
                  elevation: 5,
                  borderRadius: BorderRadius.circular(5),
                  child: FlatButton(
                    color: kPrimaryColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 14.0),
                    minWidth: double.infinity,
                    child: Text(
                      'Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    onPressed: () async {
                      final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                      if(user != null){
                        Navigator.pushNamed(context, MainScreen.routeName);
                      }
                    },
                  ),
                ),
                SizedBox(height: height*0.02,),
                Text(
                  'Forgot password ?',
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: height*0.02,),
                ButtonLeadingSvg(
                  svg: 'assets/icons/iconmonstr-facebook-1.svg',
                  label: 'Login with Facebook',
                  color: Color(0xff345ea1),
                  onPressed: () {},
                ),
                SizedBox(height: height*0.02,),
                ButtonLeadingSvg(
                  svg: 'assets/icons/google.svg',
                  label: 'Login with Google',
                  onPressed: () {},
                  color: Color(0xffdb3522),
                ),
                SizedBox(height: height*0.02,),
                FlatButton(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: kPrimaryColor,
                      width: 1.5,
                      style: BorderStyle.solid,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  padding: EdgeInsets.symmetric(vertical: 14.0),
                  minWidth: double.infinity,
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: kPrimaryColor,
                      fontSize: 18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.routeName);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
