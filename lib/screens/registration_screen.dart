import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/custom_input_field.dart';
import 'package:repetapp/widgets/double_circle_background.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RegistrationScreen extends StatelessWidget {
  Widget _listViewContentGenerator(label, icon, {obsecure}){
    return  Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: CustomInputField(
        label: label,
        icon: icon,
        onSubmitted: (value) {},
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
                        _listViewContentGenerator('Ad Soyad', FontAwesomeIcons.userAlt),
                        _listViewContentGenerator('Email', Icons.mail),
                        _listViewContentGenerator('Şifre', Icons.lock_outline, obsecure: true),
                        _listViewContentGenerator('Tel No', Icons.phone_android),
                        _listViewContentGenerator('Cinsiyet', FontAwesomeIcons.transgenderAlt,),
                        _listViewContentGenerator('Yaş', Icons.cake_outlined),
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
                      onPressed: () {},
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
