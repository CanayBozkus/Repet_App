import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/base_button.dart';
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
  @override
  void initState() {
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
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
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
        child: Column(
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
            
            TextField(
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.arrow_drop_down,
                    size: width * 0.1,
                    color: Color(0xff1576d8),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      Icons.search,
                      size: width * 0.08,
                      color: Color(0xff1576d8),
                    ),
                    onPressed: () {},
                  ),
                  hintText: 'Search...'),
              onSubmitted: (value) {},
            ),
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
                    padding: generalScreenPadding.add(EdgeInsets.symmetric(vertical: 5)),
                    children: [
                      BlogCategoryBuilder(),
                      ForumCard(),
                      ForumCard(),
                      ForumCard(),
                      ForumCard(),
                      ForumCard(),
                      ForumCard(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BaseBottomBar(
        pageNumber: 4,
      ),
    );
  }
}
