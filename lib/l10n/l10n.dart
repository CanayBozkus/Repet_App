import 'package:flutter/material.dart';

class L10n {

  static final languages = {
    'en': 'English',
    'tr': 'Türkçe'
  };

  static final all = L10n.languages.keys.map((e) => Locale(e)).toList();

}