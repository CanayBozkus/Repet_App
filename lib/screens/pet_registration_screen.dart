import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/screens/login_screen.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/utilities/helpers.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/spinner.dart';

class PetRegistrationScreen extends StatefulWidget {
  static const routeName = 'PetRegistrationScreen';
  final newUser;

  PetRegistrationScreen({this.newUser});

  @override
  _PetRegistrationScreenState createState() => _PetRegistrationScreenState();
}

class _PetRegistrationScreenState extends State<PetRegistrationScreen> {
  PetModel _petModel = PetModel();
  final _formGen = FormGenerator();
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  String _formName = 'pet';
  int _formIndex = 0;
  bool _isCreating = false;
  //TODO: UserModel.createUser() sırasında spinner gösterecek şekilde ayarla
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return  Scaffold(
      appBar: BaseAppBar(
        title: 'Evcil Hayvan',
        context: context,
        reverseColor: true,
        activeBackButton: true,
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
                    !(_isCreating) ? BaseButton(
                      text: _formName == 'pet' || _formIndex == 0 ? 'Ileri' : 'Bitir',
                      onPressed: () async {
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
                              _isCreating = true;
                            }
                          }
                        });
                         if(_isCreating){
                           if(context.read<GeneralProviderData>().currentUser != widget.newUser){
                             bool isConnected = await checkInternetConnection();
                             if(!isConnected){
                               showDialog(
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
                               return;
                             }
                             bool userResult = await widget.newUser.createUser();
                             if(userResult){
                               //TODO: ilk eklenecek hayvanı UserModel.createUser() içerisinde gerçekleşecek şekilde ayarla
                               bool petResult = await widget.newUser.addPet(_petModel, true);
                               if(petResult){
                                 await widget.newUser.signOut();
                                 Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                               }
                             }
                           }
                           else{
                             bool petResult = await context.read<GeneralProviderData>().currentUser.addPet(_petModel, false);
                             context.read<GeneralProviderData>().updatePetsMap(_petModel);
                             if(petResult){
                               Navigator.pop(context);
                             }
                           }
                         }
                      },
                      width: 120,
                    ) : Spinner()
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
