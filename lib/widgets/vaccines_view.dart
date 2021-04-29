import 'package:flutter/material.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:provider/provider.dart';

import 'base_checkbox.dart';

class VaccinesView extends StatefulWidget {
  @override
  _VaccinesViewState createState() => _VaccinesViewState();
}

class _VaccinesViewState extends State<VaccinesView> {
  @override
  Widget build(BuildContext context) {
    final vaccines =
        context.watch<GeneralProviderData>().vaccinesModel.vaccines;
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20),
      children: [
        ...vaccines.map((e) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: BaseShadow(
              child: ListTile(
                title: Text(
                  e.name,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                subtitle: Text(
                  '22.10.2020',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: BaseCheckBox(
                  color: kColorGreen,
                  value: true,
                  onChanged: () {},
                ),
              ),
            ),
          );
        }).toList(),
      ],
    );
  }
}
