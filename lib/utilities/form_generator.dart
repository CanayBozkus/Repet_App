import 'package:flutter/material.dart';
import 'package:repetapp/models/pet_model.dart';
import 'package:repetapp/widgets/base_button.dart';
import 'package:repetapp/widgets/base_checkbox.dart';
import 'package:repetapp/widgets/default_elevation.dart';
import 'constants.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FormGenerator{

  String _mailValidator(String value){
    if(value.isEmpty){
      return 'Please enter a email!';
    }
    if(!value.contains('@')){
      return 'Invalid email.';
    }
    return null;
  }

  String _passwordValidator(String value){
    if(value.isEmpty){
      return 'Please enter a password!';
    }
    if(value.length < 8){
      return 'Password cannot less than 8 character.';
    }
    return null;
  }

  Function _nameValidatorGenerator(name){
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

  Widget addInput({String label, KeyboardTypes keyboard, bool obsecure, Function validator, Function onsaved, Function onchanged, initialValue}){
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Material(
        elevation: 3,
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

  Widget addDropdown({List categories, Function onChanged, String hint, Function validator, value}){
    return Material(
      elevation: 3,
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

  Widget addListTile({String text, Function onTap, bool checked}){
    return Padding(
      padding: EdgeInsets.symmetric(vertical:6.0),
      child: Material(
        elevation: 3,
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

  Widget settingsPageInput({String label, String svg, bool isEnabled = true}){
    return DefaultElevation(
      child: TextFormField(
        style: TextStyle(
          fontSize: 16,
          color: Color(0xff636363),
          fontWeight: FontWeight.w700,
        ),
        decoration: InputDecoration(
          enabled: isEnabled,
          labelText: label,
          contentPadding: EdgeInsets.symmetric(vertical: 16,),
          prefixIcon: svg != null ? Padding(
            padding: EdgeInsets.all(12.0),
            child: SvgPicture.asset(
              svg,
              color: kPrimaryColor,
            ),
          ) : SizedBox.shrink(),
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
      ),
    );
  }

  Widget userRegisterForm({@required final userModel, @required final key, stateController}){
    return Form(
      key: key,
      child: ListView(
        padding: EdgeInsets.symmetric(horizontal: 2),
        children: [
          this.addInput(label: 'Mail', keyboard: KeyboardTypes.emailAddress,
            onsaved: (String value){
              userModel.email = value;
            },
            validator: _mailValidator,
          ),
          this.addInput(label: 'Password', keyboard: KeyboardTypes.text, obsecure: true,
            onsaved: (String value){
              userModel.password = value;
            },
            validator: _passwordValidator,
            onchanged: (value)=> userModel.password=value,
          ),
          this.addInput(label: 'Password', keyboard: KeyboardTypes.text, obsecure: true,
            validator: (String value){
              if(value != userModel.password){
                return "Passwords does not match!";
              }
              return null;
            },
          ),
          this.addInput(label: 'Name', keyboard: KeyboardTypes.text,
            onsaved: (String value){
              userModel.nameSurname = value;
            },
            validator: _nameValidatorGenerator('your'),
          ),
          this.addInput(label: 'Age', keyboard: KeyboardTypes.number,
            onsaved: (String value){
              userModel.age = int.parse(value);
            },
            validator: (String value){
              if(value.isEmpty){
                return 'Please enter your age! Exp: 21';
              }
            },
          ),
          this.addDropdown(categories:['Male', 'Female'], hint: 'Cinsiyet',
              onChanged: (value){
                userModel.gender = value;
              },
            validator: (value){
              if(value == null){
                return 'Please select a gender!';
              }
            }
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: BaseCheckBox(
                  value: userModel.newsSetterConfirmation,
                  onChanged: (value){
                    stateController((){
                      userModel.newsSetterConfirmation = value;
                    });
                  },
                ),
              ),
              Expanded(
                child: Text(
                  "Repet\’in bana özel kampanya, tanıtım ve fırsatlarından haberdar olmak istiyorum",
                  overflow: TextOverflow.clip,
                ),
              )
            ],
          ),
          SizedBox(height: 3,),
          RichText(
            text: TextSpan(
              text: "Üye olmakla ",
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF6f6f6f),
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                  text: "Kullanım koşullarını ",
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
                TextSpan(
                    text: "onaylamış olursunuz."
                )
              ],
            ),
          ),
          SizedBox(height: 3,),
          RichText(
            text: TextSpan(
              text: "Kişisel verilerinize dair Aydınlatma Metni için  ",
              style: TextStyle(
                fontSize: 14.0,
                color: Color(0xFF6f6f6f),
                fontWeight: FontWeight.w600,
              ),
              children: [
                TextSpan(
                    text: "tıklayınız.",
                  style: TextStyle(
                    color: kPrimaryColor,
                  ),
                ),
              ],
            ),
          )
        ],
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
              DefaultElevation(
                isCircular: true,
                child: FlatButton(
                  onPressed: (){
                    stateController(() {
                      petModel.isDog = !petModel.isDog;
                    });
                  },
                  shape: CircleBorder(),
                  child: Container(
                    width: width * 0.3,
                    height: width * 0.3,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      'assets/icons/dog.svg',
                      color: petModel.isDog ? Color(0xffba892b) : Color(0xffd0d0d0),
                    ),
                  ),
                ),
              ),
              DefaultElevation(
                isCircular: true,
                child: FlatButton(
                  onPressed: (){
                    stateController(() {
                      petModel.isDog = !petModel.isDog;
                    });
                  },
                  shape: CircleBorder(),
                  child: Container(
                    width: width * 0.3,
                    height: width * 0.3,
                    decoration: BoxDecoration(shape: BoxShape.circle),
                    child: SvgPicture.asset(
                      'assets/icons/cat.svg',
                      color: !petModel.isDog ? Color(0xffe86868) : Color(0xffd0d0d0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 12,),
          this.addInput(label: 'Name', keyboard: KeyboardTypes.text, initialValue: petModel.name,
            onsaved: (String value){
              petModel.name = value;
            },
            validator: _nameValidatorGenerator('your pet\'s'),
          ),
          this.addDropdown(categories:['Erkek', 'Dişi'], hint: 'Cinsiyet', value: petModel.gender, onChanged: (value){
            petModel.gender = value;
          },
            validator: (value){
              if(value == null){
                return 'Please select a gender!';
              }
            }
          ),
          this.addInput(label: 'Species', keyboard: KeyboardTypes.text, initialValue: petModel.name,
            onsaved: (String value){
              petModel.species = value;
            },
            validator: (String value){
              if(value.isEmpty){
                return 'Please enter your pet\'s species! Example: Buldog.';
              }
            },
          ),
          this.addInput(label: 'Ağırlık / kg', keyboard: KeyboardTypes.number, initialValue: petModel.weight != null ? petModel.weight.toString() : null,
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
          this.addInput(label: 'Boy / metre', keyboard: KeyboardTypes.number, initialValue: petModel.height != null ? petModel.height.toString() :null,
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
                child: this.addInput(label: 'Yıl (*)', keyboard: KeyboardTypes.number, initialValue: petModel.year != null ? petModel.year.toString() : null,
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
                child: this.addInput(label: 'Ay (optional)', keyboard: KeyboardTypes.number, initialValue:  petModel.month != null ? petModel.month.toString() : null,
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
    return petModel.getAllergies().map((e) => this.addListTile(text: e, onTap: (){
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
    return petModel.getDisabilities().map((e) => this.addListTile(text: e, onTap: (){
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

  Widget personalInfoForm(){
    return Form(
      child: ListView(
        children: [
          settingsPageInput(label: 'mehmet ozgun', svg: 'assets/icons/account.svg'),
          settingsPageInput(label: 'mehmet.ozgun@gmail.com', svg: 'assets/icons/email.svg'),
          settingsPageInput(label: '+905552431183', svg: 'assets/icons/cellphone.svg'),
          settingsPageInput(label: '03.07.1973', svg: 'assets/icons/cake.svg'),
          settingsPageInput(label: 'Erkek', svg: 'assets/icons/gender.svg'),
        ],
      ),
    );
  }

  Widget addressForm(){
    return Form(
      child: ListView(
        children: [
          settingsPageInput(label: 'Daire veya Bina No',),
          settingsPageInput(label: 'Sokak Adı',),
          settingsPageInput(label: 'İlce',),
          settingsPageInput(label: 'Şehir',),
          settingsPageInput(label: 'Posta Kodu',),
          settingsPageInput(label: 'Ülke',),
        ],
      ),
    );
  }
}
