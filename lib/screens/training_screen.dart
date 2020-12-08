import 'package:flutter/material.dart';
import 'package:repetapp/widgets/circular_bottom_bar.dart';

class TrainingScreen extends StatelessWidget {
  static const routeName = 'TrainingScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Text('Test'),
      ),
      bottomNavigationBar: CircularBottomBar(
        width: width,
        height: height,
        pageNumber: 5,
      ),
    );
  }
}
