import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/default_elevation.dart';

class PersonalSettings extends StatelessWidget {
  const PersonalSettings({
    Key key,
  }) : super(key: key);

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
          DefaultElevation(
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/account.svg',
                height: 25,
                color: kPrimaryColor,
              ),
              title: Text(
                'Mehmet Özgün',
                style: TextStyle(
                    fontWeight: FontWeight.w500
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          DefaultElevation(
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/email.svg',
                height: 20,
                color: kPrimaryColor,
              ),
              title: Text(
                'mehmet.ozgun@gmail.com',
                style: TextStyle(
                    fontWeight: FontWeight.w500
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          DefaultElevation(
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/cellphone.svg',
                height: 30,
                color: kPrimaryColor,
              ),
              title: Text(
                '+905552431183',
                style: TextStyle(
                    fontWeight: FontWeight.w500
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          DefaultElevation(
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/cake.svg',
                height: 25,
                color: kPrimaryColor,
              ),
              title: Text(
                '03.07.1973',
                style: TextStyle(
                    fontWeight: FontWeight.w500
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
          DefaultElevation(
            child: ListTile(
              leading: SvgPicture.asset(
                'assets/icons/gender.svg',
                height: 25,
                color: kPrimaryColor,
              ),
              title: Text(
                'Erkek',
                style: TextStyle(
                    fontWeight: FontWeight.w500
                ),
              ),
              trailing: Icon(Icons.arrow_forward_ios),
            ),
          ),
        ],
      ),
    );
  }
}