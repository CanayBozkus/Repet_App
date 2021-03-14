import 'package:flutter/cupertino.dart';

class TimeSelector extends StatelessWidget {
  TimeSelector({this.hourOnChanged(int), this.minuteOnChanged(int), this.center = false});
  final Function hourOnChanged;
  final Function minuteOnChanged;
  final bool center;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          Container(
            width: 60,
            child: CupertinoPicker(
              itemExtent: 50,
              onSelectedItemChanged: hourOnChanged,
              children: [
                ...List<int>.generate(24, (i) => i).map((e){
                  return Center(
                    child: Text(
                      e.toString(),
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                })
              ],
            ),
          ),
          Text(
            ':',
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.w400,
            ),
          ),
          Container(
            width: 60,
            child: CupertinoPicker(
              itemExtent: 50,
              onSelectedItemChanged: minuteOnChanged,
              children: [
                ...List<int>.generate(60, (i) => i).map((e){
                  return Center(
                    child: Text(
                      e.toString(),
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
