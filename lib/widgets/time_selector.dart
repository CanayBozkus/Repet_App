import 'package:flutter/cupertino.dart';

class TimeSelector extends StatelessWidget {
  final Function hourOnChanged;
  final Function minuteOnChanged;
  final bool center;
  final Map<String, int> initialValues;

  var _hourScrollController;
  var _minuteScrollController;

  TimeSelector({
    this.hourOnChanged(int),
    this.minuteOnChanged(int),
    this.center = false,
    this.initialValues,
  }) {
    if (this.initialValues != null) {
      print("${this.initialValues["hour"]} : ${this.initialValues["minute"]}");
    }
    this._hourScrollController = FixedExtentScrollController(
      initialItem: this.initialValues == null ? 0 : this.initialValues["hour"],
    );
    this._minuteScrollController = FixedExtentScrollController(
      initialItem:
          this.initialValues == null ? 0 : this.initialValues["minute"],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment:
            center ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          if (this.initialValues != null)
            Text(
                "${this.initialValues["hour"]} : ${this.initialValues["minute"]}"),
          Container(
            width: 60,
            child: CupertinoPicker(
              scrollController: this._hourScrollController,
              itemExtent: 50,
              onSelectedItemChanged: hourOnChanged,
              children: [
                ...List<int>.generate(24, (i) => i).map((e) {
                  return Center(
                    child: Text(
                      e <= 9 ? "0$e" : e.toString(),
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
              scrollController: this._minuteScrollController,
              itemExtent: 50,
              onSelectedItemChanged: minuteOnChanged,
              children: [
                ...List<int>.generate(60, (i) => i).map((e) {
                  return Center(
                    child: Text(
                      e <= 9 ? "0$e" : e.toString(),
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
