import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/models/user_model.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/base_checkbox.dart';
import 'package:repetapp/widgets/base_shadow.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormGenerator{

  static String mailValidator(String value){
    if(value.isEmpty){
      return 'Please enter a email!';
    }
    if(!value.contains('@')){
      return 'Invalid email.';
    }
    return null;
  }

  static String passwordValidator(String value){
    if(value.isEmpty){
      return 'Please enter a password!';
    }
    if(value.length < 8){
      return 'Password cannot less than 8 character.';
    }
    return null;
  }

  static Function nameValidatorGenerator(name){
    return (String value){
      if(value.isEmpty){
        return 'Please enter $name name!';
      }
      if(value.contains(RegExp(r'[0-9]'))){
        return 'Name cannot contain number.';
      }
      return null;
    };
  }

  static Widget addInput({String label, KeyboardTypes keyboard, bool obsecure, Function validator, Function onsaved, Function onchanged, initialValue}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: BaseShadow(
        borderRadius: BorderRadius.circular(10.0),
        child: TextFormField(
          initialValue: initialValue,
          decoration: InputDecoration(
            labelText: label,
            focusColor: kPrimaryColor,
            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: kPrimaryColor,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                  color: Colors.grey.shade300,
                  width: 1.5
              ),
            ),
          ),
          style: TextStyle(
            fontSize: 18.0,
          ),
          keyboardType: keyBoards[keyboard] ?? TextInputType.text,
          obscureText: obsecure ?? false,
          validator: validator,
          onSaved: onsaved,
          onChanged: onchanged,
        ),
      ),
    );
  }

  static Widget addDropdown({List categories, Function onChanged, String hint, Function validator, value}){
    return BaseShadow(
      borderRadius: BorderRadius.circular(10.0),
      child: DropdownButtonFormField(
        hint: Text(hint),
        style: TextStyle(
          fontSize: 18.0,
          color: Color(0xFF6f6f6f),
        ),
        value: value,
        items: categories.map((e){
          return DropdownMenuItem(
            value: e,
            child: Container(
              child: Text(
                e,
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          focusColor: kPrimaryColor,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: kPrimaryColor,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1.5
            ),
          ),
        ),

        icon: Icon(Icons.arrow_drop_down, color: kPrimaryColor,),
        iconSize: 30,
        validator: validator,
      ),
    );
  }

  static Widget addCheckableListTile({String text, Function onTap, bool checked}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical:6.0),
      child: BaseShadow(
        borderRadius: BorderRadius.circular(10.0),
        child: ListTile(
          title: Text(
            text,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: BaseCheckBox(size: 30.0, value: checked, onChanged: (_) => onTap(), color: Color(0xff79c624),),
          onTap: onTap,
        ),
      ),
    );
  }

  static Widget settingsPageInput({String label, String svg, bool isEnabled = true, Function onChanged, Function validator, KeyboardTypes keyboardType = KeyboardTypes.text, bool disableKeyboard = false}){
    return BaseShadow(
      child: TextFormField(
        keyboardType: keyBoards[keyboardType],
        style: TextStyle(
          fontSize: 16,
          color: kPrimaryColor,
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          enabled: isEnabled && !disableKeyboard,
          labelText: label,
          labelStyle: TextStyle(
            fontSize: 16,
            color: kGreyTextColor,
            fontWeight: FontWeight.w700,
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 12),
          prefixIcon: svg != null ? Padding(
            padding: EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              svg,
              color: kPrimaryColor,
            ),
          ) : null,
          suffixIcon: isEnabled ? Icon(Icons.arrow_forward_ios ,color: kPrimaryColor,) : SizedBox.shrink(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 1.5
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1
            ),
          ),
        ),
        onChanged: onChanged,
        validator: validator,
      ),
    );
  }

  static Widget settingsPageDropdown({List categories, Function onChanged, String hint, Function validator, value, bool isEnabled = true, String svg}){
    return BaseShadow(
      child: DropdownButtonFormField(
        hint: Text(hint),
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff636363),
          fontWeight: FontWeight.w700,
        ),
        value: value,
        items: categories.map((e){
          return DropdownMenuItem(
            value: e,
            child: Container(
              child: Text(
                e,
                style: TextStyle(
                  color: kPrimaryColor,
                ),
              ),
            ),
          );
        }).toList(),
        onChanged: onChanged,
        decoration: InputDecoration(
          enabled: isEnabled,
          contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 5),
          prefixIcon: svg != null ? Padding(
            padding: EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              svg,
              color: kPrimaryColor,
            ),
          ) : SizedBox.shrink(),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey.shade200,
                width: 1.5
            ),
          ),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.grey.shade300,
                width: 1
            ),
          ),
        ),

        icon: Icon(Icons.arrow_drop_down, color: kPrimaryColor,),
        iconSize: 30,
        validator: validator,
      ),
    );
  }

  Widget petRegisterForm({@required final petModel, @required final key, stateController, double width, double height}){
    return Form(
      key: key,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 2),
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              BaseShadow(
                isCircular: true,
                child: FlatButton(
                  onPressed: (){
                    stateController(() {
                      petModel.type = PetTypes.dog;
                    });
                  },
                  shape: CircleBorder(),
                  child: Container(
                    width: width * 0.3,
                    height: width * 0.3,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      petTypeImages[PetTypes.dog],
                      color: petModel.type == PetTypes.dog ? petTypeColors[PetTypes.dog] : Color(0xffd0d0d0),
                    ),
                  ),
                ),
              ),
              BaseShadow(
                isCircular: true,
                child: FlatButton(
                  onPressed: (){
                    stateController(() {
                      petModel.type = PetTypes.cat;
                    });
                  },
                  shape: CircleBorder(),
                  child: Container(
                    width: width * 0.3,
                    height: width * 0.3,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      petTypeImages[PetTypes.cat],
                      color: petModel.type == PetTypes.cat ? petTypeColors[PetTypes.cat] : Color(0xffd0d0d0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12,),
          FormGenerator.addInput(label: 'Name', keyboard: KeyboardTypes.text, initialValue: petModel.name,
            onsaved: (String value){
              petModel.name = value;
            },
            validator: FormGenerator.nameValidatorGenerator('your pet\'s'),
          ),
          FormGenerator.addDropdown(categories:['Erkek', 'Dişi'], hint: 'Cinsiyet', value: petModel.gender, onChanged: (value){
            petModel.gender = value;
          },
            validator: (value){
              if(value == null){
                return 'Please select a gender!';
              }
            }
          ),
          FormGenerator.addInput(label: 'Species', keyboard: KeyboardTypes.text, initialValue: petModel.name,
            onsaved: (String value){
              petModel.species = value;
            },
            validator: (String value){
              if(value.isEmpty){
                return 'Please enter your pet\'s species! Example: Buldog.';
              }
            },
          ),
          FormGenerator.addInput(label: 'Ağırlık / kg', keyboard: KeyboardTypes.number, initialValue: petModel.weight != null ? petModel.weight.toString() : null,
            onsaved: (String value){
              petModel.weight = double.parse(value);
            },
            validator: (String value){
              if(value.isEmpty){
                return 'Please enter a weight!';
              }
              if(double.parse(value) < 1){
                return 'Invalid weight';
              }
              return null;
            },
          ),
          FormGenerator.addInput(label: 'Boy / metre', keyboard: KeyboardTypes.number, initialValue: petModel.height != null ? petModel.height.toString() :null,
            onsaved: (String value){
              petModel.height = double.parse(value);
            },
            validator: (String value){
              if(value.isEmpty){
                return 'Please enter a height!';
              }
              if(double.parse(value) < 0.3){
                return 'Invalid height';
              }
              return null;
            },
          ),
          Row(
            children: [
              Expanded(
                child: FormGenerator.addInput(label: 'Yıl (*)', keyboard: KeyboardTypes.number, initialValue: petModel.year != null ? petModel.year.toString() : null,
                  onsaved: (String value){
                    petModel.year = int.parse(value);
                  },
                  validator: (String value){
                    if(value.isEmpty){
                      return 'Please enter a year! Example: 7';
                    }
                    if(double.parse(value) > 40){
                      return 'Invalid year. Example: 7';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                child: FormGenerator.addInput(label: 'Ay (optional)', keyboard: KeyboardTypes.number, initialValue:  petModel.month != null ? petModel.month.toString() : null,
                  onsaved: (String value){
                    petModel.month = int.parse(value);
                  },
                  validator: (String value){
                    if(value.isNotEmpty && (double.parse(value) > 12 || double.parse(value) < 0)){
                      return 'Invalid month';
                    }
                    return null;
                  },
                ),
              ),
            ],
          ),
          SizedBox(height: 6,),
          Text(
            'Evcil Hayvanınızın yaşı',
            style: TextStyle(
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget petHealthForm({@required key, @required PetModel petModel, Function stateController, double width, double height, @required int formIndex}){
    return Form(
      child: ListView(
        padding: EdgeInsets.all(4),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width*0.08),
            child: Row(
              children: [
                Expanded(
                  child: BaseButton(
                    text: 'Alerji',
                    onPressed: (){
                    },
                    empty: !(formIndex == 0),
                  ),
                ),
                Expanded(
                  child: BaseButton(
                    text: 'Engel',
                    onPressed: (){

                    },
                    empty: formIndex == 0,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20,),
          Text(
            'Seçin',
            style: TextStyle(
              color: kPrimaryColor,
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10,),
          ...(formIndex == 0 ?
          this._allergiesForm(petModel: petModel, stateController: stateController)
              : this._disabilitiesForm(petModel: petModel, stateController: stateController)),
        ],
      ),
    );
  }

  List _allergiesForm({@required petModel, stateController}){
    return petModel.getAllergies().map((e) => FormGenerator.addCheckableListTile(text: e, onTap: (){
      if(petModel.allergies.contains(e)){
        petModel.allergies.remove(e);
      }
      else {
        petModel.allergies.add(e);
      }
      stateController((){});
      print(petModel.allergies);
    },
      checked: petModel.allergies.contains(e),
    )).toList();
  }

  List _disabilitiesForm({@required petModel, stateController}){
    return petModel.getDisabilities().map((e) => FormGenerator.addCheckableListTile(text: e, onTap: (){
      if(petModel.disabilities.contains(e)){
        petModel.disabilities.remove(e);
      }
      else {
        petModel.disabilities.add(e);
      }
      stateController((){});
      print(petModel.disabilities);
    },
      checked: petModel.disabilities.contains(e),
    )).toList();
  }

}
