import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PetRegisterForm extends StatefulWidget {
  PetRegisterForm({this.petModel, this.controller});
  final PetModel petModel;
  final PageController controller;
  @override
  _PetRegisterFormState createState() => _PetRegisterFormState();
}

class _PetRegisterFormState extends State<PetRegisterForm> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: generalScreenPadding,
      child: Column(
        children: [
          Expanded(
            child: Form(
              key: _formKey,
              child: ListView(
                padding: EdgeInsets.symmetric(vertical: 5),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BaseShadow(
                        isCircular: true,
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              widget.petModel.type = PetTypes.dog;
                            });
                          },
                          shape: CircleBorder(),
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              petTypeImages[PetTypes.dog],
                              color: widget.petModel.type == PetTypes.dog
                                  ? petTypeColors[PetTypes.dog]
                                  : Color(0xffd0d0d0),
                            ),
                          ),
                        ),
                      ),
                      BaseShadow(
                        isCircular: true,
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              widget.petModel.type = PetTypes.cat;
                            });
                          },
                          shape: CircleBorder(),
                          child: Container(
                            width: 110,
                            height: 110,
                            decoration: BoxDecoration(shape: BoxShape.circle),
                            child: SvgPicture.asset(
                              petTypeImages[PetTypes.cat],
                              color: widget.petModel.type == PetTypes.cat
                                  ? petTypeColors[PetTypes.cat]
                                  : Color(0xffd0d0d0),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  FormGenerator.addInput(
                    label: 'Name',
                    keyboard: KeyboardTypes.text,
                    initialValue: widget.petModel.name,
                    onsaved: (String value) {
                      widget.petModel.name = value;
                    },
                    validator:
                        FormGenerator.nameValidatorGenerator('your pet\'s'),
                  ),
                  FormGenerator.addDropdown(
                      categories: ['Erkek', 'Dişi'],
                      hint: 'Cinsiyet',
                      value: widget.petModel.gender,
                      onChanged: (value) {
                        widget.petModel.gender = value;
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Please select a gender!';
                        }
                      }),
                  FormGenerator.addInput(
                    label: 'Species',
                    keyboard: KeyboardTypes.text,
                    initialValue: widget.petModel.name,
                    onsaved: (String value) {
                      widget.petModel.species = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter your pet\'s species! Example: Buldog.';
                      }
                    },
                  ),
                  FormGenerator.addInput(
                    label: 'Ağırlık / kg',
                    keyboard: KeyboardTypes.number,
                    initialValue: widget.petModel.weight != null
                        ? widget.petModel.weight.toString()
                        : null,
                    onsaved: (String value) {
                      widget.petModel.weight = double.parse(value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter a weight!';
                      }
                      if (double.parse(value) < 1) {
                        return 'Invalid weight';
                      }
                      return null;
                    },
                  ),
                  FormGenerator.addInput(
                    label: 'Boy / metre',
                    keyboard: KeyboardTypes.number,
                    initialValue: widget.petModel.height != null
                        ? widget.petModel.height.toString()
                        : null,
                    onsaved: (String value) {
                      widget.petModel.height = double.parse(value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return 'Please enter a height!';
                      }
                      if (double.parse(value) < 0.3) {
                        return 'Invalid height';
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormGenerator.addInput(
                          label: 'Yıl (*)',
                          keyboard: KeyboardTypes.number,
                          initialValue: widget.petModel.year != null
                              ? widget.petModel.year.toString()
                              : null,
                          onsaved: (String value) {
                            widget.petModel.year = int.parse(value);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return 'Please enter a year! Example: 7';
                            }
                            if (double.parse(value) > 40) {
                              return 'Invalid year. Example: 7';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: FormGenerator.addInput(
                          label: 'Ay (optional)',
                          keyboard: KeyboardTypes.number,
                          initialValue: widget.petModel.month != null
                              ? widget.petModel.month.toString()
                              : null,
                          onsaved: (String value) {
                            widget.petModel.month = int.parse(value);
                          },
                          validator: (String value) {
                            if (value.isNotEmpty &&
                                (double.parse(value) > 12 ||
                                    double.parse(value) < 0)) {
                              return 'Invalid month';
                            }
                            return null;
                          },
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 6,
                  ),
                  Text(
                    'Evcil Hayvanınızın yaşı',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              BaseButton(
                text: 'Ileri',
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  setState(() {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      widget.controller.animateToPage(
                        1,
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeOut,
                      );
                    }
                  });
                },
                width: 120,
              ),
            ],
          )
        ],
      ),
    );
  }
}
