import 'package:flutter/material.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    for(var id in routine.keys){
      List time = routine[id][0].split(':');
      if(routine[id][1]){
        countOpens +=1;
        DateTime notfTime = DateTime(currentTime.year, currentTime.month, currentTime.day, int.parse(time[0]), int.parse(time[1]), 0);
        if(notfTime.isBefore(currentTime)){
          countTimes +=1;
        }
      }
    }
    return countOpens != 0 ? countTimes/countOpens : 0;
  }

  bool checkAlarms(routine){
    for(var id in routine.keys){
      if(routine[id][1]){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Map routine = context.watch<ProvidedData>().pets[context.read<ProvidedData>().currentShownPetIndex].routines[mainText.toLowerCase()];
    double percentage = calculateDailyPercentage(routine);
    bool hasAlarm = checkAlarms(routine);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: BaseShadow(
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
                hasAlarm ? Container(
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
                    '%' + (percentage*100).toInt().toString(),
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