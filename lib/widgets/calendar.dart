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
import 'package:repetapp/widgets/calendar_bottomsheet.dart';

class Calendar extends StatefulWidget {
  final Function onDaySelected;
  Calendar(
      {this.onDaySelected(
          DateTime date, List<dynamic> events, List<dynamic> holidays)});

  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  Map<DateTime, List<dynamic>> _eventCollections;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      onDaySelected:
          (DateTime date, List<dynamic> events, List<dynamic> holidays) {
        showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          context: context,
          builder: (context) {
            return CalendarBottomSheet(
              date: date,
              events: events,
              holidays: holidays,
            );
          },
        );
      },
      onVisibleDaysChanged: (DateTime containerStartDate,
          DateTime containerEndDate, CalendarFormat format) {},
      events: context.watch<GeneralProviderData>().calendar.eventCollections,
      holidays: {
        DateTime(2020, 12, 4): ['tesst', Colors.indigoAccent],
        DateTime(2020, 12, 3): ['tesst1', Colors.orange]
      },
      calendarStyle: CalendarStyle(),
      headerStyle: HeaderStyle(
        headerPadding: EdgeInsets.only(top: 10, bottom: 20),
        leftChevronVisible: false,
        rightChevronVisible: false,
        centerHeaderTitle: true,
        formatButtonVisible: false,
      ),
      builders: CalendarBuilders(
        todayDayBuilder: (context, date, events) => Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff8ae31b),
          ),
          alignment: Alignment.center,
          child: Text(
            date.day.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
        selectedDayBuilder: (context, date, events) => Container(
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Color(0xff38a5cd),
          ),
          alignment: Alignment.center,
          child: Text(
            date.day.toString(),
            style: TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      ),
      calendarController: _calendarController,
    );
  }
}
