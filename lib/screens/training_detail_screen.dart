import 'package:flutter/material.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_bottom_bar.dart';
import 'package:repetapp/widgets/default_elevation.dart';

class TrainingDetailScreen extends StatefulWidget {
  static const routeName = 'TrainingDetailScreen';
  @override
  _TrainingDetailScreenState createState() => _TrainingDetailScreenState();
}

class _TrainingDetailScreenState extends State<TrainingDetailScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: BaseAppBar(title: 'Eğitim', context: context,),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: height * 0.038, horizontal: width * 0.05),
        child: DefaultElevation(
          child: Container(
            height: height * 0.7,
            width: width * 0.9,
            color: Colors.grey.shade50,
            child: Column(
              children: [
                DefaultElevation(
                  child: Container(
                    width: width * 0.9,
                    height: height * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image(
                          image: AssetImage('assets/images/dog-img.jpeg'),
                          height: height * 0.2,
                        ),
                        Text(
                          'Adım 1',
                          style: TextStyle(color: Colors.grey.shade700),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  height: height * 0.3,
                  width: width * 0.9,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                        vertical: height * 0.03, horizontal: width * 0.03),
                    children: [
                      Text(
                        'Köpeklerin sizi mutlu etmek için yapamayacağı ' +
                            'şey yoktur - bu yüzden çoğu kolayca eğitilebilir. ' +
                            'Başlamadan önce, onun bilmesini istediğiniz ' +
                            'temel komutların bir listesini yapın: “otur”, “dur”, ' +
                            '“gel”, “aşağı” veya “hayır” .',
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '(bu daima ileride faydalı olur). ',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: width * 0.9,
                  height: height * 0.08,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: width * 0.15,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          color: Color(0xffffe500),
                          borderRadius: BorderRadius.circular(width * 0.05),
                        ),
                        child: Transform.rotate(
                          angle: 20.0,
                          child: Transform(
                            transform: Matrix4.rotationY(3.141),
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.replay,
                              color: Colors.white,
                              size: height * 0.04,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: height * 0.08,
                        width: width*0.4,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                              height: height * 0.025,
                              width: height * 0.025,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: kPrimaryColor,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                              height: height * 0.025,
                              width: height * 0.025,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                              height: height * 0.025,
                              width: height * 0.025,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade500,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: width * 0.01),
                              height: height * 0.025,
                              width: height * 0.025,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: width * 0.15,
                        height: height * 0.05,
                        decoration: BoxDecoration(
                          color: kPrimaryColor,
                          borderRadius: BorderRadius.circular(width * 0.05),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.white,
                          size: height * 0.04,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BaseBottomBar(
        height: height,
        width: width,
        pageNumber: 5,
      ),
    );
  }
}
