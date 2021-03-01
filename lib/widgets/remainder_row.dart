import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';

class RemainderRow extends StatelessWidget {
  RemainderRow({this.onTap, this.remainder});
  final Function onTap;
  final Remainders remainder;

  Map calculateDailyStatus(List routine){
    int countOpens = 0;
    int countTimes = 0;
    DateTime currentTime = DateTime.now();
    for(var instance in routine){
      if(instance.isActive){
        countOpens +=1;
        DateTime notfTime = DateTime(currentTime.year, currentTime.month, currentTime.day, instance.time.hour, instance.time.minute, 0);
        if(notfTime.isBefore(currentTime)){
          countTimes +=1;
        }
      }
    }
    return {'percentage': countOpens != 0 ? countTimes/countOpens : 0.0, 'opens': countOpens, 'hasAlarm': checkAlarms(routine)};
  }

  bool checkAlarms(routine){
    for(var instance in routine){
      if(instance.isActive){
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final List routine = context.watch<ProvidedData>().pets[context.read<ProvidedData>().currentShownPetIndex].routines[remainderTitles[remainder].toLowerCase()];
    Map status = calculateDailyStatus(routine);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: BaseShadow(
        child: ListTile(
          onTap: onTap,
          leading: SvgPicture.asset(
            remainderIcons[remainder],
            height: 40,
            color: remainderSvgColors[remainder],
          ),
          title: Text(
            remainderTitles[remainder],
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w800,
            ),
          ),
          subtitle: Text(
            'Günde ' + status['opens'].toString() + ' defa',
            style: TextStyle(
              fontSize: 14,
            ),
          ),
          trailing: Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                status['hasAlarm'] ? Container(
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
                      stops: [status['percentage'], 0]
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
                    '%' + (status['percentage']*100).toInt().toString(),
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