import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/double_circle_background.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: DoubleCircleBackground(
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.1,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(primaryColor: kPrimaryColor),
                  child: TextField(
                    style: TextStyle(
                        color: kPrimaryColor, decoration: TextDecoration.none),
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.mail_outline),
                    ),
                    onSubmitted: (value) {},
                  ),
                ),
                Theme(
                  data: Theme.of(context).copyWith(primaryColor: kPrimaryColor),
                  child: TextField(
                    obscureText: true,
                    style: TextStyle(
                      color: kPrimaryColor,
                    ),
                    decoration: kTextFieldDecoration.copyWith(
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_outline),
                    ),
                    onSubmitted: (value) {},
                  ),
                ),
                Text(
                  'Şifremi Unuttum?',

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
