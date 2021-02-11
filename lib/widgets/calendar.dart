import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_checkbox.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:repetapp/utilities/extensions.dart';
class Calendar extends StatefulWidget {
  final Function onDaySelected;
  Calendar({this.onDaySelected(DateTime date, List<dynamic> events, List<dynamic> holidays)});

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
      onDaySelected: (DateTime date, List<dynamic> events, List<dynamic> holidays){
        showModalBottomSheet(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          context: context,
          builder: (context){
            return Container(
              height: 600,
              child: Column(
                children: [
                  Container(
                    height: 70,
                    child: Row(
                      children: [
                        FlatButton(
                          shape: CircleBorder(),
                          child: Container(
                            child: Icon(Icons.close, size: 36,),
                            padding: EdgeInsets.all(4),
                          ),
                          onPressed: (){
                            Navigator.pop(context);
                          },
                          padding: EdgeInsets.zero,
                        ),
                        Expanded(
                          child: Text(
                            '${date.day} ${date.getMonthName()} ${date.year}',
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
                            child: Icon(Icons.add, size: 36, color: kPrimaryColor,),
                            padding: EdgeInsets.all(4),
                          ),
                          onPressed: (){

                          },
                          padding: EdgeInsets.zero,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 4),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: Column(
                                children: [
                                  FormGenerator().addInput(label: 'Task', onsaved: (value){}, validator: (value){})
                                ],
                              )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: Offset(0, 1), // changes position of shadow
                                ),
                              ],
                            ),
                            child: ListTile(
                              title: Text(
                                'Yeni Mama Alınması',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                '12.00',
                                style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              trailing: BaseCheckBox(
                                value: true,
                                color: Color(0xff79c624),
                                onChanged: (){},
                              ),
                            )
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 5),
                          child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                    offset: Offset(0, 1), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  'Yeni Mama Alınması',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  '12.00',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                trailing: BaseCheckBox(
                                  value: true,
                                  color: Color(0xff79c624),
                                  onChanged: (){},
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
      onVisibleDaysChanged: (DateTime containerStartDate, DateTime containerEndDate, CalendarFormat format){

      },
      events: {DateTime(2020, 12, 4): ['tesst', Colors.indigoAccent], DateTime(2020, 12, 3): ['tesst1', Colors.orange]},
      holidays: {DateTime(2020, 12, 4): ['tesst', Colors.indigoAccent], DateTime(2020, 12, 3): ['tesst1', Colors.orange]},
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
      ),
      calendarController: _calendarController,
    );
  }
}
