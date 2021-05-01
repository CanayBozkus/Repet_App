import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Help extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AppLocalizations localized = AppLocalizations.of(context);
    return Container(
      padding: EdgeInsets.only(top: 20),
      child: Column(
        children: [
          BaseShadow(
            child: Container(
              height: 80,
              padding: EdgeInsets.only(left: 45),
              alignment: Alignment.centerLeft,
              child: Text(
                localized.help,
                style: TextStyle(
                  fontSize: 30,
                  color: Color(0xff636363),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                BaseShadow(
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
                BaseShadow(
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
                BaseShadow(
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
                BaseShadow(
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
                BaseShadow(
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
                BaseShadow(
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
