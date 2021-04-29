import 'package:flutter/material.dart';
import 'package:repetapp/l10n/l10n.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/utilities/general_provider_data.dart';

class LanguageSettings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(AppLocalizations.supportedLocales[0].toLanguageTag());
    return Container(
      child: ListView.builder(
        itemCount: L10n.all.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text(
              L10n.languages[L10n.all[index].toLanguageTag()],
            ),
            onTap: (){
              context.read<GeneralProviderData>().setLocale(L10n.all[index]);
            },
          );
        },
      ),
    );
  }
}
