
import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';

import 'default_elevation.dart';

class Help extends StatelessWidget {
  final FormGenerator _formGenerator = FormGenerator();
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
              'Yardım',
              style: TextStyle(
                fontSize: 30,
                color: Color(0xff636363),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                DefaultElevation(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 45, right: 15),
                    title: Text(
                      'Giriş Yapamıyorum',
                      style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                  ),
                ),
                DefaultElevation(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 45, right: 15),
                    title: Text(
                      'Kullanıcı adımı değiştiremiyorum',
                      style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                  ),
                ),
                DefaultElevation(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 45, right: 15),
                    title: Text(
                      'Çıkış Yapamıyorum',
                      style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                  ),
                ),
                DefaultElevation(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 45, right: 15),
                    title: Text(
                      'Başka Evcil Hayvan ekleyemiyorum',
                      style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                  ),
                ),
                DefaultElevation(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 45, right: 15),
                    title: Text(
                      'Adres Değişikliği',
                      style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                  ),
                ),
                DefaultElevation(
                  child: ListTile(
                    contentPadding: EdgeInsets.only(left: 45, right: 15),
                    title: Text(
                      'Sıkça Sorulan Sorular',
                      style: TextStyle(
                          fontWeight: FontWeight.w500
                      ),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: kPrimaryColor,),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
