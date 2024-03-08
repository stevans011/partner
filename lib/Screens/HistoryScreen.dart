import 'package:flutter/material.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';
import '../Utils/Router.dart';


//The class HistoryScreen extends StatefulWidget, which means it represents a widget that has mutable state. This allows the widget to change its appearance and behavior over time.
class HistoryScreen extends StatefulWidget {
  //The constructor is defined to create an instance of the HistoryScreen widget. It uses a named parameter key which is passed to the superclass constructor using super.key. Note that the const keyword here indicates that this constructor can be used to create a constant instance of the widget if all its fields are constant.
  const HistoryScreen({super.key});

  @override  //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //The createState() method returns an instance of _HistoryScreenState. This method is called when the widget is inserted into the widget tree and creates the associated mutable state for this widget.
  State<HistoryScreen> createState() => _HistoryScreenState();
}

//_HistoryScreenState is a private class the state class associated with the HistoryScreen widget. in short  it is a state that belongs to the HistoryScreen widget.
class _HistoryScreenState extends State<HistoryScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;
  late final _screenHeight = MediaQuery.of(context).size.height;

  @override
  //The build() is used to define the UI for the widget based on its current state.
  Widget build(BuildContext context) {
    //Scaffold is a class in flutter which provides many widgets or we can say APIs like Drawer, Snack-Bar, Bottom-Navigation-Bar, Floating-Action-Button, App-Bar, etc. Scaffold will expand or occupy the whole device screen. It will occupy the available space
    return Scaffold(
      //The SafeArea widget is used to ensure that its child's content is not obscured by system overlays, such as the system status bar or device notches. It pads its child's content to avoid overlapping with these areas.
      body: SafeArea(
        child: _bodyView(),
      ),
    );
  }

  Widget _bodyView() {
    //The Container is set to occupy the full screen width and height, as specified by the _screenWidth and _screenHeight variables.
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7), //This padding creates space around the content of the container.
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      //Column widget that contains the main content of the screen, arranged vertically.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,  //Aligns the children at the left side of the Column.
        children: [
          //This method defined in the AppConstants class, returns a widget representing the top bar view with a back button or back icon. The context parameter is passed to this method, allowing it to build the appropriate widget.
          AppConstents().topBarView(context: context),
          //SizedBox with a height of 40 pixels, creating a vertical space between the top bar view and the rest of the content.
          const SizedBox(
            height: 40,
          ),
          //  This is a function or method that returns a widget representing a single tab view
          _singleTabView(),
          _singleTabView(),
        ],
      ),
    );
  }

  Widget _singleTabView() {
// This widget detects gestures (e.g., taps) and triggers the specified onTap callback when the widget is tapped.
// In this case, when the user taps on this widget,
    return GestureDetector(
      // it will call RouterClass().singleHistoryScreenRoute(context: context) to navigate to the single history screen route.
      onTap: () => RouterClass().singleHistoryScreenRoute(context: context),
       //The Container is set to occupy the full screen width , as specified by the _screenWidth variables.
      child: Container(
        width: _screenWidth,
        //Adds a decoration to the container. It sets the background color  and provides rounded corners.
        decoration: BoxDecoration(
          color: AppThemeColor.pureWhiteColor,
          borderRadius: BorderRadius.circular(4),
        ),
        margin: const EdgeInsets.symmetric(vertical: 8),  //The container has vertical margin of 8 pixels, providing spacing between this container and other elements.
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7), //This padding creates space around the content of the container.
        child: Row(
          children: [
            // These Image.asset widgets load and display images from the assets of the app with specific width.
            Image.asset(
              'images/profile.png',
              width: 40,
            ),
            // SizedBox is used to add some spacing horizontally.
            const SizedBox(
              width: 10,
            ),
            //The Expanded widget takes up the remaining horizontal space.
            const Expanded(
              //Column widget that contains the main content of the screen, arranged horizontally.
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, //Aligns the children at the left side of the Column.
                children: [
                  //Display Text "UserName" with specific color size and weight
                  Text(
                    'Username',
                    style: TextStyle(
                      color: AppThemeColor.pureBlackColor,
                      fontSize: Dimensions.fontSizeDefault,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  //Display Text "Phone no" with specific color size and weight
                  Text(
                    'Phone no',
                    style: TextStyle(
                      color: AppThemeColor.dullFontColor,
                      fontSize: Dimensions.fontSizeSmall,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
            const Column(
              crossAxisAlignment: CrossAxisAlignment.end,// Aligns the children at the right side of the column.
              children: [
                //Text widget displays a timestamp in the format '00 : 00 : 00 MM/DD/YYYY' with a specific text style.
                Text(
                  '00 : 00 : 00 MM/DD/YYYY',
                  style: TextStyle(
                    color: AppThemeColor.pureBlackColor,
                    fontSize: Dimensions.fontSizeExtraSmall,
                  ),
                ),
                // Adds a fixed-width space of 7 pixels between the image and the next element.
                SizedBox(
                  height: 7,
                ),
                Row(
                  children: [
                    //Text widgets displayed side by side. The first displays '60 % ' with a specific text style, and the second displays 'is Matching' with another text style.
                    Text(
                      '60 % ',
                      style: TextStyle(
                        color: AppThemeColor.darkBlueColor,
                        fontSize: Dimensions.fontSizeExtraSmall,
                      ),
                    ),
                    Text(
                      'is Matching',
                      style: TextStyle(
                        color: AppThemeColor.pureBlackColor,
                        fontSize: Dimensions.fontSizeExtraSmall,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
