import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

class BaseInputField extends StatelessWidget {
  BaseInputField(
      {this.label,
      this.obsecure,
      this.onChanged,
      this.keyboardType = KeyboardTypes.text});

  final String label;
  final bool obsecure;
  final Function onChanged;
  final keyboardType;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Material(
      elevation: 5,
      borderRadius: BorderRadius.all(Radius.circular(5)),
      child: Container(
        height: height * 0.09,
        child: TextField(
          obscureText: obsecure == null ? false : true,
          style: kTextFieldLabelStyle.copyWith(fontSize: height * 0.03),
          decoration: InputDecoration(
            labelText: label ?? 'Email',
            labelStyle: TextStyle(
              color: Color(0xffd0d0d0),
              fontWeight: FontWeight.w500,
              fontSize: 18.0,
            ),
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            focusColor: kPrimaryColor,
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: kPrimaryColor),
              borderRadius: BorderRadius.all(Radius.circular(5)),
            ),
          ),
          keyboardType: keyBoards[keyboardType],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
