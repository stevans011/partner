//import statements are standard practices in Flutter development to bring in the necessary libraries, custom files, and utilities needed for building a Flutter application.

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:partner/Screens/SplashScreen.dart';
import 'package:partner/Utils/Colors.dart';
import 'package:partner/src/partner_app.dart';

//This is the main entry point of the Dart program.
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const PartnerApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Partner', //set App Display title & Name
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppThemeColor
              .darkBlueColor, //seedColor is the base color that will be used to generate the rest of the color scheme
        ), //colorScheme allows you to customize the color scheme used throughout the application.
        useMaterial3: true, // indicate that the app is using Material Design 3
      ), // theme property is used to define the overall theme of the application
      home:
          const SplashScreen(), // home is used to specify the initial route or screen that will be displayed when the app is launched
    );
  }
}
