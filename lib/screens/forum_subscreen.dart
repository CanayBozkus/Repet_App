import 'package:flutter/material.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';

class ForumSubScreen extends StatelessWidget {
  static const routeName = 'ForumSubScreen';
  ForumSubScreen({
    this.screen,
  });
  final Widget screen;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: SafeArea(
          child: screen,
        ),
        bottomNavigationBar: BaseBottomBar(
          pageNumber: 4,
        ),
      ),
    );
  }
}
