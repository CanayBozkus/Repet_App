import 'package:flutter/material.dart';
import 'package:repetapp/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:repetapp/widgets/base_shadow.dart';

class LanguageSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 30),
        itemCount: L10n.all.length,
        itemBuilder: (BuildContext context, int index){
          return BaseShadow(
            child: ListTile(
              title: Text(
                L10n.languages[L10n.all[index].toLanguageTag()],
                style: kProfileBuilderTextStyle,
              ),
              onTap: (){
                context.read<GeneralProviderData>().setLocale(L10n.all[index]);
                Navigator.pop(context);
              },
            ),
          );
        },
      ),
    );
  }
}
