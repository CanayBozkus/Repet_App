import 'package:flutter/material.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/screens/error_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/pet_navigator.dart';
import 'package:repetapp/widgets/remainder_row.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  static const routeName = 'MainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _openBottomSheet({String headerText, }){
    final Map routine = context.read<ProvidedData>().pets[context.read<ProvidedData>().currentShownPetIndex].routines[headerText.toLowerCase()];
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context){
        return Column(
          children: [
            Container(
              height: 80,
              decoration: BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    )
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    iconSize: 28,
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 50.0),
                      child: Text(
                        headerText,
                        style: TextStyle(
                          fontSize: 20,
                          color: kPrimaryColor,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  ...routine.keys.map((e){
                    return Container(
                      height: 70,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.shade300,
                              width: 1,
                            )
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            e,
                            style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Switch(
                            value: routine[e],
                            onChanged: (value){
                              routine[e] = value;
                            },
                          )
                        ],
                      ),
                    );
                  }).toList(),
                ],
              ),
            ),
            Container(
              height: 60,
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: 5),
              decoration: BoxDecoration(
                border: Border(
                    top: BorderSide(
                      color: Colors.grey.shade300,
                      width: 1,
                    )
                ),
              ),
              child: Material(
                elevation: 3,
                shape: CircleBorder(),
                child: FlatButton(
                  shape: CircleBorder(),
                  child: Container(
                    child: Icon(Icons.add, size: 36, color: kPrimaryColor,),
                    padding: EdgeInsets.all(4),
                  ),
                  onPressed: (){},
                  padding: EdgeInsets.zero,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
  Future<bool> getMainScreenData() async {
    await context.read<ProvidedData>().getUserData();
    await context.read<ProvidedData>().getPets();
    return true;
  }
  Future<bool> _isLoading;
  @override
  void initState() {
    _isLoading = getMainScreenData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: BaseAppBar(title: 'Hatırlatıcı', context: context,),
      body: FutureBuilder(
        builder: (context, snapshots){
          if (snapshots.connectionState == ConnectionState.none &&
              snapshots.hasData == null) {
            //print('project snapshot data is: ${projectSnap.data}');
            return ErrorScreen();
          }
          else if(snapshots.connectionState == ConnectionState.waiting){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return Column(
            children: [
              PetNavigator(
                height: height,
                width: width,
                showDetail: true,
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: height * 0.01,
                  ),
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.08, vertical: height * 0.02),
                    children: [
                      RemainderRow(
                        mainText: 'Feeding',
                        svg: 'assets/icons/feeding.svg',
                        svgColor: Color(0xfff87024),
                        onTap: (){
                          _openBottomSheet(headerText: 'Feeding');
                        },
                      ),
                      RemainderRow(
                        mainText: 'Walking',
                        svg: 'assets/icons/walking.svg',
                        svgColor: Color(0xff79c619),
                        onTap: (){
                          _openBottomSheet(headerText: 'Walking');
                        },
                      ),
                      RemainderRow(
                        mainText: 'Water',
                        svg: 'assets/icons/water.svg',
                        svgColor: Color(0xff04a3ff),
                        onTap: (){
                          _openBottomSheet(headerText: 'Water');
                        },
                      ),
                      RemainderRow(
                        mainText: 'Grooming',
                        svg: 'assets/icons/grooming.svg',
                        svgColor: Color(0xff883404),
                        onTap: (){
                          _openBottomSheet(headerText: 'Grooming');
                        },
                      ),
                      RemainderRow(
                        mainText: 'Playing',
                        svg: 'assets/icons/playing.svg',
                        svgColor: Color(0xff79c624),
                        onTap: (){
                          _openBottomSheet(headerText: 'Playing');
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        future: _isLoading,
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 1,
      ),
    );
  }
}
