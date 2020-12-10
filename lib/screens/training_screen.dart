import 'package:flutter/material.dart';
import 'package:repetapp/screens/training_detail_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:repetapp/widgets/pet_navigator.dart';
import 'package:repetapp/widgets/training_builder_row.dart';

class TrainingScreen extends StatelessWidget {
  static const routeName = 'TrainingScreen';
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Eğitim',
        ),
        actions: [
          Icon(
            Icons.menu,
          ),
          SizedBox(
            width: 15.0,
          ),
        ],
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            PetNavigator(height: height, width: width),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: width * 0.1),
                children: [
                  DefaultElevation(
                    child: Container(
                      height: height * 0.07,
                      child: TextField(
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
                    ),
                  ),
                  TrainingBuilderRow(
                    height: height,
                    width: width,
                    text: 'Gezdirme Eğitimi',
                    status: TrainingStatus.done,
                    onTap: (){
                      Navigator.pushNamed(context, TrainingDetailScreen.routeName);
                    },
                  ),
                  TrainingBuilderRow(
                    height: height,
                    width: width,
                    text: 'Taramaya Alıştırma',
                    status: TrainingStatus.repeat,
                    onTap: (){},
                  ),
                  TrainingBuilderRow(
                    height: height,
                    width: width,
                    text: 'Banyoya Alıştırma',
                    status: TrainingStatus.notStarted,
                    onTap: (){},
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BaseBottomBar(
        width: width,
        height: height,
        pageNumber: 5,
      ),
    );
  }
}
