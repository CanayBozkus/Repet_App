import 'package:flutter/material.dart';
import 'package:repetapp/models/calendar_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/calendar.dart';
import 'package:repetapp/widgets/calendar_detail_row.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';

class CalendarScreen extends StatefulWidget {
  static const routeName = 'CalendarScreen';

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  bool checkBoxValue = true;
  CalendarModel calendar;
  @override
  void initState() {
    if(!context.read<ProvidedData>().calendar.isDataFetch){
      context.read<ProvidedData>().getCalendar();
    }
    calendar = context.read<ProvidedData>().calendar;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: BaseAppBar(title: 'Takvim', context: context,),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: DefaultElevation(
              child: Container(
                padding: EdgeInsets.all(5),
                color: Colors.white,
                child: Calendar(),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 2,
      ),
    );
  }
}
