import 'package:flutter/material.dart';
import 'package:repetapp/models/calendar_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:repetapp/widgets/calendar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/vaccines_view.dart';

import 'error_screen.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = 'CalendarScreen';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool checkBoxValue = true;
  Future<bool> _isLoading;
  bool _isCalendar = true;
  Future<bool> getCalendarData() async {
    if(!context.read<ProvidedData>().calendar.isDataFetch){
      await context.read<ProvidedData>().getCalendarData();
    }
    return true;
  }

  @override
  void initState() {
    _isLoading = getCalendarData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                child: BaseShadow(
                  child: Container(
                    padding: EdgeInsets.all(5),
                    color: Colors.white,
                    child: _isCalendar ? Calendar() : VaccinesView(),
                  ),
                ),
              ),
              Positioned(
                top: 3,
                right: 20,
                child: BaseShadow(
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
        width: width,
        pageNumber: 2,
      ),
    );
  }
}
