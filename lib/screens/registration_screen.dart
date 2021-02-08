import 'package:flutter/material.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/screens/pet_registration_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_button.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  UserModel _newUser = UserModel();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final _formGen = FormGenerator();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Register',
          style: Theme.of(context)
              .appBarTheme
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
        ),
        leading: Container(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height*0.05,
            ),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: height*0.65,
                  child: _formGen.userRegisterForm(
                      userModel: _newUser,
                      key: _formKey,
                      stateController: setState),
                ),
                SizedBox(height: height*0.02,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Have you already an account?',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(color: kPrimaryColor),
                      ),
                      onTap: (){
                        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                      },
                    ),
                    BaseButton(
                      text: 'Ileri',
                      onPressed: (){
                       if(_formKey.currentState.validate()){
                         _formKey.currentState.save();
                         Navigator.pushNamed(context, PetRegistrationScreen.routeName, arguments: _newUser);
                       }
                      },
                      width: 120,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

