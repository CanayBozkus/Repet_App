import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/calendar.dart';
import 'package:repetapp/widgets/calendar_detail_row.dart';
import 'package:repetapp/widgets/circular_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/widgets/double_circle_background.dart';

class CalendarScreen extends StatelessWidget {
  static const routeName = 'CalendarScreen';
  bool checkBoxValue = true;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Takvim',
        ),
        actions: [
          Icon(
            Icons.menu,
          ),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
      body: DoubleCircleBackground(
        child: Column(
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
      ),
      bottomNavigationBar: CircularBottomBar(
        height: height,
        width: width,
        pageNumber: 2,
      ),
    );
  }
}
