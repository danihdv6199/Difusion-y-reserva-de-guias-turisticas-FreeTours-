import 'package:flutter/material.dart';

class MenuProvider extends ChangeNotifier {
  int _selectedMenuOpt = 0;
  final String _rol = '';

  int get selectedMenuOpt {
    return _selectedMenuOpt;
  }

  set selectedMenuOpt(int i) {
    _selectedMenuOpt = i;
    notifyListeners();
  }

  String get rol {
    return _rol;
  }

  set rol(String rol) {
    notifyListeners();
  }
}
