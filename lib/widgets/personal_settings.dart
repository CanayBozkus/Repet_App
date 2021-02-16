import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/utilities/form_generator.dart';

class PersonalSettings extends StatelessWidget {
  FormGenerator _formGenerator = FormGenerator();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 140,
            alignment: Alignment.center,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                CircleAvatar(
                  child: SvgPicture.asset(
                    'assets/icons/profile.svg',
                    height: 70,
                  ),
                  radius: 35,
                ),
                SizedBox(width: 20,),
                Text(
                  'Mehmet Özgün',
                  style: TextStyle(
                    fontSize: 26,
                    color: Color(0xff636363),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: _formGenerator.personalInfoForm(),
          ),
        ],
      ),
    );
  }
}