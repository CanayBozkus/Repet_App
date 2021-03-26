import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repetapp/screens/error_screen.dart';
import 'package:repetapp/services/notification_plugin.dart';
import 'package:repetapp/utilities/constants.dart';
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

class MainScreen extends StatefulWidget {
  static const routeName = 'MainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _openBottomSheet({
    Remainders remainder,
  }) {
    final pet = context
        .read<GeneralProviderData>()
        .pets[context.read<GeneralProviderData>().currentShownPetIndex];
    final List routine = pet.routines[remainderTitles[remainder].toLowerCase()];
    bool addNew = false;
    bool isEditing = false;
    int currentFocusedReminder = -99;
    int hour = 0;
    int min = 0;
    bool isActive = true;
    ScrollController controller = ScrollController();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              children: [
                Container(
                  height: 80,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.grey.shade300,
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      FlatButton(
                        shape: CircleBorder(),
                        child: Container(
                          child: Icon(
                            Icons.close,
                            size: 36,
                          ),
                          padding: EdgeInsets.all(4),
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.zero,
                      ),
                      Expanded(
                        child: Text(
                          remainderTitles[remainder],
                          style: TextStyle(
                            fontSize: 20,
                            color: kPrimaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FlatButton(
                        shape: CircleBorder(),
                        child: Container(
                          child: Icon(
                            Icons.add,
                            size: 36,
                            color: kPrimaryColor,
                          ),
                          padding: EdgeInsets.all(4),
                        ),
                        onPressed: () {
                          controller.jumpTo(0);
                          setState(() {
                            addNew = true;
                          });
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: controller,
                    children: [
                      addNew || isEditing
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Stack(
                                children: [
                                  Column(
                                    children: [
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Container(
                                        alignment: Alignment.center,
                                        width: double.maxFinite,
                                        height: 90,
                                        child: TimeSelector(
                                          hourOnChanged: (value) =>
                                              hour = value,
                                          minuteOnChanged: (value) =>
                                              min = value,
                                          center: true,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          BaseButton(
                                            width: 80,
                                            fontSize: 13,
                                            text: 'Delete',
                                            onPressed: () async {
                                              if (isEditing) {
                                                // TODO: Add logic for removing a reminder.
                                                Provider.of<GeneralProviderData>(
                                                        context,
                                                        listen: false)
                                                    .removeReminder(
                                                  pet,
                                                  remainder,
                                                  currentFocusedReminder,
                                                );
                                              }
                                              setState(() {
                                                isEditing = false;
                                                addNew = false;
                                              });
                                            },
                                            backgroundColor: kColorRed,
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          BaseButton(
                                            width: 80,
                                            fontSize: 13,
                                            text: 'Done',
                                            onPressed: () async {
                                              DateTime now = DateTime.now();
                                              DateTime time = DateTime(
                                                  now.year,
                                                  now.month,
                                                  now.day,
                                                  hour,
                                                  min,
                                                  0);
                                              // should be updateRemainder if isEditing true
                                              await Provider.of<
                                                          GeneralProviderData>(
                                                      context,
                                                      listen: false)
                                                  .addNewRemainder(
                                                      pet,
                                                      remainder,
                                                      time,
                                                      isActive);
                                              setState(() {
                                                addNew = false;
                                              });
                                            },
                                            backgroundColor: kColorGreen,
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Positioned(
                                    right: 0,
                                    child: Switch(
                                      value: isActive,
                                      onChanged: (value) {
                                        setState(() {
                                          isActive = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            )
                          : SizedBox.shrink(),
                      ...routine.map((element) {
                        DateTime elementTime = element.time;
                        return InkWell(
                          onLongPress: () => setState(() {
                            if (!addNew) {
                              isEditing = true;
                              currentFocusedReminder = element.id;
                            }
                          }),
                          child: Container(
                            height: 70,
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                  width: 1,
                                ),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  elementTime.getHourAndMinuteString(),
                                  style: TextStyle(
                                    fontSize: 36,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                Switch(
                                  value: element.isActive,
                                  onChanged: (value) async {
                                    if (value) {
                                      await Provider.of<GeneralProviderData>(
                                              context,
                                              listen: false)
                                          .updateRemainderStatus(
                                              pet, element, remainder, value);
                                    } else {
                                      //routine[id][1] = value;
                                      await Provider.of<GeneralProviderData>(
                                              context,
                                              listen: false)
                                          .updateRemainderStatus(
                                              pet, element, remainder, value);
                                    }
                                    setState(() {});
                                  },
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
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
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Hatırlatıcı',
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
