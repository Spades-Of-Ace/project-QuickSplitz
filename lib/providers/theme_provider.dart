import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData;
  ThemeData get themeData => _themeData;

  ThemeProvider(this._themeData);

  void setTheme(ThemeData theme) async {
    _themeData = theme;
    notifyListeners();

    // Save theme choice
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String themeName = theme == ThemeData.dark()
        ? "dark"
        : theme == elegantGoldTheme
        ? "gold"
        : "pixel";
    prefs.setString('theme', themeName);
  }

  static Future<ThemeData> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? themeName = prefs.getString('theme');

    if (themeName == "gold") return elegantGoldTheme;
    if (themeName == "pixel") return pixelRetroTheme;
    return ThemeData.dark();
  }
}

// Elegant Gold Theme
final ThemeData elegantGoldTheme = ThemeData(
  primaryColor: Colors.orange[300],
  scaffoldBackgroundColor: Colors.orange[200],
  appBarTheme: AppBarTheme(backgroundColor: Colors.orange[300]),
  textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.orange[200])),
);

// Pixel Retro Theme
final ThemeData pixelRetroTheme = ThemeData(
  primaryColor: Colors.blueGrey,
  scaffoldBackgroundColor: Colors.teal.shade900,
  appBarTheme: AppBarTheme(backgroundColor: Colors.blueGrey),
  textTheme: TextTheme(bodyLarge: TextStyle(color: Colors.lightGreenAccent)),
);
