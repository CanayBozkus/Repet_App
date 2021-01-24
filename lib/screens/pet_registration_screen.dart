import 'package:flutter/material.dart';

class PetRegistrationScreen extends StatelessWidget {
  static const routeName = 'PetRegistrationScreen';
  final newUser;
  PetRegistrationScreen({this.newUser});
  @override
  Widget build(BuildContext context) {
    print(newUser);
    return Container(
      child: Text(newUser.nameSurname),
    );
  }
}
