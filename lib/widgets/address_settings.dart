
import 'package:flutter/material.dart';
import 'package:repetapp/utilities/form_generator.dart';

class AddressSettings extends StatelessWidget {
  FormGenerator _formGenerator = FormGenerator();
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          Container(
            height: 80,
            padding: EdgeInsets.only(left: 45),
            alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 2,
                  blurRadius: 5,
                  offset: Offset(0, -2), // changes position of shadow
                ),
              ],
            ),
            child: Text(
              'Address',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xff636363),
              ),
            ),
          ),
          Expanded(
            child: _formGenerator.addressForm(),
          ),
        ],
      ),
    );
  }
}
