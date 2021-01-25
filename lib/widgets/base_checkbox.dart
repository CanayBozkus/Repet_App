import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';

class BaseCheckBox extends StatelessWidget {
  BaseCheckBox({this.value, this.size = 40.0, this.onChanged, this.color = kPrimaryColor});
  final bool value;
  final double size;
  final Function onChanged;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 3,
      borderRadius: BorderRadius.circular(5),
      child: AnimatedContainer(
        duration: Duration(microseconds: 1500),
        curve: Curves.fastLinearToSlowEaseIn,
        width: size ,
        height: size,
        decoration: BoxDecoration(
          color: value ? color : Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: !value ? Border.all(
              color: Colors.grey.shade300,
              width: 1.5
          ) : null,
        ),
        child: IconButton(
          padding: EdgeInsets.zero,
          icon: Icon(Icons.check, size: (size*3)/4, color: Colors.white,),
          onPressed: (){
            onChanged(!value);
          },
        ),
      ),
    );
  }
}
