import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/utilities/provided_data.dart';
import 'package:provider/provider.dart';

class PetNavigator extends StatefulWidget {
  PetNavigator({
    this.showDetail = false,
  });
  final bool showDetail;

  @override
  _PetNavigatorState createState() => _PetNavigatorState();
}

class _PetNavigatorState extends State<PetNavigator> {
  Map<String, PetModel> shownPets;

  Map<String, PetModel> showPets(BuildContext context){
    String currentPetIndex = context.read<ProvidedData>().currentShownPetIndex;
    List petIds = context.read<ProvidedData>().currentUser.pets;
    Map<String, PetModel> pets = context.read<ProvidedData>().pets;
    int currentIndex = petIds.indexOf(currentPetIndex);
    int previousIndex = currentIndex -1 < 0 ? currentIndex -1 + petIds.length : currentIndex -1;
    int nextIndex = currentIndex + 1 >= petIds.length ? 0 : currentIndex + 1;
    Map <String, PetModel> shownPets = {};
    shownPets['middle'] = pets[petIds[currentIndex]];

    if(petIds.length == 1){
      shownPets['right'] = null;
      shownPets['left'] = null;
    }
    else if(previousIndex == nextIndex) {
      shownPets['right'] = pets[petIds[nextIndex]];
      shownPets['left'] = null;
    }
    else {
      shownPets['right'] = pets[petIds[nextIndex]];
      shownPets['left'] = pets[petIds[previousIndex]];
    }

    return shownPets;
  }

  @override
  Widget build(BuildContext context) {
    shownPets = showPets(context);
    return Container(
      height: widget.showDetail ? 220 : 130,
      width: double.maxFinite,
      padding: EdgeInsets.all(5),
      child: Stack(
        children: [
          widget.showDetail ? Positioned(
            bottom: 0,
            left: 0,
            right:0,
            child: DefaultElevation(
              child: Container(
                height: 110,
                padding: EdgeInsets.symmetric(
                    horizontal: 30, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          context.watch<ProvidedData>().pets[context.watch<ProvidedData>().currentShownPetIndex].name,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 24.0,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Container(
                          child: Text(
                            'Pug',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Color(0xff7654ff),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          padding: EdgeInsets.symmetric(
                              vertical: 4, horizontal: 16),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text('Veteriner Kontrolleri Yapıldı'),
                        Text('8 Aylık'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ) : SizedBox.shrink(),
          Positioned(
            bottom: widget.showDetail ? 95 : 0,
            left: 0,
            right: 0,
            child: DefaultElevation(
              child: Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(shape: BoxShape.circle),
                child: SvgPicture.asset(
                  petTypeImages[shownPets['middle'].type],
                  color: petTypeColors[shownPets['middle'].type],
                ),
              ),
              isCircular: true,
            ),
          ),
          shownPets['left'] != null ? Positioned(
            bottom: widget.showDetail ? 120 : 25,
            left: 20,
            child: DefaultElevation(
              isCircular: true,
              child: FlatButton(
                shape: CircleBorder(),
                padding: EdgeInsets.zero,
                onPressed: (){
                  context.read<ProvidedData>().changeCurrentPet(shownPets['left'].id);
                  setState(() {});
                },
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    petTypeImages[shownPets['left'].type],
                    color: petTypeColors[shownPets['left'].type],
                  ),
                ),
              ),
            ),
          ) : SizedBox.shrink(),
          shownPets['right'] != null ? Positioned(
            bottom: widget.showDetail ? 120 : 25,
            right: 20,
            child: DefaultElevation(
              child: FlatButton(
                shape: CircleBorder(),
                padding: EdgeInsets.zero,
                onPressed: (){
                  context.read<ProvidedData>().changeCurrentPet(shownPets['right'].id);
                  setState(() {});
                },
                child: Container(
                  width: 90,
                  height: 90,
                  decoration: BoxDecoration(shape: BoxShape.circle),
                  child: SvgPicture.asset(
                    petTypeImages[shownPets['right'].type],
                    color: petTypeColors[shownPets['right'].type],
                  ),
                ),
              ),
              isCircular: true,
            ),
          ) : SizedBox.shrink(),
        ],
      ),
    );
  }
}