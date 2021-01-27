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
      borderRadius: BorderRadius.all(Radius.circular(10)),
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
            filled: true,
            fillColor: Colors.white,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5
              ),
            ),
            focusColor: kPrimaryColor,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: kPrimaryColor,
              ),
            ),
          ),
          keyboardType: keyBoards[keyboardType],
          onChanged: onChanged,
        ),
      ),
    );
  }
}
