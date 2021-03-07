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
class Calendar extends StatefulWidget {
  final Function onDaySelected;
  Calendar({this.onDaySelected(DateTime date, List<dynamic> events, List<dynamic> holidays)});

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
      onDaySelected: (DateTime date, List<dynamic> events, List<dynamic> holidays){
        bool _addNew = false;
        ScrollController controller = ScrollController();
        final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
        bool _isAdding = false;
        int hour=0;
        int min=0;
        String event;
        DateTime key = DateTime(date.year, date.month, date.day, 0, 0, 0);
        bool isExist = context.read<GeneralProviderData>().calendar.eventCollections.keys.contains(key);
        showModalBottomSheet(
          isScrollControlled: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          context: context,
          builder: (context){
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: StatefulBuilder(
                builder: (BuildContext context, StateSetter setState){
                  return Container(
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
                              _addNew ? Padding(
                                padding: EdgeInsets.symmetric(vertical: 4),
                                child: BaseShadow(
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                    child: Column(
                                      children: [
                                        Form(
                                          key: _formKey,
                                          child: FormGenerator.addInput(
                                            label: 'Task',
                                            onsaved: (value){
                                                event = value;
                                              },
                                            validator: (String value){
                                              if(value.isEmpty){
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
                                          child: TimeSelector(hourOnChanged: (value) => hour = value, minuteOnChanged: (value) => min = value, center: true,),
                                        ),
                                        SizedBox(height: 15,),
                                        _isAdding ? Spinner() : Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            BaseButton(
                                              width: 80,
                                              fontSize: 13,
                                              text: 'Delete',
                                              onPressed: (){
                                                databaseManager.deleteAllCalendar();
                                              },
                                              backgroundColor: kColorRed,
                                            ),
                                            SizedBox(width: 10,),
                                            BaseButton(
                                              width: 80,
                                              fontSize: 13,
                                              text: 'Done',
                                              onPressed: (){
                                                setState((){
                                                  if(_formKey.currentState.validate()){
                                                    _isAdding = true;
                                                    _addNew = false;
                                                    _formKey.currentState.save();
                                                    DateTime eventDate = DateTime(date.year, date.month, date.day, hour, min, 0);
                                                    context.read<GeneralProviderData>().addEvent(event, eventDate);
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
                              ) : SizedBox.shrink(),
                              ...events = isExist ? context.watch<GeneralProviderData>().calendar.eventCollections[key].map((eventData){
                                DateTime date = eventData['date'];
                                return Padding(
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: BaseShadow(
                                      child: ListTile(
                                        title: Text(
                                          eventData['event'],
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w400
                                          ),
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
                                          onChanged: (value){
                                            context.read<GeneralProviderData>().updateEventStatus(date, value);
                                          },
                                        ),
                                      )
                                  ),
                                );
                              }).toList() : [SizedBox.shrink()],
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),
            );
          },
        );
      },
      onVisibleDaysChanged: (DateTime containerStartDate, DateTime containerEndDate, CalendarFormat format){

      },
      events: context.watch<GeneralProviderData>().calendar.eventCollections,
      holidays: {DateTime(2020, 12, 4): ['tesst', Colors.indigoAccent], DateTime(2020, 12, 3): ['tesst1', Colors.orange]},
      calendarStyle: CalendarStyle(

      ),
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
