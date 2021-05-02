import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/utilities/constants.dart';
import 'package:repetapp/utilities/form_generator.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    AppLocalizations localized = AppLocalizations.of(context);
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
                    label: localized.name,
                    keyboard: KeyboardTypes.text,
                    initialValue: widget.petModel.name,
                    onsaved: (String value) {
                      widget.petModel.name = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return localized.pleaseEnterYourPetsName;
                      }
                      if (value.contains(RegExp(r'[0-9]'))) {
                        return localized.nameCannotContainNumber;
                      }
                      return null;
                    }
                  ),
                  FormGenerator.addDropdown(
                      categories: [localized.male, localized.female],
                      hint: localized.gender,
                      value: widget.petModel.gender,
                      onChanged: (value) {
                        widget.petModel.gender = value;
                      },
                      validator: (value) {
                        if (value == null) {
                          return localized.pleaseSelectAGender;
                        }
                      }),
                  FormGenerator.addInput(
                    label: localized.species,
                    keyboard: KeyboardTypes.text,
                    initialValue: widget.petModel.name,
                    onsaved: (String value) {
                      widget.petModel.species = value;
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return localized.pleaseEnterYourPetsSpecies;
                      }
                    },
                  ),
                  FormGenerator.addInput(
                    label: '${localized.weight} / ${localized.kg}',
                    keyboard: KeyboardTypes.number,
                    initialValue: widget.petModel.weight != null
                        ? widget.petModel.weight.toString()
                        : null,
                    onsaved: (String value) {
                      widget.petModel.weight = double.parse(value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return localized.pleaseEnterAWeight;
                      }
                      if (double.parse(value) < 1) {
                        return localized.invalidWeight;
                      }
                      return null;
                    },
                  ),
                  FormGenerator.addInput(
                    label: '${localized.height} / ${localized.meter}',
                    keyboard: KeyboardTypes.number,
                    initialValue: widget.petModel.height != null
                        ? widget.petModel.height.toString()
                        : null,
                    onsaved: (String value) {
                      widget.petModel.height = double.parse(value);
                    },
                    validator: (String value) {
                      if (value.isEmpty) {
                        return localized.pleaseEnterAHeight;
                      }
                      if (double.parse(value) < 0.3) {
                        return localized.invalidHeight;
                      }
                      return null;
                    },
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: FormGenerator.addInput(
                          label: localized.year(0) + ' (*)',
                          keyboard: KeyboardTypes.number,
                          initialValue: widget.petModel.year != null
                              ? widget.petModel.year.toString()
                              : null,
                          onsaved: (String value) {
                            widget.petModel.year = int.parse(value);
                          },
                          validator: (String value) {
                            if (value.isEmpty) {
                              return localized.pleaseEnterAYear;
                            }
                            if (double.parse(value) > 40) {
                              return localized.invalidYear;
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
                          label: localized.monthOptional,
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
                              return localized.invalidMonth;
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
                    localized.yourPetsAge,
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
                text: localized.next,
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
