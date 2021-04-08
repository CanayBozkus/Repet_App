import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/widgets/base_app_bar.dart';
import 'package:repetapp/utilities/general_provider_data.dart';
import 'package:provider/provider.dart';
import 'package:repetapp/widgets/pet_health_form.dart';
import 'package:repetapp/widgets/pet_register_form.dart';

class PetRegistrationScreen extends StatefulWidget {
  static const routeName = 'PetRegistrationScreen';

  @override
  _PetRegistrationScreenState createState() => _PetRegistrationScreenState();
}

class _PetRegistrationScreenState extends State<PetRegistrationScreen> {
  PetModel _petModel = PetModel();
  PageController _controller;

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
              vertical: 20,
            ),
            color: Color(0xfffffbf8),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: PageView(
                    controller: _controller,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      PetRegisterForm(petModel: _petModel, controller: _controller,),
                      PetHealthForm(petModel: _petModel, parentController: _controller,),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
