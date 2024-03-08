//import statements are standard practices in Flutter development to bring in the necessary libraries, custom files, and utilities needed for building a Flutter application.

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:partner/Utils/Router.dart';

import '../Utils/Colors.dart';

//The class SplashScreen extends StatefulWidget, which means it represents a widget that has mutable state. This allows the widget to change its appearance and behavior over time.
class SplashScreen extends StatefulWidget {
  //The constructor is defined to create an instance of the SplashScreen widget. It uses a named parameter key which is passed to the superclass constructor using super.key. Note that the const keyword here indicates that this constructor can be used to create a constant instance of the widget if all its fields are constant.
  const SplashScreen({super.key});

  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //The createState() method returns an instance of _SplashScreenState. This method is called when the widget is inserted into the widget tree and creates the associated mutable state for this widget.
  State<SplashScreen> createState() => _SplashScreenState();
}

//_SplashScreenState is a private class the state class associated with the SplashScreen widget. in short  it is a state that belongs to the SplashScreen widget.
class _SplashScreenState extends State<SplashScreen> {
  late final _screenWidth = MediaQuery.of(context)
      .size
      .width; //This line defines width of the screen.that uses the current context and then accesses the size.width property to get the screen width.
  late final _screenHeight = MediaQuery.of(context)
      .size
      .height; //This line defines height of the screen.that uses the current context and then accesses the size.height property to get the screen height.

  //this method is called when the stateful widget is inserted into the widget tree for the first time
  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  void initState() {
    User? firebaseUser = FirebaseAuth.instance
        .currentUser; // It gets the current Firebase use and This assumes that Firebase Authentication is being used in the project.
    Timer(
        const Duration(
          //specify time duration in second,min,milliSecond,hour,day etc..
          seconds: 3,
        ), () {
      firebaseUser == null
          ? RouterClass().dashBoardScreeRoute(
              context:
                  context) //The RouterClass is contains methods for navigating between screens.
          : RouterClass().loginScreeRoute(context: context);
    }); //After 3 second  it checks if the firebaseUser is not null. If there is a logged-in user, it navigates to the dashboard screen using RouterClass() Otherwise, it navigates to the login screen
    super.initState();
  }

  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
//This is the build method, which is a required method in any widget that extends StatefulWidget or its subclasses. and this  method is called by the Flutter framework whenever the widget needs to be rebuilt.
  Widget build(BuildContext context) {
    //Scaffold is a class in flutter which provides many widgets or we can say APIs like Drawer, Snack-Bar, Bottom-Navigation-Bar, Floating-Action-Button, App-Bar, etc. Scaffold will expand or occupy the whole device screen. It will occupy the available space
    return Scaffold(
      body:
          _bodyView(), //The _bodyView() is likely a private method that returns another widget to be displayed as the main content of the Scaffold.
    );
  }

  Widget _bodyView() {
    return Container(
      //container is a widget/class used to apply styling effects to a widget.
      width: _screenWidth,
      height: _screenHeight,
      //The Container is decorated with a BoxDecoration, which sets the background color to AppThemeColor.darkBlueColor. This color is likely a defined constant or a theme color used in the app.
      decoration: const BoxDecoration(
        color: AppThemeColor.darkBlueColor,
      ),
      //Stack widget allows you to place multiple widgets on top of each other.
      child: Stack(
        alignment: Alignment
            .center, // alignment property set to Alignment.center, which means the child widgets within the Stack will be centered both horizontally and vertically.
        children: [
          // These Image.asset widgets load and display images from the assets of the app.
          Image.asset(
            'images/splashBackground.png', //  loads an image with the asset path
            fit: BoxFit
                .cover, //The fit property is set to BoxFit.cover, which means the image will be scaled to cover the entire available area without distortion.
          ),
          Image.asset('images/inAppIcon.png'),
        ],
      ),
    );
  }
}
