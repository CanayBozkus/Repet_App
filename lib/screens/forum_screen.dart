import 'package:flutter/material.dart';
import 'package:repetapp/screens/error_screen.dart';
import 'package:repetapp/screens/forum_subscreen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/helpers.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/blog_category_builder.dart';
import 'package:repetapp/widgets/forum_card.dart';
import 'package:repetapp/widgets/forum_newpost.dart';

class ForumScreen extends StatefulWidget {
  static const routeName = 'ForumScreen';

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  Future<bool> isConnectedToInternet;
  PageController _controller;
  bool _isFloatingActionButtonShown = true;
  int _selectedForumScreen = 0;
  bool _isForum = false;
  @override
  void initState() {
     isConnectedToInternet = checkInternetConnection();
     _controller = PageController(
       initialPage: 0,
     );
    super.initState();
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(    
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: _isFloatingActionButtonShown ? FloatingActionButton(
          child: Icon(
            Icons.add,
            color: kPrimaryColor,
            size: 45,
          ),
          backgroundColor: Colors.white,
          onPressed: (){
            Navigator.pushNamed(context, ForumSubScreen.routeName, arguments: ForumNewPost());
          },
        ) : null,
        body: SafeArea(
          child: FutureBuilder(
            builder: (context, snapshots){
              if ((snapshots.connectionState == ConnectionState.none &&
                  snapshots.hasData == null) || snapshots.data == false) {
                //print('project snapshot data is: ${projectSnap.data}');
                return ErrorScreen(
                  errorMsg: 'No internet connection found. Please connect to internet and retry.',
                );
              }
              else if(snapshots.connectionState == ConnectionState.waiting){
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BaseButton(
                        text: 'Forum',
                        onPressed: (){
                          setState(() {
                            _isForum = true;
                            _selectedForumScreen = 0;
                            _isFloatingActionButtonShown = true;
                            _controller.animateToPage(_selectedForumScreen, duration: Duration(milliseconds: 500), curve: Curves.easeOut,);
                          });
                        },
                        width: 150,
                        empty: !_isForum,
                      ),
                      BaseButton(
                        text: 'Blog',
                        onPressed: (){
                          setState(() {
                            _isForum = false;
                            _selectedForumScreen = 1;
                            _isFloatingActionButtonShown = false;
                            _controller.animateToPage(_selectedForumScreen, duration: Duration(milliseconds: 500), curve: Curves.easeOut,);
                          });
                        },
                        width: 150,
                        empty: _isForum,
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Expanded(
                    child: PageView(
                      controller: _controller,
                      onPageChanged: (index){
                        setState(() {
                          _selectedForumScreen = index;
                          _isForum = index == 0;
                          _isFloatingActionButtonShown = index == 0;
                        });
                      },
                      children: [
                        ListView(
                          padding: generalScreenPadding.add(EdgeInsets.symmetric(vertical: 5)),
                          children: [
                            ForumCard(),
                            ForumCard(),
                            ForumCard(),
                            ForumCard(),
                            ForumCard(),
                            ForumCard(),
                          ],
                        ),
                        ListView(
                          children: [
                            BlogCategoryBuilder(),
                            Padding(
                              padding: generalScreenPadding.add(EdgeInsets.symmetric(vertical: 5)),
                              child: Column(
                                children: [
                                  ForumCard(),
                                  ForumCard(),
                                  ForumCard(),
                                  ForumCard(),
                                  ForumCard(),
                                  ForumCard(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            future: isConnectedToInternet,
          ),
        ),
        bottomNavigationBar: BaseBottomBar(
          pageNumber: 4,
        ),
      ),
    );
  }
}