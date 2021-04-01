import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
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

class RemindersBottomSheet extends StatefulWidget {
  final Remainders reminder;

  RemindersBottomSheet(this.reminder);

  @override
  _RemindersBottomSheetState createState() => _RemindersBottomSheetState();
}

class _RemindersBottomSheetState extends State<RemindersBottomSheet> {
  bool addNew = false;
  bool isEditing = false;
  int currentFocusedReminder;
  int hour = 0;
  int min = 0;
  bool isActive = true;
  ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    final pet = context
        .read<GeneralProviderData>()
        .pets[context.read<GeneralProviderData>().currentShownPetIndex];
    final List routine =
        pet.routines[remainderTitles[widget.reminder].toLowerCase()];

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
                  remainderTitles[widget.reminder],
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
                  if (!isEditing) {
                    setState(() {
                      addNew = true;
                    });
                  }
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
                                  hourOnChanged: (value) => hour = value,
                                  minuteOnChanged: (value) => min = value,
                                  center: true,
                                  initialValues: isEditing
                                      ? {
                                          "hour": routine
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  currentFocusedReminder)
                                              .time
                                              .hour,
                                          "minute": routine
                                              .firstWhere((element) =>
                                                  element.id ==
                                                  currentFocusedReminder)
                                              .time
                                              .minute,
                                        }
                                      : null,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
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
                                          widget.reminder,
                                          currentFocusedReminder,
                                        );
                                      }
                                      setState(() {
                                        currentFocusedReminder = null;
                                        this.isActive = true;
                                        this.hour = 0;
                                        this.min = 0;
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
                                      DateTime time = DateTime(now.year,
                                          now.month, now.day, hour, min, 0);
                                      if (isEditing) {
                                        await Provider.of<GeneralProviderData>(
                                          context,
                                          listen: false,
                                        ).updateReminder(
                                          pet,
                                          widget.reminder,
                                          currentFocusedReminder,
                                          {
                                            "newTime": time,
                                            "isActive": isActive
                                          },
                                        );
                                      } else {
                                        await Provider.of<GeneralProviderData>(
                                          context,
                                          listen: false,
                                        ).addNewRemainder(
                                          pet,
                                          widget.reminder,
                                          time,
                                          isActive,
                                        );
                                      }
                                      setState(() {
                                        currentFocusedReminder = null;
                                        this.isActive = true;
                                        this.hour = 0;
                                        this.min = 0;
                                        isEditing = false;
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
                  onLongPress: () {
                    if (!addNew) {
                      setState(() {
                        isEditing = true;
                        isActive = element.isActive;
                        this.hour = elementTime.hour;
                        this.min = elementTime.minute;
                        currentFocusedReminder = element.id;
                      });
                    }
                  },
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
                              await Provider.of<GeneralProviderData>(context,
                                      listen: false)
                                  .updateRemainderStatus(
                                pet,
                                element,
                                widget.reminder,
                                value,
                              );
                            } else {
                              //routine[id][1] = value;
                              await Provider.of<GeneralProviderData>(context,
                                      listen: false)
                                  .updateRemainderStatus(
                                pet,
                                element,
                                widget.reminder,
                                value,
                              );
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
  }
}
