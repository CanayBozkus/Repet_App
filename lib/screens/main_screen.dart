import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repetapp/screens/error_screen.dart';
import 'package:repetapp/services/notification_plugin.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/reminders_bottomsheet.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/pet_navigator.dart';
import 'package:repetapp/widgets/remainder_row.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:repetapp/widgets/time_selector.dart';
import 'package:repetapp/utilities/extensions.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


class MainScreen extends StatefulWidget {
  static const routeName = 'MainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _openBottomSheet({
    Remainders remainder,
  }) {
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) => RemindersBottomSheet(remainder),
    );
  }

  Future<bool> getMainScreenData() async {
    if (context.read<GeneralProviderData>().isMainScreenDataFetched) {
      return true;
    }
    try {
      await context.read<GeneralProviderData>().getMainScreenData();
      return true;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future<bool> _isLoading;
  @override
  void initState() {
    _isLoading = getMainScreenData();
    context.read<GeneralProviderData>().currentUser.setNotificationSettings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(context.read<GeneralProviderData>().locale);
    return Scaffold(
      appBar: BaseAppBar(
        title: AppLocalizations.of(context).language,
        context: context,
      ),
      body: FutureBuilder(
        builder: (context, snapshots) {
          if (snapshots.connectionState == ConnectionState.none &&
              snapshots.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return ErrorScreen();
          } else if (snapshots.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Padding(
            padding: generalScreenPadding,
            child: Column(
              children: [
                PetNavigator(
                  showDetail: true,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                    ),
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                      children: [
                        ...Remainders.values.map((remainder) {
                          return RemainderRow(
                            remainder: remainder,
                            onTap: () {
                              _openBottomSheet(remainder: remainder);
                            },
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        future: _isLoading,
      ),
      bottomNavigationBar: BaseBottomBar(
        pageNumber: 1,
      ),
    );
  }
}
