import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/button_leading_svg.dart';
import 'package:repetapp/widgets/double_circle_background.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: Text(
                        'Hoşgeldiniz',
                        style: TextStyle(
                          fontSize: 30.0,
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: kPrimaryColor),
                      child: TextField(
                        style: kTextFieldLabelStyle,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.mail_outline),
                        ),
                        onSubmitted: (value) {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Theme(
                      data: Theme.of(context)
                          .copyWith(primaryColor: kPrimaryColor),
                      child: TextField(
                        obscureText: true,
                        style: kTextFieldLabelStyle,
                        decoration: kTextFieldDecoration.copyWith(
                          labelText: 'Password',
                          prefixIcon: Icon(Icons.lock_outline),
                        ),
                        onSubmitted: (value) {},
                      ),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Şifremi Unuttum?',
                    ),
                  ),
                  FlatButton(
                    color: kPrimaryColor,
                    padding: EdgeInsets.symmetric(vertical: 15.0),
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
                  Text(
                    'Hesabın yok mu? Kayıt Ol',
                  ),
                  Text(
                    'Diğer Oturum Açma Yöntemleri',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonLeadingSvg(
                        width: width*0.35,
                        svg: 'assets/icons/iconmonstr-facebook-1.svg',
                        label: 'Facebook',
                        color: Color(0xff345ea1),
                        onPressed: () {},
                      ),
                      ButtonLeadingSvg(
                        width: width*0.35,
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
