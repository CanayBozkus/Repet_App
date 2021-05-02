import 'package:flutter/material.dart';
import 'package:repetapp/screens/main_screen.dart';
import 'package:repetapp/screens/registration_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/button_leading_svg.dart';
import 'package:repetapp/widgets/base_input_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/spinner.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class LoginScreen extends StatefulWidget {
  static const routeName = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  final _formGen = FormGenerator();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  Map _loginValuesStorage = {'email': '', 'password': ''};
  bool _isLogging = false;

  @override
  Widget build(BuildContext context) {
    AppLocalizations localized = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: generalScreenPadding,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 3),
              children: [
                //TODO: bu kısmı FormGenerator.loginForm() içerisinden al
                Container(
                    height: 200,
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/icons/paw.svg',
                          color: kPrimaryColor,
                          height: 100,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'RePet',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor,
                          ),
                        )
                      ],
                    )),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      FormGenerator.addInput(
                          label: localized.email,
                          keyboard: KeyboardTypes.emailAddress,
                          validator: (String value){
                            if(value.isEmpty){
                              return localized.pleaseEnterYourEmail;
                            }
                            return null;
                          },
                          onsaved: (value){
                            _loginValuesStorage['email'] = value;
                          }
                      ),
                      FormGenerator.addInput(
                        label: localized.password,
                        obsecure: true,
                        validator: (value){
                          if(value.isEmpty){
                            return localized.pleaseEnterYourPassword;
                          }
                          return null;
                        },
                        onsaved: (value){
                          _loginValuesStorage['password'] = value;
                        }
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                _isLogging ? Spinner() : BaseButton(
                  text: localized.login,
                  onPressed: () async {
                    //TODO: login kısmını UserModel üzerinden gerçekleştir (?) ve provider üzerinde currenUser olarak assign et
                    //TODO: spinner ekle
                    bool isValid = _formKey.currentState.validate();
                    if(isValid){
                      setState(() {
                        _isLogging = true;
                      });
                      _formKey.currentState.save();
                      try{
                        final user = await _auth.signInWithEmailAndPassword(
                          email: _loginValuesStorage['email'], password: _loginValuesStorage['password'],
                        );
                        if (user != null) {
                          Navigator.pushReplacementNamed(context, MainScreen.routeName);
                        }
                        else {
                          throw new Error();
                        }
                      }
                      catch(e){
                        String error= e.toString();
                        String errorMsg;
                        print(e);
                        if(error.contains('invalid-email') || error.contains('ınvalıd-emaıl')){
                          errorMsg = localized.invalidEmailPleaseEnterAValidEmail;
                        }
                        else if(error.contains('user-not-found')){
                          errorMsg = localized.noAccountFoundPleaseRegisterOrTryWithAnotherAccount;
                        }
                        else if(error.contains('wrong-password')){
                          errorMsg = localized.wrongPasswordPleaseTryAgain;
                        }
                        else {
                          errorMsg = localized.cannotLoginRightNowPleaseTryAgainLater;
                        }
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text(
                                localized.loginFailed,
                                textAlign: TextAlign.center,
                              ),
                              titleTextStyle: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w800
                              ),
                              content: Container(
                                height: 100,
                                child: Text(
                                  errorMsg,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            );
                          }
                        );
                      }
                      setState(() {
                        _isLogging = false;
                      });
                    }
                  },
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  localized.forgotPassword,
                  style: TextStyle(
                    color: kPrimaryColor,
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 15,
                ),
                ButtonLeadingSvg(
                  svg: 'assets/icons/iconmonstr-facebook-1.svg',
                  label: localized.loginWithFacebook,
                  color: Color(0xff345ea1),
                  onPressed: () {},
                ),
                SizedBox(
                  height: 15,
                ),
                ButtonLeadingSvg(
                  svg: 'assets/icons/google.svg',
                  label: localized.loginWithGoogle,
                  onPressed: () {},
                  color: Color(0xffdb3522),
                ),
                SizedBox(
                  height: 15,
                ),
                BaseButton(
                  text: localized.register,
                  onPressed: () {
                    Navigator.pushNamed(context, RegistrationScreen.routeName);
                  },
                  empty: true,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
