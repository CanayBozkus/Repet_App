import 'package:flutter/material.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/pet_navigator.dart';

class ProfileScreen extends StatelessWidget {
  static const routeName = 'ProfileScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Profile',
        context: context,
      ),
      body: Column(
        children: [
          PetNavigator(height: height, width: width, showDetail: true,),
        ],
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
      ),
    );
  }
}
