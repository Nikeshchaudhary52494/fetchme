import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  Brightness brightness = Brightness.light;

  void changeTheme() {
    brightness =
        brightness == Brightness.light ? Brightness.dark : Brightness.light;
    notifyListeners();
  }

  ThemeData get getTheme => theme(brightness);
}

ThemeData theme(Brightness brightness) {
  Color primaryColor = Colors.blue;

  return ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      onBackground: brightness == Brightness.light
          ? const Color.fromARGB(255, 255, 255, 255)
          : const Color.fromRGBO(66, 79, 107, 1),
      seedColor: primaryColor,
      brightness: brightness,
    ),
    scaffoldBackgroundColor: brightness == Brightness.light
        ? const Color.fromARGB(255, 199, 199, 199)
        : const Color.fromRGBO(15, 23, 42, 1),
    appBarTheme: AppBarTheme(
      backgroundColor: brightness == Brightness.light
          ? primaryColor
          : const Color.fromRGBO(30, 41, 59, 1),
    ),
  );
}
