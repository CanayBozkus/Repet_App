import 'package:flutter/material.dart';
import 'package:repetapp/models/calendar_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_checkbox.dart';
import 'package:repetapp/widgets/calendar.dart';
import 'package:repetapp/widgets/calendar_detail_row.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';

import 'error_screen.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = 'CalendarScreen';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool checkBoxValue = true;
  CalendarModel calendar;
  Future<bool> _isLoading;
  bool _isCalendar = true;
  Future<bool> getCalendarData() async {
    if(!context.read<ProvidedData>().calendar.isDataFetch){
      await context.read<ProvidedData>().getCalendar();
    }
    calendar = context.read<ProvidedData>().calendar;
    return true;
  }

  @override
  void initState() {
    _isLoading = getCalendarData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: BaseAppBar(title: 'Takvim', context: context,),
      body: FutureBuilder(
        builder: (context, snapshots){
          if (snapshots.connectionState == ConnectionState.none &&
              snapshots.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return ErrorScreen();
          }
          else if(snapshots.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                child: DefaultElevation(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    child: _isCalendar ? Calendar() : ListView(
                      padding: EdgeInsets.symmetric(vertical: 20),
                      children: [
                        ...vaccines.map((e){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 3,
                                    offset: Offset(0, 0), // changes position of shadow
                                  ),
                                ],
                              ),
                              child: ListTile(
                                title: Text(
                                  e,
                                  style: TextStyle(
                                    fontSize: 20,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  '22.10.2020',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                trailing: BaseCheckBox(
                                  color: kColorGreen,
                                  value: true,
                                  onChanged: (){},
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 3,
                right: 20,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 3,
                        offset: Offset(0, 0), // changes position of shadow
                      ),
                    ],
                  ),
                  child: FlatButton(
                    minWidth: 60,
                    height: 30,
                    padding: EdgeInsets.zero,
                    onPressed: (){
                      setState(() {
                        _isCalendar = !_isCalendar;
                      });
                    },
                    child: Icon(Icons.calendar_today, color: kPrimaryColor, size: 26,),
                  ),
                ),
              ),
            ],
          );
        },
        future: _isLoading,
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 2,
      ),
    );
  }
}
