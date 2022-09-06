import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class RegisterFormProvider extends ChangeNotifier {
  GlobalKey<FormState> registerForm = GlobalKey<FormState>();

  String name = '';
  String email = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  //Meátodos que validan correos y contraseñas
  isValidName(String value) {
    if (value.isNotEmpty) {
      return null;
    } else {
      return 'Ingrese su nombre';
    }
  }

  isValidEmail(String value) {
    return EmailValidator.validate(value) ? null : 'Formato incorrecto';
  }

  isValidPassword(String value) {
    if (value.isNotEmpty && value.length >= 6) {
      return null;
    } else {
      return 'La contraseña debe ser de 6 caracteres';
    }
  }

  bool isValidRegisterForm() {
    return registerForm.currentState?.validate() ?? false;
  }
}
