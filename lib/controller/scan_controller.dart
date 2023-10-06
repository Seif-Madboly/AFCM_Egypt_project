import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DarkModeController extends GetxController {
  var isDarkMode = false.obs;

  void toggleDarkMode() {
    isDarkMode.value = !isDarkMode.value;
  }


  ThemeData lightTheme = ThemeData(
      primaryColor: Colors.white,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white10,

        elevation: 5.0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      textTheme: TextTheme(
        headline1: TextStyle(
          fontSize: 35.0,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
        headline6: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),buttonTheme: ButtonThemeData(
      buttonColor: Color(0xFF001456)
  )
  );

  ThemeData darkTheme = ThemeData(
    primaryColor: Color(0xFF00061a),
    brightness: Brightness.light,
    scaffoldBackgroundColor:Colors.white,
    appBarTheme: AppBarTheme(
      titleSpacing: 20.0,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      backgroundColor: Colors.white10,

      elevation: 5.0,
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(
        color: Colors.white,
      ),
    ),
    textTheme: TextTheme(
      headline1: TextStyle(
        fontSize: 35.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      headline6: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),
  );
}
