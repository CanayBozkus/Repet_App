import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFFFDA15A);

const kTextFieldDecoration = InputDecoration(
  labelText: 'Email',
  labelStyle: TextStyle(
    color: Color(0xffd0d0d0),
    fontWeight: FontWeight.w500,
    fontSize: 22.0,
  ),
  border: InputBorder.none,
  filled: true,
  fillColor: Colors.white,
  prefixIcon: Icon(
    Icons.mail_outline,
  ),
);
