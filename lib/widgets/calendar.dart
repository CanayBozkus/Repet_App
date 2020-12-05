import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      events: {DateTime(2020, 12, 4): ['tesst', Colors.indigoAccent], DateTime(2020, 12, 3): ['tesst1', Colors.orange]},
      calendarStyle: CalendarStyle(

      ),
      headerStyle: HeaderStyle(
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
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Positioned(
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: events[1],
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
            );
          }
          return children;
        },
      ),
      calendarController: _calendarController,
    );
  }
}
