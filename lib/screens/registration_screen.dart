import 'package:flutter/material.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';


class RegistrationScreen extends StatefulWidget {
  static const routeName = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  UserModel _newUser = UserModel();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();


  String _mailValidator(String text){
    if(!text.contains('@')){
      return "Please enter a mail";
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
            'Register',
          style: Theme.of(context).appBarTheme.textTheme.headline6.copyWith(color: Colors.white),
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
            ),
            alignment: Alignment.center,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Mail',
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
                    keyboardType: TextInputType.emailAddress,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                    keyboardType: TextInputType.emailAddress,
                    obscureText: true,
                    autocorrect: false,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Password',
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
                    obscureText: true,
                    autocorrect: false,
                  ),
                  Material(
                    elevation: 3,
                    borderRadius: BorderRadius.circular(10.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Name',
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
