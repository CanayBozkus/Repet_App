import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PetRegistrationScreen extends StatefulWidget {
  static const routeName = 'PetRegistrationScreen';
  final newUser;

  PetRegistrationScreen({this.newUser});

  @override
  _PetRegistrationScreenState createState() => _PetRegistrationScreenState();
}

class _PetRegistrationScreenState extends State<PetRegistrationScreen> {
  PetModel _petModel = PetModel();
  bool isDog = true;
  final _formGen = FormGenerator();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _formName = 'pet';
  int _formIndex = 0;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Evcil Hayvan',
          style: Theme.of(context)
              .appBarTheme
              .textTheme
              .headline6
              .copyWith(color: Colors.white),
        ),
        leading: Container(),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: width * 0.05,
              vertical: height*0.05,
            ),
            color: Color(0xfffffbf8),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: _formName == 'pet' ?
                _formGen.petRegisterForm(petModel: _petModel, key: _formKey, stateController: setState, width: width, height: height)
                  : _formGen.petHealthForm(petModel: _petModel, key: _formKey, formIndex: _formIndex, stateController: setState, width: width, height: height),
                ),
                SizedBox(height: 10,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _formName == 'health' ? BaseButton(
                      text: 'Geri',
                      onPressed: (){
                        setState(() {
                          if(_formIndex == 1){
                            _formIndex = 0;
                          }
                          else if(_formIndex == 0 && _formName == 'health'){
                            _formName = 'pet';
                          }
                        });
                      },
                      width: 120,
                    ) : SizedBox.shrink(),
                    BaseButton(
                      text: _formName == 'pet' || _formIndex == 0 ? 'Ileri' : 'Bitir',
                      onPressed: (){
                        setState(() {
                          if(_formName == 'pet'){
                            if(_formKey.currentState.validate()){
                              _formKey.currentState.save();
                              _formName = 'health';
                            }
                          }
                          else {
                            if(_formIndex == 0){
                              _formIndex = 1;
                            }
                            else {
                              print('save');
                            }
                          }
                        });
                      },
                      width: 120,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
