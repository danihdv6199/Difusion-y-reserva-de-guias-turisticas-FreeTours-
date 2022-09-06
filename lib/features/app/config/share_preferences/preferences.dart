import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static late SharedPreferences _prefs;
  static String _nombre = '';
  static String _email = '';

  static bool _isDarkMode = false;
  static int _genero = 1;
  static int _edad = 0;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  ///------------------------------------------ Nombre ---------------------------------
  static String get nombre {
    return _prefs.getString('nombre') ?? _nombre;
  }

  static set nombre(String value) {
    _nombre = nombre;
    _prefs.setString('nombre', nombre);
  }

  ///------------------------------------------ Email ---------------------------------
  static String get email {
    return _prefs.getString('email') ?? _email;
  }

  static set email(String value) {
    _email = email;
    _prefs.setString('email', email);
  }

  ///------------------------------------------ Theme Mode ---------------------------------
  static bool get isDarkMode {
    return _prefs.getBool('isDarkMode') ?? _isDarkMode;
  }

  static set isDarkMode(bool value) {
    _isDarkMode = value;
    _prefs.setBool('isDarkMode', value);
  }

  ///------------------------------------------ Genero ---------------------------------
  static int get genero {
    return _prefs.getInt('genero') ?? _genero;
  }

  static set genero(int value) {
    _genero = value;
    _prefs.setInt('genero', value);
  }

  ///------------------------------------------ Rol ---------------------------------
  static int get edad {
    return _prefs.getInt('edad') ?? _edad;
  }

  static set edad(int value) {
    _edad = edad;
    _prefs.setInt('edad', value);
  }
}
