import 'package:flutter/material.dart';
import 'package:freetour_tfg/features/app/ui/theme/app_theme.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData currentTheme;
  bool isLight = true;
  ThemeProvider({required bool isDarkMode})
      : currentTheme = isDarkMode ? AppTheme().dark : AppTheme().light;

  setLightMode() {
    currentTheme = AppTheme().light;
    isLight = true;
    notifyListeners();
  }

  setDarkMode() {
    currentTheme = AppTheme().dark;
    isLight = false;
    notifyListeners();
  }

  bool get isLightMode {
    return isLight;
  }
}
