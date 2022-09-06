import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> fogetForm = GlobalKey<FormState>();
  GlobalKey<FormState> lForm = GlobalKey<FormState>();

  String email = '';
  String password = '';
  String emailForget = '';

  bool _isLoading = false;

  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

//Metodos que validan correos y contraseñas
  isValidEmail(String value) {
    return EmailValidator.validate(value) ? null : 'Formato incorrecto';
  }

  isValidEmailForget(String value) {
    return EmailValidator.validate(value) ? null : 'Ingrese un correo valído';
  }

  isValidPassword(String value) {
    if (value.isNotEmpty && value.length >= 6) {
      return null;
    } else {
      return 'La contraseña debe ser de 6 caracteres';
    }
  }

  bool isValidLoginFormForget() {
    return fogetForm.currentState?.validate() ?? false;
  }
}
