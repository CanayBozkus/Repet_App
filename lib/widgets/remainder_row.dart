import 'package:flutter/material.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';

class RemainderRow extends StatelessWidget {
  RemainderRow({this.svg, this.mainText, this.svgColor, this.onTap});
  final String svg;
  final String mainText;
  final Color svgColor;
  final Function onTap;

  double calculateDailyPercentage(Map routine){
    int countOpens = 0;
    int countTimes = 0;
    DateTime currentTime = DateTime.now();
    for(var key in routine.keys){
      List time = key.toString().split(':');
      if(routine[key]){
        countOpens +=1;
        if(int.parse(time[0]) < currentTime.hour && int.parse(time[1]) < currentTime.minute){
          countTimes +=1;
        }
      }
    }

    return countOpens != 0 ? countTimes/countOpens : 0;
  }

  @override
  Widget build(BuildContext context) {
    final Map routine = context.watch<ProvidedData>().pets[context.read<ProvidedData>().currentShownPetIndex].routines[mainText.toLowerCase()];
    double percentage = calculateDailyPercentage(routine);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Material(
        elevation: 5,
        child: ListTile(
          onTap: onTap,
          leading: SvgPicture.asset(
            svg,
            height: 40,
            color: svgColor,
          ),
          title: Text(
            mainText,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: Text(
            'Günde ' + routine.length.toString() + ' defa',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          trailing: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                routine.containsValue(true) ? Container(
                  padding: EdgeInsets.all(8),
                  height: 50,
                  width: 50,
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
                  child: SvgPicture.asset('assets/icons/clock.svg'),
                ) : SizedBox.shrink(),
                SizedBox(width: 10,),
                Container(
                  height: 50,
                  width: 50,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [Color(0xff79c624), Colors.white],
                      stops: [percentage, 0]
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 2,
                        offset: Offset(0, 1), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Text(
                    '%' + percentage.toInt().toString(),
                    style: TextStyle(

                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/*
Padding(
padding: EdgeInsets.only(bottom: height * 0.03),
child: DefaultElevation(
child: Container(
width: double.infinity,
height: 75.0,
child: Row(
mainAxisAlignment: MainAxisAlignment.spaceAround,
children: [
Expanded(
flex: 2,
child: SvgPicture.asset(
svg,
height: 40,
),
),
Expanded(
flex: 4,
child: Column(
mainAxisAlignment:
MainAxisAlignment.center,
crossAxisAlignment: CrossAxisAlignment.start,
children: [
Text(
mainText,
style: TextStyle(
fontSize: 24,
fontWeight: FontWeight.w800,
),
),
Text(
subText,
style: TextStyle(
fontSize: 14,
),
),
],
),
),
Expanded(
flex: 3,
child: Row(
children: [
Material(
elevation: 3,
child: Container(
padding: EdgeInsets.all(8),
height: 50,
width: 50,
child: SvgPicture.asset('assets/icons/clock.svg'),
),
),
SizedBox(
width: width * 0.02,
),
Container(
height: 50,
width: 50,
alignment: Alignment.center,
color: Color(0xffffdf00),
child: Text(
'0',
style: TextStyle(
color: Colors.white,
fontSize: height * 0.05,
),
),
),
],
),
),
],
),
),
),
)
*/