import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:repetapp/screens/error_screen.dart';
import 'package:repetapp/services/notification_plugin.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/pet_navigator.dart';
import 'package:repetapp/widgets/remainder_row.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';
import 'package:add_2_calendar/add_2_calendar.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:repetapp/widgets/time_selector.dart';
class MainScreen extends StatefulWidget {
  static const routeName = 'MainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void _openBottomSheet({String headerText, }){
    final pet = context.read<ProvidedData>().pets[context.read<ProvidedData>().currentShownPetIndex];
    final Map routine = pet.routines[headerText.toLowerCase()];
    bool addNew = false;
    int hour = 0;
    int min = 0;
    bool isActive = true;
    ScrollController controller = ScrollController();
    showModalBottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      context: context,
      builder: (context){
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState){
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
                      FlatButton(
                        shape: CircleBorder(),
                        child: Container(
                          child: Icon(Icons.close, size: 36,),
                          padding: EdgeInsets.all(4),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        padding: EdgeInsets.zero,
                      ),
                      Expanded(
                        child: Text(
                          headerText,
                          style: TextStyle(
                            fontSize: 20,
                            color: kPrimaryColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      FlatButton(
                        shape: CircleBorder(),
                        child: Container(
                          child: Icon(Icons.add, size: 36, color: kPrimaryColor,),
                          padding: EdgeInsets.all(4),
                        ),
                        onPressed: (){
                          controller.jumpTo(0);
                          setState(() {
                            addNew = true;
                          });
                        },
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    controller: controller,
                    children: [
                      addNew ? Container(
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(height: 5,),
                                Container(
                                  alignment: Alignment.center,
                                  width: double.maxFinite,
                                  height: 90,
                                  child: TimeSelector(hourOnChanged: (value) => hour = value, minuteOnChanged: (value) => min = value, center: true,),
                                ),
                                SizedBox(height: 15,),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    BaseButton(
                                      width: 80,
                                      fontSize: 13,
                                      text: 'Delete',
                                      onPressed: (){},
                                      backgroundColor: kColorRed,
                                    ),
                                    SizedBox(width: 10,),
                                    BaseButton(
                                      width: 80,
                                      fontSize: 13,
                                      text: 'Done',
                                      onPressed:() async {
                                        DateTime time = DateTime(2000,7,30,hour,min, 0);
                                        await Provider.of<ProvidedData>(context, listen: false).addNewRemainder(pet, headerText, time);
                                        setState(() {
                                          print(routine);
                                          addNew = false;
                                        });
                                      },
                                      backgroundColor: kColorGreen,
                                    ),
                                  ],
                                )
                              ],
                            ),
                            Positioned(
                              right: 0,
                              child: Switch(
                                value: isActive,
                                onChanged: (value){
                                  setState(() {
                                    isActive = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ) : SizedBox.shrink(),
                      ...routine.keys.map((id){
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
                                routine[id][0],
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Switch(
                                value: routine[id][1],
                                onChanged: (value) async {
                                  if(value){
                                    List timeList = routine[id][0].split(':');
                                    DateTime time = DateTime(2000,7,30,int.parse(timeList[0]), int.parse(timeList[1]), 0);
                                    await Provider.of<ProvidedData>(context, listen: false).currentUser.reActivateRemainder(pet, headerText, time, id);
                                  }
                                  else {
                                    routine[id][1] = value;
                                    await Provider.of<ProvidedData>(context, listen: false).cancelRemainder(pet, id, headerText.toLowerCase());
                                  }
                                  setState(() {
                                    print(routine);
                                  });
                                },
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
  Future<bool> getMainScreenData() async {
    if(context.read<ProvidedData>().isDataFetched){
      return true;
    }
    try{
      await context.read<ProvidedData>().getData();
      return true;
    }

    catch(e){
      print(e);
      return false;
    }
  }
  Future<bool> _isLoading;
  @override
  void initState() {
    _isLoading = getMainScreenData();
    context.read<ProvidedData>().currentUser.setNotificationSettings();
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
          return Padding(
            padding: generalScreenPadding,
            child: Column(
              children: [
                PetNavigator(
                  showDetail: true,
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: height * 0.01,
                    ),
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                          horizontal: 5, vertical: height * 0.02),
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
            ),
          );
        },
        future: _isLoading,
      ),
      bottomNavigationBar: BaseBottomBar(
        width: width,
        pageNumber: 1,
      ),
    );
  }
}
