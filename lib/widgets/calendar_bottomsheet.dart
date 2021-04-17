import 'package:flutter/material.dart';
import 'package:repetapp/models/calendar_model.dart';
import 'package:repetapp/services/database.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/base_checkbox.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:repetapp/widgets/spinner.dart';
import 'package:repetapp/widgets/time_selector.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:repetapp/utilities/extensions.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/utilities/extensions.dart';

class CalendarBottomSheet extends StatefulWidget {
  DateTime date;
  List<dynamic> events;
  List<dynamic> holidays;

  CalendarBottomSheet(
      {@required this.date, @required this.events, @required this.holidays});

  @override
  _CalendarBottomSheetState createState() => _CalendarBottomSheetState();
}
/*
  This widget will have three states based on editing and adding modes.

  EDIT ADD  /   STATE
  0     0   /   -> Display: Just display the events
  0     1   /   -> Add: Display events and TimeSelector for adding a new event.
  1     0   /   -> Edit: Display events and TimeSelector for editing an existing event.
  1     1   /   -> ILLEGAL: This widget should never be in this state.

*/

class _CalendarBottomSheetState extends State<CalendarBottomSheet> {
  bool _addNew = false;
  ScrollController controller = ScrollController();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  bool _isAdding = false;
  int hour = 0;
  int min = 0;
  String event;

  @override
  Widget build(BuildContext context) {
    DateTime key =
        DateTime(widget.date.year, widget.date.month, widget.date.day, 0, 0, 0);
    bool isExist = context
        .read<GeneralProviderData>()
        .calendar
        .eventCollections
        .keys
        .contains(key);
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Container(
        height: 500,
        child: Column(
          children: [
            Container(
              height: 70,
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
                      '${widget.date.day} ${widget.date.getMonthName()} ${widget.date.year}',
                      style: TextStyle(
                        fontSize: 24,
                        color: kPrimaryColor,
                        fontWeight: FontWeight.w800,
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
                        _addNew = true;
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
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                children: [
                  _addNew
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: BaseShadow(
                            child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Column(
                                children: [
                                  Form(
                                    key: _formKey,
                                    child: FormGenerator.addInput(
                                      label: 'Task',
                                      onsaved: (value) {
                                        event = value;
                                      },
                                      validator: (String value) {
                                        if (value.isEmpty) {
                                          return 'No task entered.';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    height: 90,
                                    width: double.infinity,
                                    child: TimeSelector(
                                      hourOnChanged: (value) => hour = value,
                                      minuteOnChanged: (value) => min = value,
                                      center: true,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 15,
                                  ),
                                  _isAdding
                                      ? Spinner()
                                      : Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            BaseButton(
                                              width: 80,
                                              fontSize: 13,
                                              text: 'Delete',
                                              onPressed: () {
                                                databaseManager
                                                    .deleteAllCalendar();
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
                                              onPressed: () {
                                                setState(() {
                                                  if (_formKey.currentState
                                                      .validate()) {
                                                    _isAdding = true;
                                                    _addNew = false;
                                                    _formKey.currentState
                                                        .save();
                                                    DateTime eventDate =
                                                        DateTime(
                                                            widget.date.year,
                                                            widget.date.month,
                                                            widget.date.day,
                                                            hour,
                                                            min,
                                                            0);
                                                    context
                                                        .read<
                                                            GeneralProviderData>()
                                                        .addEvent(
                                                            event, eventDate);
                                                    //TODO: ekleme kısmı
                                                    _isAdding = false;
                                                  }
                                                });
                                              },
                                              backgroundColor: kColorGreen,
                                            ),
                                          ],
                                        )
                                ],
                              ),
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  ...widget.events = isExist
                      ? context
                          .watch<GeneralProviderData>()
                          .calendar
                          .eventCollections[key]
                          .map((eventData) {
                          DateTime date = eventData['date'];
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 5),
                            child: BaseShadow(
                                child: ListTile(
                              title: Text(
                                eventData['event'],
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.w400),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                date.getHourAndMinuteString(),
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: BaseCheckBox(
                                value: eventData['isDone'] ?? false,
                                color: Color(0xff79c624),
                                onChanged: (value) {
                                  context
                                      .read<GeneralProviderData>()
                                      .updateEventStatus(date, value);
                                },
                              ),
                            )),
                          );
                        }).toList()
                      : [SizedBox.shrink()],
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
