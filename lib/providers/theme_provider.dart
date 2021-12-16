import 'package:flutter/material.dart';
import 'package:logchain/providers/user_data_provider.dart';
import 'package:logchain/styles/themes.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeProvider();

  get getTheme => UserDataProvider.instance.isDarkThemeOn ? dark : light;

  get isDarkTheme => UserDataProvider.instance.isDarkThemeOn;

  void switchTheme() {
    UserDataProvider.instance.switchTheme();
    notifyListeners();
  }
}
