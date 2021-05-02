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
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    AppLocalizations localized = AppLocalizations.of(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          localized.register,
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
                          label: localized.email,
                          keyboard: KeyboardTypes.emailAddress,
                          onsaved: (String value) {
                            _newUser.email = value;
                          },
                          validator: FormGenerator.mailValidator,
                        ),
                        FormGenerator.addInput(
                          label: localized.password,
                          keyboard: KeyboardTypes.text,
                          obsecure: true,
                          onsaved: (String value) {
                            _newUser.password = value;
                          },
                          validator: FormGenerator.passwordValidator,
                          onchanged: (value) => _newUser.password = value,
                        ),
                        FormGenerator.addInput(
                          label: localized.password,
                          keyboard: KeyboardTypes.text,
                          obsecure: true,
                          validator: (String value) {
                            if (value != _newUser.password) {
                              return localized.passwordsDoesNotMatch;
                            }
                            return null;
                          },
                        ),
                        FormGenerator.addInput(
                          label: localized.name,
                          keyboard: KeyboardTypes.text,
                          onsaved: (String value) {
                            _newUser.nameSurname = value;
                          },
                          validator: FormGenerator.nameValidatorGenerator('your'),
                        ),
                        FormGenerator.addInput(
                          label: localized.age,
                          keyboard: KeyboardTypes.number,
                          onsaved: (String value) {
                            _newUser.age = int.parse(value);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return localized.pleaseEnterYourAge;
                            }
                          },
                        ),
                        FormGenerator.addDropdown(
                            categories: [localized.male, localized.female],
                            hint: localized.gender,
                            onChanged: (value) {
                              _newUser.gender = value;
                            },
                            validator: (value) {
                              if (value == null) {
                                return localized.pleaseSelectAGender;
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
                                localized.iWantToBeInformedAboutRepetsSpecialCampaignsPromotionsAndOpportunities,
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
                            text: localized.byBecomingAMemberYouApproveTheTermsOfUse
                                .substring(0, localized.byBecomingAMemberYouApproveTheTermsOfUse.indexOf(localized.theTermsOfUse)),
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF6f6f6f),
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: localized.theTermsOfUse,
                                style: TextStyle(
                                  color: kPrimaryColor,
                                ),
                              ),
                              TextSpan(text: localized.byBecomingAMemberYouApproveTheTermsOfUse
                                  .substring(localized.byBecomingAMemberYouApproveTheTermsOfUse.indexOf(localized.theTermsOfUse)+localized.theTermsOfUse.toString().length))
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 3,
                        ),
                        RichText(
                          text: TextSpan(
                            text:
                            localized.forTheClarificationTextOnYourPersonalData,
                            style: TextStyle(
                              fontSize: 14.0,
                              color: Color(0xFF6f6f6f),
                              fontWeight: FontWeight.w600,
                            ),
                            children: [
                              TextSpan(
                                text: localized.click.toLowerCase(),
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
                        localized.haveYouAlreadyAnAccount,
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
                      text: localized.next,
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
