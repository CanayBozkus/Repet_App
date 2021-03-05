import 'package:flutter/material.dart';
import 'package:repetapp/screens/error_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/utilities/helpers.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:repetapp/widgets/blog_category_builder.dart';
import 'package:repetapp/widgets/forum_card.dart';

class ForumScreen extends StatefulWidget {
  static const routeName = 'ForumScreen';

  @override
  _ForumScreenState createState() => _ForumScreenState();
}

class _ForumScreenState extends State<ForumScreen> {
  int selected = 0;
  PageController _controller;
  Future<bool> isConnectedToInternet;
  bool isExpansionExpanded = false;
  ForumCategories selectedCategory = ForumCategories.food;
  String categoryHintText = 'Choose a Type';
  @override
  void initState() {
     _controller = PageController(
      initialPage: 0,
    );
     isConnectedToInternet = checkInternetConnection();
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
        floatingActionButton: selected == 0 ? FloatingActionButton(
          child: Icon(
            Icons.add,
            color: kPrimaryColor,
            size: 45,
          ),
          backgroundColor: Colors.white,
          onPressed: (){},
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
                  Container(
                    height: 100,
                    alignment: Alignment.topCenter,
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 80,
                          child: IconButton(
                            icon: Icon(Icons.clear, size: 32,),
                            onPressed: (){},
                          ),
                        ),
                        Text(
                          'Text Post',
                          style: TextStyle(
                            color: kPrimaryColor,
                            fontSize: 24,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        Container(
                          width: 80,
                          child: FlatButton(
                            onPressed: (){},
                            child: Text(
                              'Post',
                              style: TextStyle(
                                color: kColorBlue,
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  BaseShadow(
                    child: ExpansionPanelList(
                      elevation: 0,
                      dividerColor: Colors.grey.shade400,
                      expandedHeaderPadding: EdgeInsets.zero,
                      expansionCallback: (int index, bool isExpanded){
                        setState(() {
                          isExpansionExpanded = !isExpansionExpanded;
                        });
                      },
                      children: [
                        ExpansionPanel(
                          isExpanded: isExpansionExpanded,
                          canTapOnHeader: true,
                          headerBuilder: (BuildContext context, bool isExpanded) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.public,
                                    color: kPrimaryColor,
                                    size: 28,
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    categoryHintText,
                                    style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                          body: Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ...ForumCategories.values.map((category){
                                  return  RadioListTile<ForumCategories>(
                                    title: Text(kForumCategoryTitles[category]),
                                    value: category,
                                    groupValue: selectedCategory,
                                    onChanged: (ForumCategories value) {
                                      setState(() {
                                        selectedCategory = category;
                                        categoryHintText = kForumCategoryTitles[category];
                                      });
                                    },
                                  );
                                }).toList(),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Form(
                      child: ListView(
                        children: [
                          BaseShadow(
                            child: TextFormField(
                              decoration: InputDecoration(
                                hintText: 'Title',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                                focusColor: kPrimaryColor,
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kPrimaryColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey.shade200,
                                      width: 1.5
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                          BaseShadow(
                            child: TextFormField(
                              maxLines: 10,
                              decoration: InputDecoration(
                                hintText: 'Post text here.',
                                hintStyle: TextStyle(
                                  fontWeight: FontWeight.w700,
                                ),
                                focusColor: kPrimaryColor,
                                contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: kPrimaryColor,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white,
                                      width: 1.5
                                  ),
                                ),
                              ),
                              style: TextStyle(
                                fontSize: 18.0,
                              ),
                            ),
                          ),
                        ],
                      ),
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
/*
Column(
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
                          selected = 0;
                          _controller.animateToPage(selected, duration: Duration(milliseconds: 500), curve: Curves.easeOut,);
                        });
                      },
                      width: 150,
                      empty: !(selected == 0),
                    ),
                    BaseButton(
                      text: 'Blog',
                      onPressed: (){
                        setState(() {
                          selected = 1;
                          _controller.animateToPage(selected, duration: Duration(milliseconds: 500), curve: Curves.easeOut,);
                        });
                      },
                      width: 150,
                      empty: selected == 0,
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                Expanded(
                  child: PageView(
                    controller: _controller,
                    onPageChanged: (index){
                      setState(() {
                        selected = index;
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
 */