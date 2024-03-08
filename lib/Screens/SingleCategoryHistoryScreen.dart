//import statements are standard practices in Flutter development to bring in the necessary libraries, custom files, and utilities needed for building a Flutter application.
import 'package:flutter/material.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';

//The class SingleCategoryHistoryScreen extends StatefulWidget, which means it represents a widget that has mutable state. This allows the widget to change its appearance and behavior over time.
class SingleCategoryHistoryScreen extends StatefulWidget {
  //The constructor is defined to create an instance of the SingleCategoryHistoryScreen widget. It uses a named parameter key which is passed to the superclass constructor using super.key. Note that the const keyword here indicates that this constructor can be used to create a constant instance of the widget if all its fields are constant.
  const SingleCategoryHistoryScreen({super.key});

  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  //The createState() method returns an instance of _SingleCategoryHistoryScreenState. This method is called when the widget is inserted into the widget tree and creates the associated mutable state for this widget.
  State<SingleCategoryHistoryScreen> createState() => _SingleCategoryHistoryScreenState();
}

//_SingleCategoryHistoryScreenState is a private class the state class associated with the SingleCategoryHistoryScreen widget. in short  it is a state that belongs to the SingleCategoryHistoryScreen widget.
class _SingleCategoryHistoryScreenState extends State<SingleCategoryHistoryScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width;  //This line defines width of the screen.that uses the current context and then accesses the size.width property to get the screen width.
  late final _screenHeight = MediaQuery.of(context).size.height;      //This line defines height of the screen.that uses the current context and then accesses the size.height property to get the screen height.

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

  bool first = true; //declares a variable named first of type bool and initializes it with the value true.

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
        children: [
          //This method defined in the AppConstants class, returns a widget representing the top bar view with a back button or back icon. The context parameter is passed to this method, allowing it to build the appropriate widget.
          AppConstents().topBarViewWithBack(context: context),
          //SizedBox with a height of 10 pixels, creating a vertical space between the top bar view and the rest of the content.
          const SizedBox(
            height: 10,
          ),
          //Stack widget allows you to place multiple widgets on top of each other.
          Stack(
            alignment: Alignment.bottomCenter, // alignment property set to Alignment.bottomCenter
            children: [
              Row(
                children: [
                  //The Expanded widget takes up the remaining horizontal space.
                  Expanded(
                    child: Container(
                      //Container widget with a BoxDecoration that defines its appearance. The appearance of the Container depends on the value of the variable first.
                      decoration: BoxDecoration(
                        color: first //If first is true, the Container will have a dark blue background color.
                            ? AppThemeColor.darkBlueColor
                            : AppThemeColor.pureWhiteColor, //this line execute if first is false
                        //  circular border radius on the top left and top right corners, giving it a rounded appearance at the top.
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                      ),
                      alignment: Alignment.center,  //set container alignment
                      padding: const EdgeInsets.symmetric(vertical: 10), //set vertically space in container
                      child: Text( //Display Text
                        'Correct Answers',
                        style: TextStyle(
                          color: first
                              ? AppThemeColor.pureWhiteColor
                              : AppThemeColor.dullFontColor,
                        ), // customized text style with condition on fontColor
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  //The Expanded widget takes up the remaining horizontal space.
                  Expanded(
                    child: Container(
                      //Container widget with a BoxDecoration that defines its appearance. The appearance of the Container depends on the value of the variable first.
                      decoration: BoxDecoration(
                          color: !first
                              ? AppThemeColor.darkBlueColor //If first is true, the Container will have a dark blue background color.
                              : AppThemeColor.pureWhiteColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          //border: The Container also has a border width and a color . This creates a thin border around the button, enhancing its visual appearance.
                          border: Border.all(
                            color: AppThemeColor.dullFontColor,
                            width: 1,
                          )),
                      alignment: Alignment.center, //set container text alignment
                      padding: const EdgeInsets.symmetric(vertical: 10),// creates space vertically the content of the container
                      child: Text(
                        'Mistake Answers',
                        style: TextStyle(
                          color: !first
                              ? AppThemeColor.pureWhiteColor
                              : AppThemeColor.dullFontColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              // These Image.asset widgets load and display images from the assets of the app with specific height.
              Image.asset(
                'images/singleCatImage.png',
                height: 100,
              )
            ],
          ),
          //The Expanded widget takes up the remaining vertical space.
          Expanded(

            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10),  // creates space vertically the content of the container
              decoration:
                  const BoxDecoration(color: AppThemeColor.pureWhiteColor), //this line to set background color of container widget
              //ListView.builder widget, which generates a scrollable list with three items. Each item in the list is created by the _singleNotification function.
              child: ListView.builder(
                itemCount: 3, //specifies that the list will contain number of items.
                // itemBuilder is a callback function that is called for each item in the list. It takes two arguments: contextOfList and index.
                itemBuilder: (contextOfList, index) {
                  return _singleNotification(
                    question:
                        '${index + 1}. What is the favourite color of user1 ?',
                    answer:
                        'Lorem ipsum dolor sit amet, consectetuer\nadipiscing elit, sed diam nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat. Ut wisi enim ad minim veniam, quis nostrud exerci tation ',
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  //_singleNotification function returns a widget that represents a single notification item in the list.
  Widget _singleNotification({required String question, required String answer}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10,),//creating space on the left and right sides of the content.
      //Column widget that contains the main content of the screen, arranged vertically.
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Display question with specific color
          Text(
            question,
            style: const TextStyle(
              color: AppThemeColor.darkBlueColor,
            ),
          ),
          //Display answer with specific color
          Text(
            answer,
            style: const TextStyle(
              color: AppThemeColor.pureBlackColor,
            ),
          ),
          //Divider widget to create a horizontal line separator between each notification item.
          const Divider(
            indent: 20, //indent means there will be 20 pixels of indentation on both the left and right sides of the Divider.
            endIndent: 20,
            thickness: 2, // set line thickness
            color: AppThemeColor.pureBlackColor,
          )
        ],
      ),
    );
  }
}
