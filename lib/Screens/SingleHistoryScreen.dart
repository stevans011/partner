//import statements are standard practices in Flutter development to bring in the necessary libraries, custom files, and utilities needed for building a Flutter application.
import 'package:flutter/material.dart';
import 'package:partner/Utils/AppConstents.dart';
import 'package:partner/Utils/Router.dart';

import '../Utils/Colors.dart';

//The class SingleHistoryScreen extends StatefulWidget, which means it represents a widget that has mutable state. This allows the widget to change its appearance and behavior over time.
class SingleHistoryScreen extends StatefulWidget {
  //The constructor is defined to create an instance of the SingleHistoryScreen widget. It uses a named parameter key which is passed to the superclass constructor using super.key. Note that the const keyword here indicates that this constructor can be used to create a constant instance of the widget if all its fields are constant.
  const SingleHistoryScreen({super.key});

  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //The createState() method returns an instance of _SingleHistoryScreenState. This method is called when the widget is inserted into the widget tree and creates the associated mutable state for this widget.
  State<SingleHistoryScreen> createState() => _SingleHistoryScreenState();
}


//_SingleHistoryScreenState is a private class the state class associated with the SingleHistoryScreen widget. in short  it is a state that belongs to the SingleHistoryScreen widget.
class _SingleHistoryScreenState extends State<SingleHistoryScreen> {

  late final _screenWidth = MediaQuery.of(context).size.width;  //This line defines width of the screen.that uses the current context and then accesses the size.width property to get the screen width.
  late final _screenHeight = MediaQuery.of(context).size.height;  //This line defines height of the screen.that uses the current context and then accesses the size.height property to get the screen height.

   @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
   //This is the build method, which is a required method in any widget that extends StatefulWidget or its subclasses. and this  method is called by the Flutter framework whenever the widget needs to be rebuilt.
  Widget build(BuildContext context) {
     //Scaffold is a class in flutter which provides many widgets or we can say APIs like Drawer, Snack-Bar, Bottom-Navigation-Bar, Floating-Action-Button, App-Bar, etc. Scaffold will expand or occupy the whole device screen. It will occupy the available space
    return Scaffold(
      //The SafeArea widget is used to ensure that its child's content is not obscured by system overlays, such as the system status bar or device notches. It pads its child's content to avoid overlapping with these areas.
      body: SafeArea(
        child: _bodyView(), //The _bodyView() is likely a private method that returns another widget to be displayed as the main content of the Scaffold.
      ),
    );
  }

  Widget _bodyView() {
     //The Container is set to occupy the full screen width and height, as specified by the _screenWidth and _screenHeight variables.
    return Container(  //container is a widget/class used to apply styling effects to a widget.
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7), //This padding creates space around the content of the container.
      //The Container is decorated with a BoxDecoration, which sets the background color to AppThemeColor.darkBlueColor. This color is likely a defined constant or a theme color used in the app.
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      //Column widget that contains the main content of the screen, arranged vertically.
      child: Column(
        children: [
          AppConstents().topBarViewWithBack(context: context),  //This method defined in the AppConstants class, returns a widget representing the top bar view with a back button or back icon. The context parameter is passed to this method, allowing it to build the appropriate widget.
          //SizedBox with a height of 40 pixels, creating a vertical space between the top bar view and the rest of the content.
          const SizedBox(
            height: 40,
          ),
          //The Expanded widget takes up the remaining vertical space.
          Expanded(
            //Stack widget allows you to place multiple widgets on top of each other.
            child: Stack(
              alignment: Alignment.center, // alignment property set to Alignment.center, which means the child widgets within the Stack will be centered both horizontally and vertically.
              children: [
                Image.asset('images/singleHistoryView.png'),  // These Image.asset widgets load and display images from the assets of the app.
                Column(
                  children: [
                    const Expanded(
                      flex: 4, //flex: 4, which takes up four parts of the available space within the Stack.
                      child: SizedBox(),
                    ),
                    Expanded(
                      flex: 2, //flex: 2, which takes up two parts of the available space within the Stack.
                      //GestureDetector: This widget wraps the middle Expanded widget and listens for tap events. When tapped, it triggers a navigation to the
                      child: GestureDetector(
                        onTap: () => RouterClass().singleCategoryHistoryScreenRoute(context: context), //The RouterClass is contains methods for navigating between screens.
                        child: Container(
                          decoration: const BoxDecoration(
                            color: Colors.transparent,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
