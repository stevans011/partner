import 'package:flutter/material.dart';
import 'package:partner/Utils/Router.dart';
import 'package:partner/Utils/dimensions.dart';

import '../Utils/AppConstents.dart';
import '../Utils/Colors.dart';


//The class HomeScreen extends StatefulWidget, which means it represents a widget that has mutable state. This allows the widget to change its appearance and behavior over time.
class HomeScreen extends StatefulWidget {
  //The constructor is defined to create an instance of the HomeScreen widget. It uses a named parameter key which is passed to the superclass constructor using super.key. Note that the const keyword here indicates that this constructor can be used to create a constant instance of the widget if all its fields are constant.
  const HomeScreen({super.key});

  @override //The @override annotation indicates that this method is intended to override a method from a superclass, usually from a widget's base class.
  State<HomeScreen> createState() => _HomeScreenState();
}

//_HomeScreenState is a private class the state class associated with the HomeScreen widget. in short  it is a state that belongs to the HomeScreen widget.
class _HomeScreenState extends State<HomeScreen> {
  late final _screenWidth = MediaQuery.of(context).size.width; //This line defines width of the screen.that uses the current context and then accesses the size.width property to get the screen width.
  late final _screenHeight = MediaQuery.of(context).size.height;   //This line defines height of the screen.that uses the current context and then accesses the size.height property to get the screen height.

  @override
  //The build() is used to define the UI for the widget based on its current state.
  Widget build(BuildContext context) {
    return Scaffold(
      //The SafeArea widget is used to ensure that its child's content is not obscured by system overlays, such as the system status bar or device notches. It pads its child's content to avoid overlapping with these areas.
      body: SafeArea(
        child: _bodyView(), //The _bodyView() is likely a private method that returns another widget to be displayed as the main content of the Scaffold.
      ),
    );
  }

  Widget _bodyView() {
    //The Container is set to occupy the full screen width and height, as specified by the _screenWidth and _screenHeight variables.
    return Container(
      height: _screenHeight,
      width: _screenWidth,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 7),
      decoration: const BoxDecoration(
        color: AppThemeColor.backGroundColor,
      ),
      //Column widget that contains the main content of the screen, arranged vertically.
      child: Column(
        children: [
          //This method defined in the AppConstants class, returns a widget representing the top bar view with a back button or back icon. The context parameter is passed to this method, allowing it to build the appropriate widget.
          AppConstents().topBarView(context: context),
          //SizedBox with a height of 40 pixels, creating a vertical space between the top bar view and the rest of the content.
          const SizedBox(
            height: 40,
          ),
          Row(
            children: [
              //The Expanded widget takes up the remaining vertically space.
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5), //This padding creates space around the content of the container.
                  child: const Column(
                    children: [
                      //Text widget displays the text "Partner Connected" in the center with a specific font size and color.
                      Text(
                        'Partner Connected',
                        style: TextStyle(
                          color: AppThemeColor.pureBlackColor,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //Text widget displays the text "User Name" in the center with a specific font size and color.
                      Text(
                        'User Name',
                        style: TextStyle(
                          color: AppThemeColor.darkBlueColor,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
              //SizedBox with a width of 15 pixels, creating a vertical space between the top bar view and the rest of the content.
              const SizedBox(
                width: 15,
              ),

              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: const Column(
                    children: [
                      //Text widget displays the text "No of Quiz Finished" in the center with a specific font size and color and weight.
                      Text(
                        'No of Quiz Finished',
                        style: TextStyle(
                          color: AppThemeColor.pureBlackColor,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      //Text widget displays the text "0" in the center with a specific font size and color.
                      Text(
                        '0',
                        style: TextStyle(
                          color: AppThemeColor.darkBlueColor,
                          fontSize: Dimensions.fontSizeDefault,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: AppThemeColor.pureWhiteColor,
              borderRadius: BorderRadius.circular(7), //set container corner radius
            ),
            margin: const EdgeInsets.symmetric(vertical: 10),
            padding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 7,
            ),
            child: const Row(
              children: [
                Expanded(
                  //Text widget displays the text "Generate Statements" in the center with a specific color.
                  child: Text(
                    'Generate Statements',
                    style: TextStyle(
                      color: AppThemeColor.pureBlackColor,
                    ),
                  ),
                ),
                //Display Icon keyboard_arrow_down with color
                Icon(
                  Icons.keyboard_arrow_down,
                  color: AppThemeColor.darkBlueColor,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 100,
          ),
          Center(
            //InkWell is a Flutter widget that provides a rectangular area that responds to touch events. It's commonly used to create buttons or interactive elements.
            child: InkWell(
              //RouterClass is called with the connectScreenRoute function, and the context from the current widget is passed as a parameter.
              onTap: () => RouterClass().connectScreenRoute(context: context),
              child: Container(
                width: 200,
                padding: const EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                //decorate container with background color and give radius of corner
                decoration: BoxDecoration(
                  color: AppThemeColor.grayColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                //Text widget displays the text "Connect with partner" in the center with a specific font size and color.
                child: const Text(
                  'Connect With Partner',
                  style: TextStyle(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          Center(
            //InkWell is a Flutter widget that provides a rectangular area that responds to touch events. It's commonly used to create buttons or interactive elements.
            child: InkWell(
              //RouterClass is called with the choseCategoryScreenRoute function, and the context from the current widget is passed as a parameter.
              onTap: () =>
                  RouterClass().choseCategoryScreenRoute(context: context),
              child: Container(
                width: 200, // give specific height of container
                padding: const EdgeInsets.symmetric(vertical: 5),   //This padding creates space around the content of the container.
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppThemeColor.darkBlueColor,
                  borderRadius: BorderRadius.circular(4),
                ),
                //Display Text "StartQuiz" with specific color
                child: const Text(
                  'Start Quiz',
                  style: TextStyle(
                    color: AppThemeColor.pureWhiteColor,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
