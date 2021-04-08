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
          labelStyle: kSettingsInputLabelStyle,
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

}
