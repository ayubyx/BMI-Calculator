import 'package:bmi_calculator/theme/theme.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{
   ThemeData _themeData = lightMode;

  ThemeData get getThemeData => _themeData;

  set newThemeData(ThemeData themeData){
    _themeData = themeData; 
    notifyListeners();
  }

  void switchToDarkMode(){
    newThemeData = darkMode;
    notifyListeners();
  }
  
  void switchToLightMode(){
    newThemeData = lightMode;
    notifyListeners();
  }
}