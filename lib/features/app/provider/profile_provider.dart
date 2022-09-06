import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  GlobalKey<FormState> profile = GlobalKey();

  String email = '';
  String name = '';
  String rol = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  isValidEmail(String value) {
    return EmailValidator.validate(value) ? null : 'Formato incorrecto';
  }

  isValidName(value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Ingrese su nombre';
    }
  }

  isValidRol(value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Seleccione un tipo de usuario';
    }
  }

  bool isValidForm() {
    return profile.currentState?.validate() ?? false;
  }
}
