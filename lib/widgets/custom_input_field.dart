import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({this.label, this.icon, this.obsecure, this.onSubmitted});

  final String label;
  final IconData icon;
  final bool obsecure;
  final Function onSubmitted;
  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.grey.shade400,
      elevation: 5,
      child: Theme(
        data: Theme.of(context)
            .copyWith(primaryColor: kPrimaryColor),
        child: TextField(
          obscureText: obsecure == null ? false : true,
          style: kTextFieldLabelStyle,
          decoration: kTextFieldDecoration.copyWith(
            labelText: label,
            prefixIcon: Icon(icon),
          ),
          onSubmitted: onSubmitted,
        ),
      ),
    );
  }
}
