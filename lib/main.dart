// import 'package:afcm_egypt/color.dart';
// import 'package:afcm_egypt/screens/home_screen.dart';
// import 'package:afcm_egypt/screens/splashScreen.dart';
// import 'package:camera/camera.dart';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// late List<CameraDescription> cameras;
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   cameras = await availableCameras();
//   final prefs = await SharedPreferences.getInstance();
//   bool isFirstTime = prefs.getBool("first_time") ?? true;
//
//   runApp(
//     isFirstTime ? const MyApp() : Home(),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       themeMode: ThemeService().getThemeMode(),
//       darkTheme: ThemeService().darkTheme,
//       theme: ThemeService().lightTheme,
//       debugShowCheckedModeBanner: false,
//       home: Splash(),
//     );
//   }
// }
//
//
//
//


import 'package:afcm_egypt_project/screens/home_screen.dart';
import 'package:afcm_egypt_project/screens/splashScreen.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'color.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  cameras = await availableCameras();
  await GetStorage.init();

  final prefs = await SharedPreferences.getInstance();
  bool isFirstTime = prefs.getBool("first_time") ?? true;

  runApp(
    isFirstTime ? const MyApp() : Home(),
  );
}

late List<CameraDescription> cameras;


class MyApp extends StatelessWidget {



  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
       debugShowCheckedModeBanner: false,
      theme: ThemeService().lightTheme,
      darkTheme: ThemeService().darkTheme,
      themeMode:ThemeService().getThemeMode(),
      home:  Splash(),
    );
  }
}

// Home Screen

