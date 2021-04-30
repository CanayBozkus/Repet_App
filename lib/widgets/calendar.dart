import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:repetapp/utilities/extensions.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/calendar_bottomsheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    AppLocalizations localized = AppLocalizations.of(context);
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
        titleTextBuilder: (DateTime date, value){
          switch(date.month){
            case 1: return '${localized.january} ${date.year}';
            case 2: return '${localized.february} ${date.year}';
            case 3: return '${localized.march} ${date.year}';
            case 4: return '${localized.april} ${date.year}';
            case 5: return '${localized.may} ${date.year}';
            case 6: return '${localized.june} ${date.year}';
            case 7: return '${localized.july} ${date.year}';
            case 8: return '${localized.august} ${date.year}';
            case 9: return '${localized.september} ${date.year}';
            case 10: return '${localized.october} ${date.year}';
            case 11: return '${localized.november} ${date.year}';
            case 12: return '${localized.december} ${date.year}';
            default: return "";
          }
        }
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        dowTextBuilder: (DateTime date, value){
          switch(date.weekday){
            case 1: return localized.mon;
            case 2: return localized.tue;
            case 3: return localized.wed;
            case 4: return localized.thu;
            case 5: return localized.fri;
            case 6: return localized.sat;
            case 7: return localized.sun;
          }
          return "";
        }
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
