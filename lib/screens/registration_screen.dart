import 'package:flutter/material.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/screens/pet_registration_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/base_checkbox.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  static const routeName = 'RegistrationScreen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  UserModel _newUser = UserModel();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
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
              vertical: height * 0.05,
            ),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Container(
                  height: height * 0.65,
                  child: Form(
                    key: _formKey,
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 2),
                      children: [
                        FormGenerator.addInput(
                          label: 'Mail',
                          keyboard: KeyboardTypes.emailAddress,
                          onsaved: (String value) {
                            _newUser.email = value;
                          },
                          validator: FormGenerator.mailValidator,
                        ),
                        FormGenerator.addInput(
                          label: 'Password',
                          keyboard: KeyboardTypes.text,
                          obsecure: true,
                          onsaved: (String value) {
                            _newUser.password = value;
                          },
                          validator: FormGenerator.passwordValidator,
                          onchanged: (value) => _newUser.password = value,
                        ),
                        FormGenerator.addInput(
                          label: 'Password',
                          keyboard: KeyboardTypes.text,
                          obsecure: true,
                          validator: (String value) {
                            if (value != _newUser.password) {
                              return "Passwords does not match!";
                            }
                            return null;
                          },
                        ),
                        FormGenerator.addInput(
                          label: 'Name',
                          keyboard: KeyboardTypes.text,
                          onsaved: (String value) {
                            _newUser.nameSurname = value;
                          },
                          validator: FormGenerator.nameValidatorGenerator('your'),
                        ),
                        FormGenerator.addInput(
                          label: 'Age',
                          keyboard: KeyboardTypes.number,
                          onsaved: (String value) {
                            _newUser.age = int.parse(value);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter your age! Exp: 21';
                            }
                          },
                        ),
                        FormGenerator.addDropdown(
                            categories: ['Male', 'Female'],
                            hint: 'Cinsiyet',
                            onChanged: (value) {
                              _newUser.gender = value;
                            },
                            validator: (value) {
                              if (value == null) {
                                return 'Please select a gender!';
                              }
                            }),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: BaseCheckBox(
                                value: _newUser.newsSetterConfirmation,
                                onChanged: (value) {
                                  setState(() {
                                    _newUser.newsSetterConfirmation = value;
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
                        SizedBox(
                          height: 3,
                        ),
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
                              TextSpan(text: "onaylamış olursunuz.")
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                            "Kişisel verilerinize dair Aydınlatma Metni için  ",
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
                  ),
                ),
                SizedBox(
                  height: height * 0.02,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      child: Text(
                        'Have you already an account?',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText2
                            .copyWith(color: kPrimaryColor),
                      ),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, LoginScreen.routeName);
                      },
                    ),
                    BaseButton(
                      text: 'Ileri',
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          context.read<GeneralProviderData>().newUser = _newUser;
                          Navigator.pushNamed(context, PetRegistrationScreen.routeName,);
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
