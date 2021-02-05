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
            padding: EdgeInsets.all(width * 0.04),
            child: DefaultElevation(
              child: Container(
                padding: EdgeInsets.all(width * 0.02),
                color: Colors.white,
                child: Calendar(),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.04),
              child: DefaultElevation(
                child: Container(
                  width: double.infinity,
                  color: Colors.white,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.05, vertical: height * 0.025),
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '9 Nisan',
                          ),
                          Container(
                            height: height * 0.03,
                            width: width * 0.2,
                            color: Colors.green,
                          ),
                        ],
                      ),
                      CalendarDetailRow(
                        width: width,
                        checkBoxValue: checkBoxValue,
                        height: height,
                        todoText: 'Veteriner Aylık Kontrolü',
                        hour: '14.00',
                      ),
                      CalendarDetailRow(
                        width: width,
                        checkBoxValue: checkBoxValue,
                        height: height,
                        todoText: 'Kış için Mont alınması',
                        hour: 'Tüm Gün',
                      ),
                    ],
                  ),
                ),
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
