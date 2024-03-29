import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
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

  Map<String, PetModel> getNavigationPets(BuildContext context){
    String currentPetIndex = context.watch<GeneralProviderData>().currentShownPetIndex;
    List petIds = context.watch<GeneralProviderData>().currentUser.pets;
    Map<String, PetModel> pets = context.watch<GeneralProviderData>().pets;
    int currentIndex = petIds.indexOf(currentPetIndex);
    int previousIndex = (currentIndex -1) % petIds.length;
    int nextIndex = (currentIndex + 1) % petIds.length;
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
    shownPets = getNavigationPets(context);
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
            child: BaseShadow(
              child: Container(
                height: 110,
                padding: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            shownPets['middle'].name,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 24.0,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        SizedBox(width: 10,),
                        Flexible(
                          flex: 4,
                          child: Container(
                            alignment: Alignment.center,
                            child: Text(
                              shownPets['middle'].species,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            decoration: BoxDecoration(
                              color: Color(0xff7654ff),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 4, horizontal: 10),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Expanded(
                          flex: 7,
                          child: Text(
                            'Veteriner Kontrolleri Yapıldı',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: Text(
                            shownPets['middle'].year > 0 ? '${shownPets['middle'].year} years' : '${shownPets['middle'].month} months',
                            style: TextStyle(
                              fontSize: 15,
                            ),
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.end,
                          ),
                        ),
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
            child: BaseShadow(
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
            child: BaseShadow(
              isCircular: true,
              child: FlatButton(
                shape: CircleBorder(),
                padding: EdgeInsets.zero,
                onPressed: (){
                  context.read<GeneralProviderData>().changeCurrentPet(shownPets['left'].id);
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
            child: BaseShadow(
              child: FlatButton(
                shape: CircleBorder(),
                padding: EdgeInsets.zero,
                onPressed: (){
                  context.read<GeneralProviderData>().changeCurrentPet(shownPets['right'].id);
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