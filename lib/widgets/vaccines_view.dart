import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

import 'base_checkbox.dart';

class VaccinesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20),
      children: [
        ...vaccines.map((e){
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: Offset(0, 0), // changes position of shadow
                  ),
                ],
              ),
              child: ListTile(
                title: Text(
                  e,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '22.10.2020',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: BaseCheckBox(
                  color: kColorGreen,
                  value: true,
                  onChanged: (){},
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
