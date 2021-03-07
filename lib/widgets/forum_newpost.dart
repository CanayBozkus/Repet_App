import 'package:flutter/material.dart';
import 'package:repetapp/models/forum_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:provider/provider.dart';
import 'base_shadow.dart';

class ForumNewPost extends StatefulWidget {
  @override
  _ForumNewPostState createState() => _ForumNewPostState();
}

class _ForumNewPostState extends State<ForumNewPost> {
  bool _isExpansionExpanded = false;
  String _categoryHintText = 'Choose a Type';
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final ForumModel _forumModel = ForumModel();
  @override
  Widget build(BuildContext context) {
    return  Column(
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
                  onPressed: (){
                    Navigator.pop(context);
                  },
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
                  onPressed: (){
                    if(_formKey.currentState.validate()){

                    }
                  },
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
        Expanded(
          child: Form(
            key: _formKey,
            child: ListView(
              padding: EdgeInsets.symmetric(vertical: 5),
              children: [
                BaseShadow(
                  child: ExpansionPanelList(
                    elevation: 0,
                    dividerColor: Colors.grey.shade400,
                    expandedHeaderPadding: EdgeInsets.zero,
                    expansionCallback: (int index, bool isExpanded){
                      setState(() {
                        _isExpansionExpanded = !_isExpansionExpanded;
                      });
                    },
                    children: [
                      ExpansionPanel(
                        isExpanded: _isExpansionExpanded,
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
                                  _categoryHintText,
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
                                  groupValue: _forumModel.category,
                                  onChanged: (ForumCategories value) {
                                    setState(() {
                                      _forumModel.category = category;
                                      _categoryHintText = kForumCategoryTitles[category];
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
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please enter a title';
                      }
                      return null;
                    },
                    onSaved: (String value){
                      _forumModel.title = value;
                    },
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
                    validator: (String value){
                      if(value.isEmpty){
                        return 'Please enter a text';
                      }
                      return null;
                    },
                    onSaved: (String value){
                      _forumModel.content = value;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
