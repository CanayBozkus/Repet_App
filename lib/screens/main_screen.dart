import 'package:flutter/material.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/screens/error_screen.dart';
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
  UserModel user = UserModel();
  Future dataFuture;

  @override
  void initState() {
    dataFuture = user.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    print(context.read<ProvidedData>().currentUser.nameSurname);
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
            crossAxisAlignment: CrossAxisAlignment.center,
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
                        height: height,
                        width: width,
                        mainText: 'Beslenme',
                        subText: 'Günde 2 defa',
                        svg: 'assets/icons/dog.svg',
                      ),
                      RemainderRow(
                        height: height,
                        width: width,
                        mainText: 'Beslenme',
                        subText: 'Günde 2 defa',
                        svg: 'assets/icons/dog.svg',
                      ),
                      RemainderRow(
                        height: height,
                        width: width,
                        mainText: 'Beslenme',
                        subText: 'Günde 2 defa',
                        svg: 'assets/icons/dog.svg',
                      ),
                      RemainderRow(
                        height: height,
                        width: width,
                        mainText: 'Beslenme',
                        subText: 'Günde 2 defa',
                        svg: 'assets/icons/dog.svg',
                      ),
                      RemainderRow(
                        height: height,
                        width: width,
                        mainText: 'Beslenme',
                        subText: 'Günde 2 defa',
                        svg: 'assets/icons/dog.svg',
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        future: context.read<ProvidedData>().getPets(),
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 1,
      ),
    );
  }
}
