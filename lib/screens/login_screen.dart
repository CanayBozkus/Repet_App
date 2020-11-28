import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/button_leading_svg.dart';
import 'package:repetapp/widgets/custom_input_field.dart';
import 'package:repetapp/widgets/double_circle_background.dart';


class LoginScreen extends StatelessWidget {
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
                    height: height * 0.15,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Hoşgeldiniz',
                        style: TextStyle(
                          fontSize: height * 0.05,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .2,
                  ),
                  CustomInputField(
                    label: 'Email',
                    icon: Icons.mail_outline,
                    onSubmitted: (value) {},
                  ),
                  SizedBox(
                    height: height * .04,
                  ),
                  CustomInputField(
                    label: 'Password',
                    icon: Icons.lock_outline,
                    onSubmitted: (value) {},
                    obsecure: true,
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Text(
                    'Şifremi Unuttum?',
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Material(
                    shadowColor: Colors.grey.shade400,
                    elevation: 10,
                    child: FlatButton(
                      color: kPrimaryColor,
                      padding: EdgeInsets.symmetric(vertical: 10.0),
                      minWidth: double.infinity,
                      child: Text(
                        'Giriş Yap',
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
                        text: 'Hesabın yok mu?  ',
                        style: kDefaultTextStyle,
                        children: [
                          TextSpan(
                            text: 'Kayıt Ol',
                            style:
                                kDefaultTextStyle.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Container(
                    width: double.infinity,
                    child: Text(
                      'Diğer Oturum Açma Yöntemleri',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(
                    height: height * .02,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonLeadingSvg(
                        width: width * 0.35,
                        svg: 'assets/icons/iconmonstr-facebook-1.svg',
                        label: 'Facebook',
                        color: Color(0xff345ea1),
                        onPressed: () {},
                      ),
                      ButtonLeadingSvg(
                        width: width * 0.35,
                        svg: 'assets/icons/google.svg',
                        label: 'Google',
                        onPressed: () {},
                        color: Color(0xffdb3522),
                      ),
                    ],
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
