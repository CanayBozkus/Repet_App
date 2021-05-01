import 'package:flutter/material.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/vaccine_list_item.dart';

import 'base_checkbox.dart';

class VaccinesView extends StatefulWidget {
  @override
  _VaccinesViewState createState() => _VaccinesViewState();
}

class _VaccinesViewState extends State<VaccinesView> {
  @override
  Widget build(BuildContext context) {
    final vaccines = context.read<GeneralProviderData>().vaccinesModel.vaccines;
    return ListView(
      padding: EdgeInsets.symmetric(vertical: 20),
      children: [
        ...vaccines.map((e) {
          return VaccineListItem(
            key: ValueKey(e.docId),
            vaccine: e,
          );
        }).toList(),
      ],
    );
  }
}
