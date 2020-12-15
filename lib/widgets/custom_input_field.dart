import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/default_elevation.dart';

class CustomInputField extends StatelessWidget {
  CustomInputField({this.label, this.icon, this.obsecure, this.onChanged});

  final String label;
  final IconData icon;
  final bool obsecure;
  final Function onChanged;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return DefaultElevation(
      child: Theme(
        data: Theme.of(context)
            .copyWith(primaryColor: kPrimaryColor),
        child: Container(
          height: height*0.09,
          child: TextField(
            obscureText: obsecure == null ? false : true,
            style: kTextFieldLabelStyle.copyWith(fontSize: height*0.03),
            decoration: kTextFieldDecoration.copyWith(
              labelText: label,
              prefixIcon: Icon(icon),
            ),
            onChanged: onChanged,
          ),
        ),
      ),
    );
  }
}
