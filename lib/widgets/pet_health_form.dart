import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/utilities/helpers.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/spinner.dart';

class PetHealthForm extends StatefulWidget {
  PetHealthForm({this.petModel, this.parentController});
  final PetModel petModel;
  final PageController parentController;
  @override
  _PetHealthFormState createState() => _PetHealthFormState();
}

class _PetHealthFormState extends State<PetHealthForm> {
  PageController _controller;
  int _subPageIndex = 0;
  bool _isCreating = false;
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
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Row(
            children: [
              Expanded(
                child: BaseButton(
                  text: 'Alerji',
                  onPressed: () {
                    setState(() {
                      _subPageIndex = 0;
                      _controller.animateToPage(_subPageIndex, duration: Duration(milliseconds: 500), curve: Curves.easeOut,);
                    });
                  },
                  empty: _subPageIndex != _controller.initialPage,
                ),
              ),
              Expanded(
                child: BaseButton(
                  text: 'Engel',
                  onPressed: () {
                    setState(() {
                      _subPageIndex = 1;
                      _controller.animateToPage(_subPageIndex, duration: Duration(milliseconds: 500), curve: Curves.easeOut,);
                    });
                  },
                  empty: _subPageIndex == _controller.initialPage,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Text(
          'Seçin',
          style: TextStyle(
            color: kPrimaryColor,
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Expanded(
          child: PageView(
            controller: _controller,
            onPageChanged: (index){
              setState(() {
                _subPageIndex = index;
              });
            },
            children: [
              ListView(
                padding: generalScreenPadding,
                children: [
                  ...widget.petModel
                      .getAllergies()
                      .map((e) => FormGenerator.addCheckableListTile(
                    text: e,
                    onTap: () {
                      setState(() {
                        if (widget.petModel.allergies.contains(e)) {
                          widget.petModel.allergies.remove(e);
                        } else {
                          widget.petModel.allergies.add(e);
                        }
                      });

                    },
                    checked: widget.petModel.allergies.contains(e),
                  )).toList(),
                ],
              ),
              ListView(
                padding: generalScreenPadding,
                children: [
                  ...widget.petModel
                      .getDisabilities()
                      .map((e) => FormGenerator.addCheckableListTile(
                    text: e,
                    onTap: () {
                      setState(() {
                        if (widget.petModel.disabilities.contains(e)) {
                          widget.petModel.disabilities.remove(e);
                        } else {
                          widget.petModel.disabilities.add(e);
                        }
                      });

                    },
                    checked: widget.petModel.disabilities.contains(e),
                  )).toList(),
                ],
              ),
            ],
          )
        ),
        SizedBox(height: 10,),
        Padding(
          padding: generalScreenPadding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BaseButton(
                text: 'Geri',
                onPressed: () {
                  if(_subPageIndex == 0){
                    widget.parentController.animateToPage(0, duration: Duration(milliseconds: 500), curve: Curves.easeOut,);
                    return;
                  }
                  setState(() {
                    _subPageIndex = 0;
                    _controller.animateToPage(_subPageIndex, duration: Duration(milliseconds: 500), curve: Curves.easeOut,);
                  });
                },
                width: 120,
              ),
              _isCreating ? Spinner() : BaseButton(
                text: _subPageIndex == 0 ? 'İleri' : 'Bitir',
                onPressed: () async {

                  if(_subPageIndex == 0){
                    return setState(() {
                      _subPageIndex = 1;
                      _controller.animateToPage(_subPageIndex, duration: Duration(milliseconds: 500), curve: Curves.easeOut,);
                    });
                  }

                  bool isConnected = await checkInternetConnection();
                  if(!isConnected){
                    return showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text(
                              'Error',
                              textAlign: TextAlign.center,
                            ),
                            titleTextStyle: TextStyle(
                                color: kPrimaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.w800
                            ),
                            content: Container(
                              height: 100,
                              child: Center(
                                child: Text('No Internet Connection'),
                              ),
                            ),
                          );
                        }
                    );
                  }

                  setState(() {
                    _isCreating = true;
                  });

                  UserModel newUser = context.read<GeneralProviderData>().newUser;

                  if(newUser != null){
                    bool userResult = await newUser.createUser();
                    if(userResult){
                      bool petResult = await newUser.addPet(widget.petModel, true);
                      if(petResult){
                        await newUser.signOut();
                        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                      }
                    }
                  }
                  else{
                    bool petResult = await context.read<GeneralProviderData>().currentUser.addPet(widget.petModel, false);
                    context.read<GeneralProviderData>().updatePetsMap(widget.petModel);
                    if(petResult){
                      Navigator.pop(context);
                    }
                  }

                },
                width: 120,
              )
            ],
          ),
        ),
      ],
    );
  }
}
